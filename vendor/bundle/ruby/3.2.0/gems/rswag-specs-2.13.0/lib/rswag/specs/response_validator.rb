# frozen_string_literal: true

require 'active_support/core_ext/hash/slice'
require 'json-schema'
require 'json'
require 'rswag/specs/extended_schema'

module Rswag
  module Specs
    class ResponseValidator
      def initialize(config = ::Rswag::Specs.config)
        @config = config
      end

      def validate!(metadata, response)
        swagger_doc = @config.get_openapi_spec(metadata[:openapi_spec] || metadata[:swagger_doc])

        validate_code!(metadata, response)
        validate_headers!(metadata, response.headers)
        validate_body!(metadata, swagger_doc, response.body)
      end

      private

      def validate_code!(metadata, response)
        expected = metadata[:response][:code].to_s
        if response.code != expected
          raise UnexpectedResponse,
            "Expected response code '#{response.code}' to match '#{expected}'\n" \
              "Response body: #{response.body}"
        end
      end

      def validate_headers!(metadata, headers)
        header_schemas = (metadata[:response][:headers] || {})
        expected = header_schemas.keys
        expected.each do |name|
          nullable_attribute = header_schemas.dig(name.to_s, :schema, :nullable)
          required_attribute = header_schemas.dig(name.to_s, :required)

          is_nullable = nullable_attribute.nil? ? false : nullable_attribute
          is_required = required_attribute.nil? ? true : required_attribute

          if headers.exclude?(name.to_s) && is_required
            raise UnexpectedResponse, "Expected response header #{name} to be present"
          end

          if headers.include?(name.to_s) && headers[name.to_s].nil? && !is_nullable
            raise UnexpectedResponse, "Expected response header #{name} to not be null"
          end
        end
      end

      def validate_body!(metadata, swagger_doc, body)
        response_schema = metadata[:response][:schema]
        return if response_schema.nil?

        version = @config.get_openapi_spec_version(metadata[:openapi_spec] || metadata[:swagger_doc])
        schemas = definitions_or_component_schemas(swagger_doc, version)

        validation_schema = response_schema
          .merge('$schema' => 'http://tempuri.org/rswag/specs/extended_schema')
          .merge(schemas)

        validation_options = validation_options_from(metadata)

        errors = JSON::Validator.fully_validate(validation_schema, body, validation_options)
        return unless errors.any?

        raise UnexpectedResponse,
              "Expected response body to match schema: #{errors.join("\n")}\n" \
              "Response body: #{JSON.pretty_generate(JSON.parse(body))}"
      end

      def validation_options_from(metadata)
        if metadata.key?(:swagger_strict_schema_validation)
          Rswag::Specs.deprecator.warn('Rswag::Specs: WARNING: This option will be renamed to "openapi_strict_schema_validation" in v3.0')
          is_strict = !!metadata[:swagger_strict_schema_validation]
        else
          is_strict = !!metadata.fetch(:openapi_strict_schema_validation, @config.openapi_strict_schema_validation)
        end

        { strict: is_strict }
      end

      def definitions_or_component_schemas(swagger_doc, version)
        if version.start_with?('2')
          swagger_doc.slice(:definitions)
        else # Openapi3
          if swagger_doc.key?(:definitions)
            Rswag::Specs.deprecator.warn('Rswag::Specs: WARNING: definitions is replaced in OpenAPI3! Rename to components/schemas (in swagger_helper.rb)')
            swagger_doc.slice(:definitions)
          else
            components = swagger_doc[:components] || {}
            { components: components }
          end
        end
      end
    end

    class UnexpectedResponse < StandardError; end
  end
end

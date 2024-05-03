# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|

  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'http://127.0.0.1:3000/'
            }
          }
        }
      ]
    }
  }

  config.openapi_format = :json
  
end

# frozen_string_literal: true

require "abstract_controller"
require "action_dispatch"
require "action_controller/deprecator"
require "action_controller/metal/strong_parameters"
require "action_controller/metal/exceptions"

# = Action Controller
#
# Action Controller is a module of Action Pack.
#
# Action Controller provides a base controller class that can be subclassed to
# implement filters and actions to handle requests. The result of an action is
# typically content generated from views.
module ActionController
  extend ActiveSupport::Autoload

  autoload :API
  autoload :Base
  autoload :Metal
  autoload :Renderer
  autoload :FormBuilder

  eager_autoload do
    autoload :Caching
  end

  autoload_under "metal" do
    autoload :ConditionalGet
    autoload :ContentSecurityPolicy
    autoload :Cookies
    autoload :DataStreaming
    autoload :DefaultHeaders
    autoload :EtagWithTemplateDigest
    autoload :EtagWithFlash
    autoload :PermissionsPolicy
    autoload :Flash
    autoload :Head
    autoload :Helpers
    autoload :HttpAuthentication
    autoload :BasicImplicitRender
    autoload :ImplicitRender
    autoload :Instrumentation
    autoload :Live
    autoload :Logging
    autoload :MimeResponds
    autoload :ParamsWrapper
    autoload :Redirecting
    autoload :Renderers
    autoload :Rendering
    autoload :RequestForgeryProtection
    autoload :Rescue
    autoload :Streaming
    autoload :StrongParameters
    autoload :ParameterEncoding
    autoload :Testing
    autoload :UrlFor
  end

  autoload_under "api" do
    autoload :ApiRendering
  end

  autoload :TestCase,           "action_controller/test_case"
  autoload :TemplateAssertions, "action_controller/test_case"
end

# Common Active Support usage in Action Controller
require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/module/attr_internal"
require "active_support/core_ext/name_error"
require "active_support/inflector"

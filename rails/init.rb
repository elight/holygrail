require 'pathname'
require  Pathname(__FILE__).dirname.parent + 'lib/holygrail'

class ActionController::TestCase
  include ActionController::HolyGrail::FunctionalHooks
end

class ActionController::Integration::Session
  include ActionController::HolyGrail::IntegrationHooks
end

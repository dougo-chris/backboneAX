require "backboneAX/version"

if defined? Rails
  if Rails.version.to_f >= 3.1
    require "backboneAX/engine"    
  end
end

require "backboneAX/backbone_view"
module Sprockets::Helpers::RailsHelper
  include BackboneAX::BackboneView
end

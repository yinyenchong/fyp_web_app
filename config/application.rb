require_relative 'boot'

require 'rails/all'
require "active_storage/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FypWebApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    
    config.active_job.queue_adapter = :sidekiq
    Sidekiq.configure_server { |c| c.redis = { url: ENV['REDIS_URL'] } }

    
    #config.time_zone = 'Kuala Lumpur'
    #config.active_record.default_timezone = :local
    
    
    # nil will use the "default" queue
    # some of these options will not work with your Rails version
    # add/remove as necessary
    config.action_mailer.deliver_later_queue_name = nil # defaults to "mailers"
    config.action_mailbox.queues.routing    = nil       # defaults to "action_mailbox_routing"
    config.active_storage.queues.analysis   = nil       # defaults to "active_storage_analysis"
    config.active_storage.queues.purge      = nil       # defaults to "active_storage_purge"
    config.active_storage.queues.mirror     = nil       # defaults to "active_storage_mirror"
    # config.active_storage.queues.purge    = :low      # alternatively, put purge jobs in the `low` queue
    

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

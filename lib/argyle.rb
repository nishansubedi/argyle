require 'plaid'
require_relative 'argyle/version'
require_relative 'argyle/configuration'
require_relative 'argyle/engine'

module Argyle
  class Error < StandardError; end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.plaid_client
    @plaid_client ||= Plaid::Client.new(
      env: configuration.env,
      client_id: configuration.customer_id,
      secret: configuration.secret,
      public_key: configuration.key
    )
  end
end

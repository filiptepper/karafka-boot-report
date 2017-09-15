# frozen_string_literal: true

# Non Ruby on Rails setup
ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']
Bundler.require(:default, ENV['KARAFKA_ENV'])
Karafka::Loader.load(Karafka::App.root)

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = %w( kafka:9092 )
    config.client_id = 'example_app'
    config.backend = :inline
    config.batch_consuming = true
  end

  consumer_groups.draw do
    topic :example do
      controller ApplicationController
    end
  end
end

KarafkaApp.boot!

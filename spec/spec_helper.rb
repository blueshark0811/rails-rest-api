require 'pundit/rspec'
require_relative "support/request_helper"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    Rails.application.eager_load!
    Searchkick.models.each do |model|
      puts "Reindexing #{model.name}..."
      model.reindex
    end
  #   # and disable callbacks
  #   Searchkick.disable_callbacks
  end

  config.include RequestHelper, type: :request

  # config.around(:each, search: true) do |example|
  #   Searchkick.enable_callbacks
  #   example.run
  #   Searchkick.disable_callbacks
  # end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

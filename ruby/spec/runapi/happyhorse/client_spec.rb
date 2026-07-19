# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::HappyHorse::Client do
  before do
    allow(ConnectionPool).to receive(:new).and_return(instance_double(ConnectionPool))
  end

  after { RunApi.api_key = nil }

  it "exposes video resource accessors" do
    client = described_class.new(api_key: "test-key")
    expect(client.text_to_video).to be_a(RunApi::HappyHorse::Resources::TextToVideo)
    expect(client.image_to_video).to be_a(RunApi::HappyHorse::Resources::ImageToVideo)
    expect(client.edit_video).to be_a(RunApi::HappyHorse::Resources::EditVideo)
  end

  it "raises AuthenticationError without api_key" do
    expect { described_class.new }.to raise_error(RunApi::Core::AuthenticationError, /API key is required/)
  end
end

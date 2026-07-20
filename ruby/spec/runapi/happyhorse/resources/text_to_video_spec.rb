# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::HappyHorse::Resources::TextToVideo do
  let(:http) { instance_double(RunApi::Core::HttpClient) }
  let(:resource) { described_class.new(http) }
  let(:endpoint) { "/api/v1/happyhorse/text_to_video" }

  it "posts happy path" do
    params = {
      model: "happyhorse-text-to-video",
      prompt: "A cardboard city lights up at night",
      output_resolution: "1080p",
      aspect_ratio: "16:9",
      duration_seconds: 5
    }
    expect(http).to receive(:request).with(:post, endpoint, body: params).and_return("id" => "task-t2v-1")

    result = resource.create(**params)
    expect(result.id).to eq("task-t2v-1")
  end

  it "posts character model with reference images" do
    params = {
      model: "happyhorse-character",
      prompt: "Character1 walks through a paper city",
      reference_image_urls: ["https://cdn.runapi.ai/public/samples/reference-1.jpg"],
      output_resolution: "720p",
      aspect_ratio: "9:16",
      duration_seconds: 3
    }
    expect(http).to receive(:request).with(:post, endpoint, body: params).and_return("id" => "task-character-1")

    result = resource.create(**params)
    expect(result.id).to eq("task-character-1")
  end

  it "requires reference_image_urls for character model" do
    expect {
      resource.create(model: "happyhorse-character", prompt: "x")
    }.to raise_error(RunApi::Core::ValidationError, /reference_image_urls is required/)
  end

  it "rejects too many reference_image_urls for character model" do
    expect {
      resource.create(
        model: "happyhorse-character",
        prompt: "x",
        reference_image_urls: Array.new(10) { |i| "https://cdn.runapi.ai/public/samples/reference-#{i}.jpg" }
      )
    }.to raise_error(RunApi::Core::ValidationError, /reference_image_urls must contain between 1 and 9 items/)
  end

  it "rejects reference_image_urls for plain model" do
    expect {
      resource.create(
        model: "happyhorse-text-to-video",
        prompt: "x",
        reference_image_urls: ["https://cdn.runapi.ai/public/samples/reference-1.jpg"]
      )
    }.to raise_error(RunApi::Core::ValidationError, /only supported/)
  end

  it "rejects invalid duration_seconds" do
    expect {
      resource.create(model: "happyhorse-text-to-video", prompt: "x", duration_seconds: 20)
    }.to raise_error(RunApi::Core::ValidationError, /duration_seconds must be an integer/)
  end

  it "rejects string duration_seconds" do
    expect {
      resource.create(model: "happyhorse-text-to-video", prompt: "x", duration_seconds: "5")
    }.to raise_error(RunApi::Core::ValidationError, /duration_seconds must be an integer/)
  end
end

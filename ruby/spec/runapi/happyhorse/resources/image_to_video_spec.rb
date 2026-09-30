# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::HappyHorse::Resources::ImageToVideo do
  let(:http) { instance_double(RunApi::Core::HttpClient) }
  let(:resource) { described_class.new(http) }
  let(:endpoint) { "/api/v1/happyhorse/image_to_video" }

  it "posts happy path" do
    params = {
      model: "happyhorse-image-to-video",
      first_frame_image_url: "https://cdn.runapi.ai/public/samples/image-to-video.jpg",
      prompt: "Bring the still frame to life",
      output_resolution: "720p",
      duration_seconds: 3
    }
    expect(http).to receive(:request).with(:post, endpoint, body: params).and_return("id" => "task-i2v-1")

    result = resource.create(**params)
    expect(result.id).to eq("task-i2v-1")
  end
end

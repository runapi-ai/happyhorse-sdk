# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::HappyHorse::Resources::EditVideo do
  let(:http) { instance_double(RunApi::Core::HttpClient) }
  let(:resource) { described_class.new(http) }
  let(:endpoint) { "/api/v1/happyhorse/edit_video" }

  it "posts happy path" do
    params = {
      model: "happyhorse-edit-video",
      prompt: "Make the source video look cinematic",
      source_video_url: "https://tempfile.runapi.ai/happyhorse/source-5s.mp4",
      reference_image_urls: ["https://cdn.runapi.ai/public/samples/reference-1.jpg"],
      output_resolution: "720p",
      audio_setting: "original"
    }
    expect(http).to receive(:request).with(:post, endpoint, body: params).and_return("id" => "task-edit-1")

    result = resource.create(**params)
    expect(result.id).to eq("task-edit-1")
  end
end

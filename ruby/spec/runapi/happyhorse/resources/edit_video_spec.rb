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

  it "rejects missing source_video_url" do
    expect {
      resource.create(model: "happyhorse-edit-video", prompt: "x")
    }.to raise_error(RunApi::Core::ValidationError, /source_video_url is required/)
  end

  it "rejects too many reference images" do
    expect {
      resource.create(
        model: "happyhorse-edit-video",
        prompt: "x",
        source_video_url: "https://cdn.runapi.ai/public/samples/source.mp4",
        reference_image_urls: Array.new(6) { |i| "https://cdn.runapi.ai/public/samples/reference-#{i}.png" }
      )
    }.to raise_error(RunApi::Core::ValidationError, /reference_image_urls must include/)
  end

  it "rejects invalid audio_setting" do
    expect {
      resource.create(
        model: "happyhorse-edit-video",
        prompt: "x",
        source_video_url: "https://cdn.runapi.ai/public/samples/source.mp4",
        audio_setting: "origin"
      )
    }.to raise_error(RunApi::Core::ValidationError, /audio_setting must be one of: auto, original/)
  end
end

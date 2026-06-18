# frozen_string_literal: true

module RunApi
  module HappyHorse
    # HappyHorse video generation and editing API client.
    #
    # @example
    #   client = RunApi::HappyHorse::Client.new(api_key: "your-api-key")
    #   result = client.text_to_video.run(
    #     model: "happyhorse-text-to-video", prompt: "A horse galloping across a sunset beach"
    #   )
    class Client < RunApi::Core::Client
      # @return [Resources::TextToVideo] Text-to-video generation with optional character consistency.
      attr_reader :text_to_video
      # @return [Resources::ImageToVideo] Image-to-video animation from a first-frame image.
      attr_reader :image_to_video
      # @return [Resources::EditVideo] Video editing with text prompts and reference images.
      attr_reader :edit_video

      def initialize(api_key: nil, **options)
        super
        @text_to_video = Resources::TextToVideo.new(http)
        @image_to_video = Resources::ImageToVideo.new(http)
        @edit_video = Resources::EditVideo.new(http)
      end
    end
  end
end

# frozen_string_literal: true

module RunApi
  module HappyHorse
    class Client
      attr_reader :text_to_video, :image_to_video, :reference_to_video, :edit_video

      def initialize(api_key: nil, **options)
        @api_key = Core::Auth.resolve_api_key(api_key)

        client_options = Core::ClientOptions.new(api_key: @api_key, **options)
        http = client_options.http_client || Core::HttpClient.new(client_options)
        @text_to_video = Resources::TextToVideo.new(http)
        @image_to_video = Resources::ImageToVideo.new(http)
        @reference_to_video = Resources::ReferenceToVideo.new(http)
        @edit_video = Resources::EditVideo.new(http)
      end
    end
  end
end

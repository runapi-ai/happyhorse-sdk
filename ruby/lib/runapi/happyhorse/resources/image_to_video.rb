# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      # HappyHorse image-to-video resource.
      # Animate a still first-frame image into video, guided by an optional text prompt.
      class ImageToVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/image_to_video"

        RESPONSE_CLASS = Types::ImageToVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedImageToVideoResponse

        def initialize(http)
          @http = http
        end

        # Create an image-to-video task and wait until complete.
        #
        # @param params [Hash] image-to-video parameters
        # @return [RunApi::HappyHorse::Types::CompletedImageToVideoResponse] completed task with videos
        def run(options: nil, **params)
          task = create(options: options, **params)
          poll_until_complete { get(task.id, options: options) }
        end

        # Create an image-to-video task.
        #
        # @param params [Hash] image-to-video parameters
        # @return [RunApi::HappyHorse::Types::ImageToVideoResponse] task creation result with id
        def create(options: nil, **params)
          params = compact_params(params)
          request(:post, ENDPOINT, body: params, options: options)
        end

        # Get image-to-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::ImageToVideoResponse] current task status
        def get(id, options: nil)
          request(:get, "#{ENDPOINT}/#{id}", options: options)
        end
      end
    end
  end
end

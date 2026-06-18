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
        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        # Create an image-to-video task.
        #
        # @param params [Hash] image-to-video parameters
        # @return [RunApi::HappyHorse::Types::ImageToVideoResponse] task creation result with id
        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        # Get image-to-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::ImageToVideoResponse] current task status
        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          raise Core::ValidationError, "model is required" unless param(params, :model) == Types::IMAGE_TO_VIDEO_MODEL
          raise Core::ValidationError, "first_frame_image_url is required" unless param(params, :first_frame_image_url)

          validate_optional!(params, :output_resolution, Types::OUTPUT_RESOLUTIONS)
          validate_integer_range!(params, :duration_seconds, Types::DURATION_RANGE)
          validate_integer_range!(params, :seed, Types::SEED_RANGE)
        end

        def validate_integer_range!(params, key, range)
          value = param(params, key)
          return unless value

          return if value.is_a?(Integer) && range.cover?(value)

          raise Core::ValidationError, "#{key} must be an integer between #{range.min} and #{range.max}"
        end
      end
    end
  end
end

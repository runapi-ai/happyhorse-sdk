# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      # HappyHorse edit-video resource.
      # Transform an existing video with a text prompt and optional reference images.
      class EditVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/edit_video"

        RESPONSE_CLASS = Types::EditVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedEditVideoResponse
        REFERENCE_IMAGE_RANGE = (0..5)

        def initialize(http)
          @http = http
        end

        # Create an edit-video task and wait until complete.
        #
        # @param params [Hash] edit-video parameters
        # @return [RunApi::HappyHorse::Types::CompletedEditVideoResponse] completed task with videos
        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        # Create an edit-video task.
        #
        # @param params [Hash] edit-video parameters
        # @return [RunApi::HappyHorse::Types::EditVideoResponse] task creation result with id
        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        # Get edit-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::EditVideoResponse] current task status
        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          raise Core::ValidationError, "model is required" unless param(params, :model) == Types::EDIT_VIDEO_MODEL
          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)
          raise Core::ValidationError, "source_video_url is required" unless param(params, :source_video_url)

          reference_image_urls = param(params, :reference_image_urls)
          if reference_image_urls && (!reference_image_urls.is_a?(Array) || !REFERENCE_IMAGE_RANGE.cover?(reference_image_urls.size))
            raise Core::ValidationError, "reference_image_urls must include at most #{REFERENCE_IMAGE_RANGE.max} entries"
          end

          validate_optional!(params, :output_resolution, Types::OUTPUT_RESOLUTIONS)
          validate_optional!(params, :audio_setting, Types::AUDIO_SETTINGS)
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

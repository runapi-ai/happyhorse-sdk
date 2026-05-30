# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      class EditVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/edit_video"

        RESPONSE_CLASS = Types::EditVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedEditVideoResponse
        REFERENCE_IMAGE_RANGE = (0..5)

        def initialize(http)
          @http = http
        end

        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          raise Core::ValidationError, "model is required" unless param(params, :model) == Types::EDIT_VIDEO_MODEL
          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)
          raise Core::ValidationError, "video_url is required" unless param(params, :video_url)

          reference_image = param(params, :reference_image)
          if reference_image && (!reference_image.is_a?(Array) || !REFERENCE_IMAGE_RANGE.cover?(reference_image.size))
            raise Core::ValidationError, "reference_image must include at most #{REFERENCE_IMAGE_RANGE.max} entries"
          end

          validate_optional!(params, :resolution, Types::RESOLUTIONS)
          validate_optional!(params, :audio_setting, Types::AUDIO_SETTINGS)
          validate_integer_range!(params, :seed, Types::SEED_RANGE)
        end

        def validate_integer_range!(params, key, range)
          value = param(params, key)
          return unless value

          integer = Integer(value, exception: false)
          return if integer && range.cover?(integer)

          raise Core::ValidationError, "#{key} must be an integer between #{range.min} and #{range.max}"
        end
      end
    end
  end
end

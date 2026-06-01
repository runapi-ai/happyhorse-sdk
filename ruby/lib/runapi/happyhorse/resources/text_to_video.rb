# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      class TextToVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/text_to_video"

        RESPONSE_CLASS = Types::TextToVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedTextToVideoResponse
        REFERENCE_IMAGE_URLS_RANGE = (1..9)

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
          model = param(params, :model)
          raise Core::ValidationError, "model is required" unless Types::TEXT_TO_VIDEO_MODELS.include?(model)
          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)

          reference_image_urls = param(params, :reference_image_urls)
          if model == Types::CHARACTER_MODEL
            unless reference_image_urls.is_a?(Array) && REFERENCE_IMAGE_URLS_RANGE.cover?(reference_image_urls.size)
              raise Core::ValidationError, "reference_image_urls must include between #{REFERENCE_IMAGE_URLS_RANGE.min} and #{REFERENCE_IMAGE_URLS_RANGE.max} entries"
            end
          elsif reference_image_urls
            raise Core::ValidationError, "reference_image_urls is only supported for #{Types::CHARACTER_MODEL}"
          end

          validate_optional!(params, :output_resolution, Types::OUTPUT_RESOLUTIONS)
          validate_optional!(params, :aspect_ratio, Types::ASPECT_RATIOS)
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

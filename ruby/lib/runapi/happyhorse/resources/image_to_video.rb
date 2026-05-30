# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      class ImageToVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/image_to_video"

        RESPONSE_CLASS = Types::ImageToVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedImageToVideoResponse
        IMAGE_URLS_MAX = 1

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
          raise Core::ValidationError, "model is required" unless param(params, :model) == Types::IMAGE_TO_VIDEO_MODEL

          image_urls = param(params, :image_urls)
          raise Core::ValidationError, "image_urls is required" unless image_urls.is_a?(Array) && image_urls.any?
          raise Core::ValidationError, "image_urls supports at most #{IMAGE_URLS_MAX} entry" if image_urls.size > IMAGE_URLS_MAX

          validate_optional!(params, :resolution, Types::RESOLUTIONS)
          validate_integer_range!(params, :duration, Types::DURATION_RANGE)
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

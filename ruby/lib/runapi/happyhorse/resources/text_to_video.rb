# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Resources
      # HappyHorse text-to-video resource.
      # Generate video from a text prompt, with optional character consistency via happyhorse-character.
      class TextToVideo
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/happyhorse/text_to_video"

        RESPONSE_CLASS = Types::TextToVideoResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedTextToVideoResponse
        REFERENCE_IMAGE_URLS_RANGE = (1..9)

        def initialize(http)
          @http = http
        end

        # Create a text-to-video task and wait until complete.
        #
        # @param params [Hash] text-to-video parameters
        # @return [RunApi::HappyHorse::Types::CompletedTextToVideoResponse] completed task with videos
        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        # Create a text-to-video task.
        #
        # @param params [Hash] text-to-video parameters
        # @return [RunApi::HappyHorse::Types::TextToVideoResponse] task creation result with id
        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        # Get text-to-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::TextToVideoResponse] current task status
        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          validate_contract!(CONTRACT["text-to-video"], params)

          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)

          reference_image_urls = param(params, :reference_image_urls)
          if param(params, :model) == Types::CHARACTER_MODEL
            if reference_image_urls && !(reference_image_urls.is_a?(Array) && REFERENCE_IMAGE_URLS_RANGE.cover?(reference_image_urls.size))
              raise Core::ValidationError, "reference_image_urls must include between #{REFERENCE_IMAGE_URLS_RANGE.min} and #{REFERENCE_IMAGE_URLS_RANGE.max} entries"
            end
          elsif reference_image_urls
            raise Core::ValidationError, "reference_image_urls is only supported for #{Types::CHARACTER_MODEL}"
          end

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

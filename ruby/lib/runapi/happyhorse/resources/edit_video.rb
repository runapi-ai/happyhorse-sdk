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

        def initialize(http)
          @http = http
        end

        # Create an edit-video task and wait until complete.
        #
        # @param params [Hash] edit-video parameters
        # @return [RunApi::HappyHorse::Types::CompletedEditVideoResponse] completed task with videos
        def run(options: nil, **params)
          task = create(options: options, **params)
          poll_until_complete { get(task.id, options: options) }
        end

        # Create an edit-video task.
        #
        # @param params [Hash] edit-video parameters
        # @return [RunApi::HappyHorse::Types::EditVideoResponse] task creation result with id
        def create(options: nil, **params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params, options: options)
        end

        # Get edit-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::EditVideoResponse] current task status
        def get(id, options: nil)
          request(:get, "#{ENDPOINT}/#{id}", options: options)
        end

        private

        def validate_params!(params)
          validate_contract!(CONTRACT["edit-video"], params)

          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)

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

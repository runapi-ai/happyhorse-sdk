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

        def initialize(http)
          @http = http
        end

        # Create a text-to-video task and wait until complete.
        #
        # @param params [Hash] text-to-video parameters
        # @return [RunApi::HappyHorse::Types::CompletedTextToVideoResponse] completed task with videos
        def run(options: nil, **params)
          task = create(options: options, **params)
          poll_until_complete { get(task.id, options: options) }
        end

        # Create a text-to-video task.
        #
        # @param params [Hash] text-to-video parameters
        # @return [RunApi::HappyHorse::Types::TextToVideoResponse] task creation result with id
        def create(options: nil, **params)
          params = compact_params(params)
          request(:post, ENDPOINT, body: params, options: options)
        end

        # Get text-to-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::TextToVideoResponse] current task status
        def get(id, options: nil)
          request(:get, "#{ENDPOINT}/#{id}", options: options)
        end
      end
    end
  end
end

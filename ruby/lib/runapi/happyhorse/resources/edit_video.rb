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
          request(:post, ENDPOINT, body: params, options: options)
        end

        # Get edit-video task status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::HappyHorse::Types::EditVideoResponse] current task status
        def get(id, options: nil)
          request(:get, "#{ENDPOINT}/#{id}", options: options)
        end
      end
    end
  end
end

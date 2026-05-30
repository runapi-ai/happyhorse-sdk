# frozen_string_literal: true

module RunApi
  module HappyHorse
    module Types
      TEXT_TO_VIDEO_MODEL = "happyhorse-text-to-video"
      IMAGE_TO_VIDEO_MODEL = "happyhorse-image-to-video"
      REFERENCE_TO_VIDEO_MODEL = "happyhorse-reference-to-video"
      EDIT_VIDEO_MODEL = "happyhorse-video-edit"
      RESOLUTIONS = %w[720p 1080p].freeze
      ASPECT_RATIOS = %w[16:9 9:16 1:1 4:3 3:4].freeze
      AUDIO_SETTINGS = %w[auto origin].freeze
      DURATION_RANGE = (3..15)
      SEED_RANGE = (0..2_147_483_647)

      class MediaUrl < RunApi::Core::BaseModel
        optional :url, String
      end

      class TextToVideoResponse < RunApi::Core::TaskResponse
        required :id, String
        optional :status, String, enum: -> { RunApi::Core::TaskResponse::Status::ALL }
        optional :videos, [-> { MediaUrl }]
        optional :error, String
      end

      class CompletedTextToVideoResponse < TextToVideoResponse
        required :videos, [-> { MediaUrl }]
      end

      ImageToVideoResponse = TextToVideoResponse
      CompletedImageToVideoResponse = CompletedTextToVideoResponse
      ReferenceToVideoResponse = TextToVideoResponse
      CompletedReferenceToVideoResponse = CompletedTextToVideoResponse
      EditVideoResponse = TextToVideoResponse
      CompletedEditVideoResponse = CompletedTextToVideoResponse
    end
  end
end

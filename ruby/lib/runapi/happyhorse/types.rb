# frozen_string_literal: true

module RunApi
  module HappyHorse
    # Type definitions and constants for HappyHorse video generation and editing.
    module Types
      # Standard text-to-video model.
      TEXT_TO_VIDEO_MODEL = "happyhorse-text-to-video"
      # Character-consistent model; requires 1-9 reference_image_urls.
      CHARACTER_MODEL = "happyhorse-character"
      # All text-to-video model variants.
      TEXT_TO_VIDEO_MODELS = [TEXT_TO_VIDEO_MODEL, CHARACTER_MODEL].freeze
      IMAGE_TO_VIDEO_MODEL = "happyhorse-image-to-video"
      EDIT_VIDEO_MODEL = "happyhorse-edit-video"
      # Output resolution options. Defaults to 1080p.
      OUTPUT_RESOLUTIONS = %w[720p 1080p].freeze
      # Aspect ratio options. Defaults to 16:9.
      ASPECT_RATIOS = %w[16:9 9:16 1:1 4:3 3:4].freeze
      # Audio handling for video editing: "auto" lets the model decide, "original" preserves source audio.
      AUDIO_SETTINGS = %w[auto original].freeze
      # Duration range in seconds (3-15). Defaults to 5.
      DURATION_RANGE = (3..15)
      # Reproducibility seed range.
      SEED_RANGE = (0..2_147_483_647)

      # A generated video file with a download URL.
      class MediaUrl < RunApi::Core::BaseModel
        optional :url, String
      end

      class TextToVideoResponse < RunApi::Core::TaskResponse
        required :id, String
        optional :status, String, enum: -> { RunApi::Core::TaskResponse::Status::ALL }
        optional :videos, [-> { MediaUrl }]
        optional :error, String
      end

      # Narrowed response returned by +run()+ once polling observes +status: "completed"+.
      # +videos+ is required so consumers never have to null-check it on a successful task.
      class CompletedTextToVideoResponse < TextToVideoResponse
        required :videos, [-> { MediaUrl }]
      end

      ImageToVideoResponse = TextToVideoResponse
      CompletedImageToVideoResponse = CompletedTextToVideoResponse
      EditVideoResponse = TextToVideoResponse
      CompletedEditVideoResponse = CompletedTextToVideoResponse
    end
  end
end

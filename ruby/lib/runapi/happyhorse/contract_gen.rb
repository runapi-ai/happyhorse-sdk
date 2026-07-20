# frozen_string_literal: true

module RunApi
  module HappyHorse
    CONTRACT = {
      "edit-video" => {
        "models" => ["happyhorse-edit-video"],
        "fields_by_model" => {
          "happyhorse-edit-video" => {
            "audio_setting" => {
              "enum" => ["auto", "original"]
            },
            "output_resolution" => {
              "enum" => ["720p", "1080p"]
            },
            "reference_image_urls" => {
              "max_items" => 5
            },
            "seed" => {
              "type" => "integer"
            },
            "source_video_url" => {
              "required" => true
            }
          }
        }
      },
      "image-to-video" => {
        "models" => ["happyhorse-image-to-video"],
        "fields_by_model" => {
          "happyhorse-image-to-video" => {
            "duration_seconds" => {
              "type" => "integer"
            },
            "first_frame_image_url" => {
              "required" => true
            },
            "output_resolution" => {
              "enum" => ["720p", "1080p"]
            },
            "seed" => {
              "type" => "integer"
            }
          }
        }
      },
      "text-to-video" => {
        "models" => ["happyhorse-character", "happyhorse-text-to-video"],
        "fields_by_model" => {
          "happyhorse-character" => {
            "aspect_ratio" => {
              "enum" => ["16:9", "9:16", "1:1", "4:3", "3:4"]
            },
            "duration_seconds" => {
              "type" => "integer"
            },
            "output_resolution" => {
              "enum" => ["720p", "1080p"]
            },
            "reference_image_urls" => {
              "required" => true,
              "min_items" => 1,
              "max_items" => 9
            },
            "seed" => {
              "type" => "integer"
            }
          },
          "happyhorse-text-to-video" => {
            "aspect_ratio" => {
              "enum" => ["16:9", "9:16", "1:1", "4:3", "3:4"]
            },
            "duration_seconds" => {
              "type" => "integer"
            },
            "output_resolution" => {
              "enum" => ["720p", "1080p"]
            },
            "seed" => {
              "type" => "integer"
            }
          }
        }
      }
    }.freeze
  end
end

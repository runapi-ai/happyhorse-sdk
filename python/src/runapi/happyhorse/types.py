"""HappyHorse model lists, enums, and response models."""

from __future__ import annotations

from runapi.core import BaseModel, TaskResponse, optional, required

TEXT_TO_VIDEO_MODEL = "happyhorse-text-to-video"
CHARACTER_MODEL = "happyhorse-character"
TEXT_TO_VIDEO_MODELS = [TEXT_TO_VIDEO_MODEL, CHARACTER_MODEL]
IMAGE_TO_VIDEO_MODEL = "happyhorse-image-to-video"
EDIT_VIDEO_MODEL = "happyhorse-edit-video"
OUTPUT_RESOLUTIONS = ["720p", "1080p"]
ASPECT_RATIOS = ["16:9", "9:16", "1:1", "4:3", "3:4"]
AUDIO_SETTINGS = ["auto", "original"]
DURATION_RANGE = range(3, 16)
SEED_RANGE = range(0, 2_147_483_648)


class MediaUrl(BaseModel):
    url = optional(str)


class TextToVideoResponse(TaskResponse):
    """Response for a video generation task."""

    id = required(str)
    status = optional(str, enum=lambda: TaskResponse.Status.ALL)
    videos = optional([lambda: MediaUrl])
    error = optional(str)


class CompletedTextToVideoResponse(TextToVideoResponse):
    """Narrowed response from ``run()`` once polling observes completion."""

    videos = required([lambda: MediaUrl])


ImageToVideoResponse = TextToVideoResponse
CompletedImageToVideoResponse = CompletedTextToVideoResponse
EditVideoResponse = TextToVideoResponse
CompletedEditVideoResponse = CompletedTextToVideoResponse

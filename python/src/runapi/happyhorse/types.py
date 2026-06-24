"""HappyHorse model lists, enums, and response models."""

from __future__ import annotations

from runapi.core import BaseModel, TaskResponse, optional, required

CHARACTER_MODEL = "happyhorse-character"
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

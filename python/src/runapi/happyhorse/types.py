"""HappyHorse model lists, enums, and response models."""

from __future__ import annotations

from runapi.core import BaseModel, TaskResponse, optional, required

CHARACTER_MODEL = "happyhorse-character"
HAPPYHORSE_1_0_T2V_MODEL = "happyhorse-1.0-t2v"
HAPPYHORSE_1_0_R2V_MODEL = "happyhorse-1.0-r2v"
HAPPYHORSE_1_0_I2V_MODEL = "happyhorse-1.0-i2v"


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

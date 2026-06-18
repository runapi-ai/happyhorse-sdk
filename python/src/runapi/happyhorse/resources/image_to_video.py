"""HappyHorse image-to-video resource."""

from __future__ import annotations

from typing import Any, Dict

from runapi.core import Resource, ValidationError

from ..types import (
    DURATION_RANGE,
    IMAGE_TO_VIDEO_MODEL,
    OUTPUT_RESOLUTIONS,
    SEED_RANGE,
    CompletedImageToVideoResponse,
    ImageToVideoResponse,
)


class ImageToVideo(Resource):
    """Generate videos from a first-frame image with HappyHorse models."""

    ENDPOINT = "/api/v1/happyhorse/image_to_video"

    RESPONSE_CLASS = ImageToVideoResponse
    COMPLETED_RESPONSE_CLASS = CompletedImageToVideoResponse

    def run(self, **params: Any) -> Any:
        """Create an image-to-video task and poll until it completes.

        Args:
            **params: Image-to-video parameters (model, first_frame_image_url, ...).

        Returns:
            The completed task with videos.
        """
        task = self.create(**params)
        return self._poll_until_complete(lambda: self.get(task.id))

    def create(self, **params: Any) -> Any:
        """Create an image-to-video task and return immediately with an ``id``.

        Args:
            **params: Image-to-video parameters (model, first_frame_image_url, ...).

        Returns:
            The task creation result with an id.
        """
        compacted = self._compact_params(params)
        self._validate_params(compacted)
        return self._request("post", self.ENDPOINT, body=compacted)

    def get(self, id: str) -> Any:
        """Fetch the current status of an image-to-video task.

        Args:
            id: The task id.

        Returns:
            The current task status.
        """
        return self._request("get", f"{self.ENDPOINT}/{id}")

    def _validate_params(self, params: Dict[str, Any]) -> None:
        if params.get("model") != IMAGE_TO_VIDEO_MODEL:
            raise ValidationError("model is required")
        if not params.get("first_frame_image_url"):
            raise ValidationError("first_frame_image_url is required")

        self._validate_optional(params, "output_resolution", OUTPUT_RESOLUTIONS)
        self._validate_integer_range(params, "duration_seconds", DURATION_RANGE)
        self._validate_integer_range(params, "seed", SEED_RANGE)

    @staticmethod
    def _validate_integer_range(params: Dict[str, Any], key: str, allowed: range) -> None:
        value = params.get(key)
        if value is None:
            return
        if isinstance(value, int) and not isinstance(value, bool) and value in allowed:
            return
        raise ValidationError(
            f"{key} must be an integer between {allowed.start} and {allowed.stop - 1}"
        )

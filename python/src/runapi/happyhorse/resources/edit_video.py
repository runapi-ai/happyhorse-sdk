"""HappyHorse edit-video resource."""

from __future__ import annotations

from typing import Any, Dict

from runapi.core import Resource, ValidationError

from ..contract_gen import CONTRACT
from ..types import (
    SEED_RANGE,
    CompletedEditVideoResponse,
    EditVideoResponse,
)


class EditVideo(Resource):
    """Edit a source video from a prompt with HappyHorse models."""

    ENDPOINT = "/api/v1/happyhorse/edit_video"

    RESPONSE_CLASS = EditVideoResponse
    COMPLETED_RESPONSE_CLASS = CompletedEditVideoResponse
    REFERENCE_IMAGE_RANGE = range(0, 6)

    def run(self, **params: Any) -> Any:
        """Create an edit-video task and poll until it completes.

        Args:
            **params: Edit-video parameters (model, prompt, source_video_url, ...).

        Returns:
            The completed task with videos.
        """
        task = self.create(**params)
        return self._poll_until_complete(lambda: self.get(task.id))

    def create(self, **params: Any) -> Any:
        """Create an edit-video task and return immediately with an ``id``.

        Args:
            **params: Edit-video parameters (model, prompt, source_video_url, ...).

        Returns:
            The task creation result with an id.
        """
        compacted = self._compact_params(params)
        self._validate_params(compacted)
        return self._request("post", self.ENDPOINT, body=compacted)

    def get(self, id: str) -> Any:
        """Fetch the current status of an edit-video task.

        Args:
            id: The task id.

        Returns:
            The current task status.
        """
        return self._request("get", f"{self.ENDPOINT}/{id}")

    def _validate_params(self, params: Dict[str, Any]) -> None:
        self._validate_contract(CONTRACT["edit-video"], params)

        if not params.get("prompt"):
            raise ValidationError("prompt is required")

        reference_image_urls = params.get("reference_image_urls")
        if reference_image_urls and (
            not isinstance(reference_image_urls, list)
            or len(reference_image_urls) not in self.REFERENCE_IMAGE_RANGE
        ):
            raise ValidationError(
                f"reference_image_urls must include at most {self.REFERENCE_IMAGE_RANGE.stop - 1} entries"
            )

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

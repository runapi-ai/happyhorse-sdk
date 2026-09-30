"""HappyHorse edit-video resource."""

from __future__ import annotations

from typing import Any, Optional

from runapi.core import Resource, RequestOptions

from ..types import (
    CompletedEditVideoResponse,
    EditVideoResponse,
)


class EditVideo(Resource):
    """Edit a source video from a prompt with HappyHorse models."""

    ENDPOINT = "/api/v1/happyhorse/edit_video"

    RESPONSE_CLASS = EditVideoResponse
    COMPLETED_RESPONSE_CLASS = CompletedEditVideoResponse
    def run(self, options: Optional[RequestOptions] = None, **params: Any) -> Any:
        """Create an edit-video task and poll until it completes.

        Args:
            **params: Edit-video parameters (model, prompt, source_video_url, ...).

        Returns:
            The completed task with videos.
        """
        task = self.create(options=options, **params)
        return self._poll_until_complete(lambda: self.get(task.id, options=options))

    def create(self, options: Optional[RequestOptions] = None, **params: Any) -> Any:
        """Create an edit-video task and return immediately with an ``id``.

        Args:
            **params: Edit-video parameters (model, prompt, source_video_url, ...).

        Returns:
            The task creation result with an id.
        """
        compacted = self._compact_params(params)
        return self._request("post", self.ENDPOINT, body=compacted, options=options)

    def get(self, id: str, options: Optional[RequestOptions] = None) -> Any:
        """Fetch the current status of an edit-video task.

        Args:
            id: The task id.

        Returns:
            The current task status.
        """
        return self._request("get", f"{self.ENDPOINT}/{id}", options=options)

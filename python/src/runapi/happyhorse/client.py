"""HappyHorse client."""

from __future__ import annotations

from typing import Any, Optional

from runapi.core import ProviderClient

from .resources.edit_video import EditVideo
from .resources.image_to_video import ImageToVideo
from .resources.text_to_video import TextToVideo


class HappyHorseClient(ProviderClient):
    """HappyHorse text-to-video, image-to-video, and edit-video client.

    Example::

        client = HappyHorseClient(api_key="sk-...")
        result = client.text_to_video.run(
            model="happyhorse-text-to-video", prompt="A horse galloping on a beach"
        )
    """

    def __init__(self, api_key: Optional[str] = None, **options: Any) -> None:
        super().__init__(api_key, **options)
        http = self._http
        self.text_to_video = TextToVideo(http)
        self.image_to_video = ImageToVideo(http)
        self.edit_video = EditVideo(http)

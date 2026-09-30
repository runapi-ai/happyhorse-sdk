import pytest

from runapi.core import config
from runapi.core.errors import AuthenticationError
from runapi.happyhorse import HappyHorseClient
from runapi.happyhorse.resources.edit_video import EditVideo
from runapi.happyhorse.resources.image_to_video import ImageToVideo
from runapi.happyhorse.resources.text_to_video import TextToVideo
from runapi.happyhorse.types import CompletedTextToVideoResponse, TextToVideoResponse


class FakeHttp:
    def __init__(self, *responses):
        self._responses = list(responses)
        self.calls = []

    def request(self, method, path, body=None, options=None):
        self.calls.append((method, path, body))
        if self._responses:
            return self._responses.pop(0)
        return {"id": "task_1", "status": "pending"}


@pytest.fixture(autouse=True)
def reset_config(monkeypatch):
    monkeypatch.delenv("RUNAPI_API_KEY", raising=False)
    monkeypatch.setattr(config, "api_key", None)
    yield


# --- auth -----------------------------------------------------------------


def test_accepts_api_key_parameter():
    assert isinstance(HappyHorseClient(api_key="k", http_client=FakeHttp()), HappyHorseClient)


def test_falls_back_to_global(monkeypatch):
    monkeypatch.setattr(config, "api_key", "global-key")
    assert isinstance(HappyHorseClient(http_client=FakeHttp()), HappyHorseClient)


def test_falls_back_to_env(monkeypatch):
    monkeypatch.setenv("RUNAPI_API_KEY", "env-key")
    assert isinstance(HappyHorseClient(http_client=FakeHttp()), HappyHorseClient)


def test_raises_without_api_key():
    with pytest.raises(AuthenticationError, match="API key is required"):
        HappyHorseClient()


# --- injection / accessors ------------------------------------------------


def test_uses_injected_http_client():
    fake = FakeHttp()
    client = HappyHorseClient(api_key="k", http_client=fake)
    assert client.text_to_video._http is fake
    assert client.image_to_video._http is fake
    assert client.edit_video._http is fake


def test_exposes_resource_accessors():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    assert isinstance(client.text_to_video, TextToVideo)
    assert isinstance(client.image_to_video, ImageToVideo)
    assert isinstance(client.edit_video, EditVideo)


# --- request shapes -------------------------------------------------------


def test_text_to_video_create_posts_compacted_body():
    fake = FakeHttp({"id": "t1", "status": "pending"})
    client = HappyHorseClient(api_key="k", http_client=fake)
    result = client.text_to_video.create(
        model="happyhorse-text-to-video",
        prompt="a horse",
        aspect_ratio="16:9",
        seed=None,
    )
    assert fake.calls == [
        (
            "post",
            "/api/v1/happyhorse/text_to_video",
            {"model": "happyhorse-text-to-video", "prompt": "a horse", "aspect_ratio": "16:9"},
        )]
    assert isinstance(result, TextToVideoResponse)


def test_text_to_video_get_fetches_by_id():
    fake = FakeHttp({"id": "t1", "status": "processing"})
    client = HappyHorseClient(api_key="k", http_client=fake)
    client.text_to_video.get("t1")
    assert fake.calls == [("get", "/api/v1/happyhorse/text_to_video/t1", None)]


def test_image_to_video_create_posts_compacted_body():
    fake = FakeHttp({"id": "t1", "status": "pending"})
    client = HappyHorseClient(api_key="k", http_client=fake)
    client.image_to_video.create(
        model="happyhorse-image-to-video",
        first_frame_image_url="https://runapi.ai/a.jpg",
        output_resolution="720p",
    )
    assert fake.calls == [
        (
            "post",
            "/api/v1/happyhorse/image_to_video",
            {
                "model": "happyhorse-image-to-video",
                "first_frame_image_url": "https://runapi.ai/a.jpg",
                "output_resolution": "720p"},
        )]


def test_edit_video_create_posts_compacted_body():
    fake = FakeHttp({"id": "t1", "status": "pending"})
    client = HappyHorseClient(api_key="k", http_client=fake)
    client.edit_video.create(
        model="happyhorse-edit-video",
        prompt="brighten it",
        source_video_url="https://runapi.ai/v.mp4",
    )
    assert fake.calls == [
        (
            "post",
            "/api/v1/happyhorse/edit_video",
            {
                "model": "happyhorse-edit-video",
                "prompt": "brighten it",
                "source_video_url": "https://runapi.ai/v.mp4"},
        )]


def test_run_narrows_completed_type():
    fake = FakeHttp(
        {"id": "t1", "status": "pending"},
        {"id": "t1", "status": "completed", "usage": {"cost": 0.05}, "videos": [{"url": "https://x/y.mp4"}]},
    )
    client = HappyHorseClient(api_key="k", http_client=fake)
    result = client.text_to_video.run(model="happyhorse-text-to-video", prompt="a serene river")
    assert isinstance(result, CompletedTextToVideoResponse)
    assert result.videos[0].url == "https://x/y.mp4"

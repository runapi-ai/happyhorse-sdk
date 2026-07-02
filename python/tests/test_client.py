import pytest

from runapi.core import config
from runapi.core.errors import AuthenticationError, ValidationError
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
        ),
    ]
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
                "output_resolution": "720p",
            },
        ),
    ]


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
                "source_video_url": "https://runapi.ai/v.mp4",
            },
        ),
    ]


def test_run_narrows_completed_type():
    fake = FakeHttp(
        {"id": "t1", "status": "pending"},
        {"id": "t1", "status": "completed", "videos": [{"url": "https://x/y.mp4"}]},
    )
    client = HappyHorseClient(api_key="k", http_client=fake)
    result = client.text_to_video.run(model="happyhorse-text-to-video", prompt="a serene river")
    assert isinstance(result, CompletedTextToVideoResponse)
    assert result.videos[0].url == "https://x/y.mp4"


# --- validation -----------------------------------------------------------


def test_text_to_video_rejects_unknown_model():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(
        ValidationError,
        match="model must be one of: happyhorse-character, happyhorse-text-to-video",
    ):
        client.text_to_video.create(model="nope", prompt="hi")


def test_text_to_video_requires_prompt():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="prompt is required"):
        client.text_to_video.create(model="happyhorse-text-to-video")


def test_text_to_video_rejects_reference_images_for_non_character():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="reference_image_urls is only supported for happyhorse-character"):
        client.text_to_video.create(
            model="happyhorse-text-to-video",
            prompt="hi",
            reference_image_urls=["https://x/a.jpg"],
        )


def test_character_model_requires_reference_images():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="reference_image_urls is required"):
        client.text_to_video.create(model="happyhorse-character", prompt="hi", reference_image_urls=[])


def test_character_model_rejects_too_many_reference_images():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="reference_image_urls must include between 1 and 9 entries"):
        client.text_to_video.create(
            model="happyhorse-character",
            prompt="hi",
            reference_image_urls=[f"https://x/{i}.jpg" for i in range(10)],
        )


def test_text_to_video_duration_range():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="duration_seconds must be an integer between 3 and 15"):
        client.text_to_video.create(model="happyhorse-text-to-video", prompt="hi", duration_seconds=99)


def test_text_to_video_rejects_invalid_output_resolution():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="output_resolution must be one of: 720p, 1080p"):
        client.text_to_video.create(
            model="happyhorse-text-to-video", prompt="hi", output_resolution="4k"
        )


def test_image_to_video_requires_model():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="model must be one of: happyhorse-image-to-video"):
        client.image_to_video.create(model="wrong", first_frame_image_url="https://x/a.jpg")


def test_image_to_video_requires_first_frame():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="first_frame_image_url is required"):
        client.image_to_video.create(model="happyhorse-image-to-video")


def test_edit_video_requires_source_video_url():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="source_video_url is required"):
        client.edit_video.create(model="happyhorse-edit-video", prompt="brighten")


def test_edit_video_reference_images_max():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="reference_image_urls must include at most 5 entries"):
        client.edit_video.create(
            model="happyhorse-edit-video",
            prompt="brighten",
            source_video_url="https://x/v.mp4",
            reference_image_urls=["a", "b", "c", "d", "e", "f"],
        )


def test_edit_video_rejects_invalid_audio_setting():
    client = HappyHorseClient(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="audio_setting must be one of: auto, original"):
        client.edit_video.create(
            model="happyhorse-edit-video",
            prompt="brighten",
            source_video_url="https://x/v.mp4",
            audio_setting="muted",
        )

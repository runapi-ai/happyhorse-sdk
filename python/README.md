# HappyHorse API Python SDK for RunAPI

The HappyHorse Python SDK is the language-specific package for HappyHorse on RunAPI. Use this package for video generation, animation, and video editing workflows when your application needs request bodies, task status lookup, and consistent RunAPI errors in Python.

## Install

```bash
pip install runapi-happyhorse
```

## Quick start

```python
from runapi.happyhorse import HappyHorseClient

client = HappyHorseClient()  # reads RUNAPI_API_KEY, or pass api_key="sk-..."

video = client.text_to_video.run(
    model="happyhorse-text-to-video",
    prompt="A horse galloping along a beach at sunset, cinematic",
    aspect_ratio="16:9",
    output_resolution="1080p",
    duration_seconds=5,
)
print(video.videos[0].url)
```

For image-to-video, call `client.image_to_video.run` with `model="happyhorse-image-to-video"` and a `first_frame_image_url`. For edit-video, call `client.edit_video.run` with `model="happyhorse-edit-video"`. Use `create` to submit a task and return quickly, `get` to fetch the latest task state, and `run` to create and poll until completion. In web request handlers, prefer `create` plus webhook or later `get` polling so a worker is not held open.

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## Language notes

Pass parameters as keyword arguments and catch the `runapi.happyhorse` error classes when building video jobs or scripts. The available resources are `text_to_video`, `image_to_video`, and `edit_video`. Keep `RUNAPI_API_KEY` in the environment or your secret manager; never commit API keys or callback secrets.

## Links

- Model page: https://runapi.ai/models/happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- Image-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/image-to-video
- Character pricing and rate limits: https://runapi.ai/models/happyhorse/character
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/edit-video
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Full catalog: https://runapi.ai/models

## License

Licensed under the Apache License, Version 2.0.

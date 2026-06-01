# HappyHorse API Ruby SDK for RunAPI

The happyhorse ai api Ruby SDK is the language-specific package for HappyHorse on RunAPI. Use this package for text, image, and edit-video workflows that need JSON request bodies, task status lookup, and consistent RunAPI errors in Ruby.

## Install

```bash
gem install runapi-happyhorse
```

## Quick start

```ruby
require "runapi-happyhorse"

client = RunApi::HappyHorse::Client.new
video = client.text_to_video.run(
  model: "happyhorse-character",
  prompt: "Character1 walks through a miniature cardboard city at night.",
  reference_image_urls: ["https://cdn.runapi.ai/public/samples/reference-1.jpg"],
  output_resolution: "1080p",
  aspect_ratio: "16:9",
  duration_seconds: 5
)
```

For image-to-video, call `client.image_to_video.run` with `model: "happyhorse-image-to-video"` and exactly one `image_urls` entry. For character-guided text-to-video, call `client.text_to_video.run` with `model: "happyhorse-character"` and 1-9 `reference_image_urls` entries. For edit-video, call `client.edit_video.run` with `model: "happyhorse-edit-video"`, one `video_url`, and optional `reference_image` entries.

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

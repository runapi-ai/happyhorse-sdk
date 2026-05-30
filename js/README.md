# HappyHorse API JavaScript SDK for RunAPI

The happyhorse ai api JavaScript SDK is the language-specific package for HappyHorse on RunAPI. Use this package for text, image, reference-to-video, and edit-video workflows that need JSON request bodies, task status lookup, and consistent RunAPI errors in JavaScript.

## Install

```bash
npm install @runapi.ai/happyhorse
```

## Quick start

```typescript
import { HappyHorseClient } from '@runapi.ai/happyhorse';

const client = new HappyHorseClient();
const video = await client.textToVideo.run({
  model: 'happyhorse-text-to-video',
  prompt: 'A tiny paper horse gallops through a miniature cardboard city at night.',
  resolution: '1080p',
  aspect_ratio: '16:9',
  duration: 5,
});
```

For image-to-video, call `client.imageToVideo.run` with `model: 'happyhorse-image-to-video'` and exactly one `image_urls` entry. For reference-to-video, call `client.referenceToVideo.run` with `model: 'happyhorse-reference-to-video'` and 1-9 `reference_image` entries. For edit-video, call `client.editVideo.run` with `model: 'happyhorse-video-edit'`, one `video_url`, and optional `reference_image` entries.

## Links

- Model page: https://runapi.ai/models/happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- Image-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/image-to-video
- Reference-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/reference-to-video
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/video-edit
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Full catalog: https://runapi.ai/models

## License

Licensed under the Apache License, Version 2.0.

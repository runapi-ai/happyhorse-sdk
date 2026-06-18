<p align="center">
  <a href="https://runapi.ai"><img src="https://runapi.ai/icon.svg" height="56" alt="RunAPI"></a>
</p>

<h3 align="center">
  <a href="https://github.com/runapi-ai/happyhorse-sdk">HappyHorse API SDK for RunAPI</a>
</h3>

<p align="center">
  HappyHorse API SDKs for JavaScript, Ruby, and Go on RunAPI.
</p>

<div align="center">

[![npm](https://img.shields.io/npm/v/@runapi.ai/happyhorse)](https://www.npmjs.com/package/@runapi.ai/happyhorse)
[![RubyGems](https://img.shields.io/gem/v/runapi-happyhorse)](https://rubygems.org/gems/runapi-happyhorse)
[![Go Reference](https://pkg.go.dev/badge/github.com/runapi-ai/happyhorse-sdk/go.svg)](https://pkg.go.dev/github.com/runapi-ai/happyhorse-sdk/go)
[![License](https://img.shields.io/github/license/runapi-ai/happyhorse-sdk)](https://github.com/runapi-ai/happyhorse-sdk/blob/main/LICENSE)

</div>
<br/>

The happyhorse ai api SDK packages JavaScript, Ruby, and Go clients for HappyHorse on RunAPI. Use this happyhorse ai api SDK for text, image, and edit-video workflows that need typed installs, JSON request bodies, task polling, and consistent RunAPI errors across services.

HappyHorse belongs to the Alibaba catalog on RunAPI. The public model page is https://runapi.ai/models/happyhorse. The public `happyhorse-sdk` repository groups the JavaScript, Ruby, and Go packages for this model.

## Install

```bash
npm install @runapi.ai/happyhorse
gem install runapi-happyhorse
go get github.com/runapi-ai/happyhorse-sdk/go@latest
```

## JavaScript Quick Start

```typescript
import { HappyHorseClient } from '@runapi.ai/happyhorse';

const client = new HappyHorseClient();

const task = await client.textToVideo.create({
  model: 'happyhorse-character',
  prompt: 'Character1 walks through a paper city and waves at character2.',
  reference_image_urls: [
    'https://cdn.runapi.ai/public/samples/reference-1.jpg',
    'https://cdn.runapi.ai/public/samples/reference-2.jpg',
  ],
  output_resolution: '1080p',
  aspect_ratio: '16:9',
  duration_seconds: 5,
});

const status = await client.textToVideo.get(task.id);
```

## Image-to-Video

```typescript
const imageTask = await client.imageToVideo.create({
  model: 'happyhorse-image-to-video',
  first_frame_image_url: 'https://cdn.runapi.ai/public/samples/image-to-video.jpg',
  prompt: 'Bring the still frame to life with a gentle cinematic camera move.',
  output_resolution: '1080p',
  duration_seconds: 5,
});

const imageStatus = await client.imageToVideo.get(imageTask.id);
```

## Edit Video

```typescript
const editTask = await client.editVideo.create({
  model: 'happyhorse-edit-video',
  prompt: 'Make the horse-headed character wear the striped sweater from the reference image.',
  source_video_url: 'https://cdn.runapi.ai/public/samples/video.mp4',
  reference_image_urls: [
    'https://cdn.runapi.ai/public/samples/reference-1.jpg',
  ],
  output_resolution: '1080p',
  audio_setting: 'auto',
});

const editStatus = await client.editVideo.get(editTask.id);
```

## Public Links

- Model page: https://runapi.ai/models/happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- SDK repository: https://github.com/runapi-ai/happyhorse-sdk
- Skill repository: https://github.com/runapi-ai/happyhorse
- Image-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/image-to-video
- Character pricing and rate limits: https://runapi.ai/models/happyhorse/character
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/edit-video
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Full catalog: https://runapi.ai/models

## Generated file storage

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## License

Licensed under the Apache License, Version 2.0.

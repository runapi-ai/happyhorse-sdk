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

The happyhorse ai api SDK packages JavaScript, Ruby, and Go clients for HappyHorse on RunAPI. Use this happyhorse ai api SDK for text, image, reference-to-video, and edit-video workflows that need typed installs, JSON request bodies, task polling, and consistent RunAPI errors across services.

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
  model: 'happyhorse-text-to-video',
  prompt: 'A cardboard city lights up at night',
  resolution: '1080p',
  aspect_ratio: '16:9',
  duration: 5,
});

const status = await client.textToVideo.get(task.id);
```

## Image-to-Video

```typescript
const imageTask = await client.imageToVideo.create({
  model: 'happyhorse-image-to-video',
  image_urls: ['https://cdn.runapi.ai/public/samples/image-to-video.jpg'],
  prompt: 'Bring the still frame to life with a gentle cinematic camera move.',
  resolution: '1080p',
  duration: 5,
});

const imageStatus = await client.imageToVideo.get(imageTask.id);
```

## Reference-to-Video

```typescript
const referenceTask = await client.referenceToVideo.create({
  model: 'happyhorse-reference-to-video',
  prompt: 'Character1 walks through a paper city and waves at character2.',
  reference_image: [
    'https://cdn.runapi.ai/public/samples/reference-1.jpg',
    'https://cdn.runapi.ai/public/samples/reference-2.jpg',
  ],
  resolution: '1080p',
  aspect_ratio: '16:9',
  duration: 5,
});

const referenceStatus = await client.referenceToVideo.get(referenceTask.id);
```

## Edit Video

```typescript
const editTask = await client.editVideo.create({
  model: 'happyhorse-video-edit',
  prompt: 'Make the horse-headed character wear the striped sweater from the reference image.',
  video_url: 'https://cdn.runapi.ai/public/samples/video.mp4',
  reference_image: [
    'https://cdn.runapi.ai/public/samples/reference-1.jpg',
  ],
  resolution: '1080p',
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
- Reference-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/reference-to-video
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/video-edit
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Full catalog: https://runapi.ai/models

## License

Licensed under the Apache License, Version 2.0.

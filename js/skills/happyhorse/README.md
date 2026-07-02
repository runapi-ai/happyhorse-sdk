<p align="center">
  <a href="https://github.com/runapi-ai/happyhorse">
    <h3 align="center">HappyHorse API Skill for RunAPI</h3>
  </a>
</p>

<p align="center">
  Install this agent skill, inspect HappyHorse fields, then run text, image, or edit-video jobs through the RunAPI CLI.
</p>

<p align="center">
  <a href="https://runapi.ai/models/happyhorse"><strong>Model Reference</strong></a> · <a href="https://github.com/runapi-ai/cli"><strong>CLI</strong></a> · <a href="https://github.com/runapi-ai/happyhorse-sdk"><strong>SDK</strong></a>
</p>

<div align="center">

[![skills.sh](https://www.skills.sh/b/runapi-ai/happyhorse)](https://www.skills.sh/runapi-ai/happyhorse/happyhorse)
[![ClawHub](https://img.shields.io/badge/ClawHub-runapi--happyhorse-111827)](https://clawhub.ai/runapi-ai/runapi-happyhorse)
[![License](https://img.shields.io/github/license/runapi-ai/happyhorse)](https://github.com/runapi-ai/happyhorse/blob/main/LICENSE)

</div>
<br/>

Generate text, image, or edit-video clips with HappyHorse in 720p or 1080p. Text-to-video can also use ordered reference images through the character model. This skill helps Claude Code, Codex, Gemini CLI, Cursor, and 50+ agents integrate HappyHorse through RunAPI.

The canonical agent file is `skills/happyhorse/SKILL.md`.

## Install

```bash
npx skills add runapi-ai/happyhorse -g
```

Or paste this prompt to your AI agent:

```text
Install the happyhorse skill for me:

1. Clone https://github.com/runapi-ai/happyhorse
2. Copy the skills/happyhorse/ directory into your
   user-level skills directory (e.g. ~/.claude/skills/
   for Claude Code, ~/.codex/skills/ for Codex).
3. Verify that SKILL.md is present.
4. Confirm the install path when done.
```

## Quick example

```typescript
import { HappyHorseClient } from '@runapi.ai/happyhorse';

const client = new HappyHorseClient();
const result = await client.textToVideo.run({
  model: 'happyhorse-character',
  prompt: 'Character1 walks through a miniature cardboard city at night.',
  reference_image_urls: ['https://cdn.runapi.ai/public/samples/reference-1.jpg'],
  output_resolution: '1080p',
  aspect_ratio: '16:9',
  duration_seconds: 5,
});
```

Image-to-video tasks use `client.imageToVideo` with `model: 'happyhorse-image-to-video'` and `first_frame_image_url`. Character-guided text-to-video tasks use `client.textToVideo` with `model: 'happyhorse-character'` and 1-9 `reference_image_urls` entries. Edit-video tasks use `client.editVideo` with `model: 'happyhorse-edit-video'`, one `source_video_url`, and optional `reference_image_urls`.

## Variants

- `happyhorse-text-to-video`: create 3-15 second videos from a text prompt with 720p or 1080p output.
- `happyhorse-character`: create 3-15 second text-to-video clips guided by 1-9 ordered reference images.
- `happyhorse-image-to-video`: animate one first-frame image into a 3-15 second video with 720p or 1080p output.
- `happyhorse-edit-video`: edit one 3-60 second source video using a prompt and up to 5 reference images.

## Routing

- Model page: https://runapi.ai/models/happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- SDK repository: https://github.com/runapi-ai/happyhorse-sdk
- Image-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/image-to-video
- Character pricing and rate limits: https://runapi.ai/models/happyhorse/character
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/edit-video
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Browse all RunAPI models and skills: https://runapi.ai/models

## Agent rules

- Integration work uses the target language SDK; one-off generation, manual smoke tests, debugging, or user-requested CLI runs use the RunAPI CLI skill: https://github.com/runapi-ai/cli-skill
- RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.
- Keep API keys in `RUNAPI_API_KEY` or RunAPI CLI config; never commit secrets.
- Prefer `create`, `get`, and `run` JSON passthrough patterns instead of inventing flags for every model parameter.
- For pricing, rate-limit, and commercial-usage answers, link to the variant page rather than the repository README.

## License

Licensed under the Apache License, Version 2.0.

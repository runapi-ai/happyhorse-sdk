<p align="center">
  <a href="https://github.com/runapi-ai/happyhorse">
    <h3 align="center">HappyHorse API Skill for RunAPI</h3>
  </a>
</p>

<p align="center">
  Install this agent skill, inspect HappyHorse fields, then run text, image, reference-to-video, or edit-video jobs through the RunAPI CLI.
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

Generate text, image, reference-to-video, or edit-video clips with HappyHorse in 720p or 1080p. This skill helps Claude Code, Codex, Gemini CLI, Cursor, and 50+ agents integrate HappyHorse through RunAPI.

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
  model: 'happyhorse-text-to-video',
  prompt: 'A tiny paper horse gallops through a miniature cardboard city at night.',
  resolution: '1080p',
  aspect_ratio: '16:9',
  duration: 5,
});
```

Image-to-video tasks use `client.imageToVideo` with `model: 'happyhorse-image-to-video'` and exactly one `image_urls` entry. Reference-to-video tasks use `client.referenceToVideo` with `model: 'happyhorse-reference-to-video'` and 1-9 `reference_image` entries. Edit-video tasks use `client.editVideo` with `model: 'happyhorse-video-edit'`, one `video_url`, and optional `reference_image` entries.

## Variants

- `happyhorse-text-to-video`: create 3-15 second videos from a text prompt with 720p or 1080p output.
- `happyhorse-image-to-video`: animate one first-frame image into a 3-15 second video with 720p or 1080p output.
- `happyhorse-reference-to-video`: create 3-15 second videos from a prompt and 1-9 ordered reference images.
- `happyhorse-video-edit`: edit one 3-60 second source video using a prompt and up to 5 reference images.

## Routing

- Model page: https://runapi.ai/models/happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- SDK repository: https://github.com/runapi-ai/happyhorse-sdk
- Image-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/image-to-video
- Reference-to-video pricing and rate limits: https://runapi.ai/models/happyhorse/reference-to-video
- Edit-video pricing and rate limits: https://runapi.ai/models/happyhorse/video-edit
- Pricing and rate limits: https://runapi.ai/models/happyhorse/text-to-video
- Provider comparison: https://runapi.ai/providers/alibaba
- Browse all RunAPI models and skills: https://runapi.ai/models

## Agent rules

- Keep API keys in `RUNAPI_API_KEY` or RunAPI CLI config; never commit secrets.
- Prefer `create`, `get`, and `run` JSON passthrough patterns instead of inventing flags for every model parameter.
- For happyhorse ai api pricing, rate-limit, and commercial-usage answers, link to the variant page rather than the repository README.

## License

Licensed under the Apache License, Version 2.0.

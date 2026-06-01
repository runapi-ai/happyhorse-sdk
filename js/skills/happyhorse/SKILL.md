---
name: happyhorse
description: Generate text, image, or edit-video clips with HappyHorse through RunAPI. Use when the user asks an agent to create video from text, a first-frame image, ordered reference images, or an edited source video with HappyHorse. Default to the RunAPI CLI for one-off generation; use SDKs only when the user is integrating RunAPI into an app or backend.
documentation: https://runapi.ai/models/happyhorse.md
provider_page: https://runapi.ai/providers/alibaba.md
catalog: https://runapi.ai/models.md
metadata:
  openclaw:
    homepage: https://runapi.ai/models/happyhorse
    requires:
      bins:
      - runapi
    install:
    - kind: brew
      formula: runapi-ai/tap/runapi
      bins:
      - runapi
    envVars:
    - name: RUNAPI_API_KEY
      required: false
      description: Optional RunAPI API key; agents should prefer environment auth or saved CLI config. Browser login is interactive only.
---

# HappyHorse on RunAPI

Generate text, image, or edit-video clips with HappyHorse through RunAPI. Text-to-video can also use ordered reference images through the character model. The default path for one-off agent tasks is the `runapi` CLI; SDKs are for application integration.

## Routing decision

- One-off text, image, or edit-video generation for the user -> use the CLI path with the `runapi` binary.
- Building an app, backend, worker, library, or production codebase -> use the SDK integration path.

## CLI path

The `runapi` binary is the runtime dependency. Run `runapi auth status` first. For agents and headless runs, prefer `RUNAPI_API_KEY` or import it into saved config with `printf '%s' "$RUNAPI_API_KEY" | runapi auth import-token --token -`. Use `runapi login` only when the user explicitly wants interactive browser auth.

Inspect the available commands and request fields with CLI help:

```shell
runapi happyhorse --help
runapi happyhorse text-to-video --help
runapi happyhorse image-to-video --help
runapi happyhorse edit-video --help
```

Run a one-off task:

```shell
runapi happyhorse text-to-video --input-file request.json
runapi happyhorse image-to-video --input-file request.json
runapi happyhorse edit-video --input-file request.json
```

Submit asynchronously and poll separately:

```shell
runapi happyhorse text-to-video --async --input-file request.json
runapi wait <task-id> --service happyhorse --action text-to-video
```

For image-to-video and edit-video, use the same async pattern with `--action image-to-video` or `--action edit-video`.

Available commands: `text-to-video`, `image-to-video`, `edit-video`.

## Variants

- `happyhorse-text-to-video`: create 3-15 second videos from a text prompt with 720p or 1080p output.
- `happyhorse-character`: create 3-15 second text-to-video clips guided by 1-9 ordered reference images.
- `happyhorse-image-to-video`: animate one first-frame image into a 3-15 second video with 720p or 1080p output.
- `happyhorse-edit-video`: edit one 3-60 second source video using a prompt and up to 5 reference images.

## SDK integration path

When integrating HappyHorse into an app, backend, worker, or library, use a RunAPI SDK package:

- JavaScript / TypeScript: `@runapi.ai/happyhorse`
- Ruby: `runapi-happyhorse`
- Go: `github.com/runapi-ai/happyhorse-sdk/go`

## References

- Model overview, pricing, and rate limits: https://runapi.ai/models/happyhorse.md
- Text-to-video variant: https://runapi.ai/models/happyhorse/text-to-video.md
- Character variant: https://runapi.ai/models/happyhorse/character.md
- Image-to-video variant: https://runapi.ai/models/happyhorse/image-to-video.md
- Edit-video variant: https://runapi.ai/models/happyhorse/edit-video.md
- Provider comparison: https://runapi.ai/providers/alibaba.md
- Full model catalog: https://runapi.ai/models.md

# HappyHorse API Go SDK for RunAPI

The happyhorse ai api Go SDK is the language-specific package for HappyHorse on RunAPI. Use this package for text, image, and edit-video workflows that need JSON request bodies, task status lookup, and consistent RunAPI errors in Go.

## Install

```bash
go get github.com/runapi-ai/happyhorse-sdk/go@latest
```

## Quick start

```go
import (
  "context"

  "github.com/runapi-ai/happyhorse-sdk/go/happyhorse"
)

client, err := happyhorse.NewClient()
duration := 5
video, err := client.TextToVideo.Run(context.Background(), happyhorse.TextToVideoParams{
  Model:              happyhorse.ModelCharacter,
  Prompt:             "Character1 walks through a miniature cardboard city at night.",
  ReferenceImageURLs: []string{"https://cdn.runapi.ai/public/samples/reference-1.jpg"},
  OutputResolution:   happyhorse.OutputResolution1080P,
  AspectRatio:        happyhorse.AspectRatio169,
  DurationSeconds:    &duration,
})
```

For image-to-video, call `client.ImageToVideo.Run` with `Model: happyhorse.ModelImageToVideo` and exactly one `ImageURLs` entry. For character-guided text-to-video, call `client.TextToVideo.Run` with `Model: happyhorse.ModelCharacter` and 1-9 `ReferenceImageURLs` entries. For edit-video, call `client.EditVideo.Run` with `Model: happyhorse.ModelEditVideo`, one `VideoURL`, and optional `ReferenceImage` entries.

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

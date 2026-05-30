# HappyHorse API Go SDK for RunAPI

The happyhorse ai api Go SDK is the language-specific package for HappyHorse on RunAPI. Use this package for text, image, reference-to-video, and edit-video workflows that need JSON request bodies, task status lookup, and consistent RunAPI errors in Go.

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
  Model:       happyhorse.ModelTextToVideo,
  Prompt:      "A tiny paper horse gallops through a miniature cardboard city at night.",
  Resolution:  happyhorse.Resolution1080P,
  AspectRatio: happyhorse.AspectRatio169,
  Duration:    &duration,
})
```

For image-to-video, call `client.ImageToVideo.Run` with `Model: happyhorse.ModelImageToVideo` and exactly one `ImageURLs` entry. For reference-to-video, call `client.ReferenceToVideo.Run` with `Model: happyhorse.ModelReferenceToVideo` and 1-9 `ReferenceImage` entries. For edit-video, call `client.EditVideo.Run` with `Model: happyhorse.ModelEditVideo`, one `VideoURL`, and optional `ReferenceImage` entries.

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

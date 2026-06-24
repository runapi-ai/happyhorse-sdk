<p align="center">
  <a href="https://runapi.ai"><img src="https://runapi.ai/icon.svg" height="56" alt="RunAPI"></a>
</p>

<h3 align="center">
  <a href="https://github.com/runapi-ai/happyhorse-sdk">HappyHorse API SDK for RunAPI</a>
</h3>

<p align="center">
  HappyHorse API SDKs for JavaScript, Python, Ruby, Go, and Java on RunAPI.
</p>

<div align="center">

[![npm](https://img.shields.io/npm/v/@runapi.ai/happyhorse)](https://www.npmjs.com/package/@runapi.ai/happyhorse)
[![PyPI](https://img.shields.io/pypi/v/runapi-happyhorse)](https://pypi.org/project/runapi-happyhorse/)
[![RubyGems](https://img.shields.io/gem/v/runapi-happyhorse)](https://rubygems.org/gems/runapi-happyhorse)
[![Go Reference](https://pkg.go.dev/badge/github.com/runapi-ai/happyhorse-sdk/go.svg)](https://pkg.go.dev/github.com/runapi-ai/happyhorse-sdk/go)
[![Maven Central](https://img.shields.io/maven-central/v/ai.runapi/runapi-happyhorse)](https://central.sonatype.com/artifact/ai.runapi/runapi-happyhorse)
[![License](https://img.shields.io/github/license/runapi-ai/happyhorse-sdk)](https://github.com/runapi-ai/happyhorse-sdk/blob/main/LICENSE)

</div>
<br/>

The HappyHorse API SDK packages JavaScript, Python, Ruby, Go, and Java clients for HappyHorse on RunAPI. Use it for text-to-video, image-to-video, and edit-video workflows when your app needs typed request builders, predictable task polling, file upload helpers, account helpers, and consistent RunAPI errors.

HappyHorse is listed in the RunAPI model catalog at https://runapi.ai/models/happyhorse. Variant pages below carry pricing, rate-limit, and commercial-usage details. The public `happyhorse-sdk` repository groups the language packages, examples, CI, and release tags for this model.

## Install

```bash
npm install @runapi.ai/happyhorse
pip install runapi-happyhorse
gem install runapi-happyhorse
go get github.com/runapi-ai/happyhorse-sdk/go@latest
```

Gradle:

```kotlin
dependencies {
  implementation("ai.runapi:runapi-happyhorse:0.1.0")
}
```

Maven:

```xml
<dependency>
  <groupId>ai.runapi</groupId>
  <artifactId>runapi-happyhorse</artifactId>
  <version>0.1.0</version>
</dependency>
```

Use the Java BOM when installing multiple RunAPI Java modules:

```kotlin
dependencies {
  implementation(platform("ai.runapi:runapi-bom:0.1.0"))
  implementation("ai.runapi:runapi-happyhorse")
}
```

## What you can build

- Build apps, agent workflows, batch jobs, and production services around HappyHorse requests.
- Install only the language package your app needs while keeping one model-specific repository for docs and releases.
- Use `create` for submit-only jobs, `get` for status lookup, and `run` for submit-and-poll scripts.
- Upload local files, URL files, or base64 files through shared RunAPI file helpers.
- Handle validation, authentication, rate limits, insufficient credits, task failures, and polling timeouts through RunAPI SDK errors.

## Java quick start

```java
import ai.runapi.happyhorse.HappyHorseClient;
import ai.runapi.happyhorse.types.TextToVideoParams;
import ai.runapi.happyhorse.types.CompletedTextToVideoResponse;
import ai.runapi.happyhorse.types.TextToVideoModel;

HappyHorseClient client = HappyHorseClient.builder()
    .apiKey(System.getenv("RUNAPI_API_KEY"))
    .build();

CompletedTextToVideoResponse result = client.textToVideo().run(
    TextToVideoParams.builder()
        .model(TextToVideoModel.HAPPYHORSE_CHARACTER)
        .referenceImageUrls(java.util.Arrays.asList("https://cdn.runapi.ai/public/samples/image.jpg"))
        .prompt("A stylized hero walking through a market")
        .aspectRatio("16:9")
        .outputResolution("720p")
        .durationSeconds(5)
        .build()
);
```

Java packages target Java 8 bytecode and are tested on Java 8, 11, 17, and 21. Each model artifact depends on `ai.runapi:runapi-core`, so application code normally installs only `ai.runapi:runapi-happyhorse`.

## Task lifecycle

Most media endpoints are asynchronous. `create()` submits a task and returns its id, `get(id)` fetches the latest task state, and `run(params)` creates the task and polls until it reaches a terminal state. In web request handlers, prefer `create()` plus webhook or later `get()` polling so the server does not hold a worker open.

## Repository layout

- `js/` publishes `@runapi.ai/happyhorse`.
- `python/` publishes `runapi-happyhorse`.
- `ruby/` publishes `runapi-happyhorse`.
- `go/` publishes `github.com/runapi-ai/happyhorse-sdk/go`.
- `java/` publishes `ai.runapi:runapi-happyhorse` and uses `ai.runapi:runapi-core`.

## Public links

- Model page: https://runapi.ai/models/happyhorse
- SDK docs: https://runapi.ai/docs#sdk-happyhorse
- Product docs: https://runapi.ai/docs#happyhorse
- SDK repository: https://github.com/runapi-ai/happyhorse-sdk
- Skill repository: https://github.com/runapi-ai/happyhorse
- Provider comparison: https://runapi.ai/providers/alibaba
- Full catalog: https://runapi.ai/models

## Pricing and variants

Use the most specific HappyHorse variant page for pricing, rate limits, and commercial usage:
- [Edit video](https://runapi.ai/models/happyhorse/edit-video)
- [Image to video](https://runapi.ai/models/happyhorse/image-to-video)
- [Character](https://runapi.ai/models/happyhorse/character)
- [Text to video](https://runapi.ai/models/happyhorse/text-to-video)

Default pricing link for the HappyHorse SDK: https://runapi.ai/models/happyhorse/edit-video

## File storage

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## FAQ

### Which package should I install for HappyHorse work?

Install the model package for your language: `@runapi.ai/happyhorse` on npm, `runapi-happyhorse` on PyPI, `runapi-happyhorse` on RubyGems, `github.com/runapi-ai/happyhorse-sdk/go`, or `ai.runapi:runapi-happyhorse`. Install core SDK packages only when you are building shared SDK infrastructure.

### Where should public links point?

Primary HappyHorse links point to https://runapi.ai/models/happyhorse. Pricing and usage-policy links point to variant pages such as https://runapi.ai/models/happyhorse/edit-video. Provider comparisons point to https://runapi.ai/providers/alibaba, and broad browsing points to https://runapi.ai/models.

## License

Licensed under the Apache License, Version 2.0.

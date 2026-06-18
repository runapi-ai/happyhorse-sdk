import { BaseClient, type ClientOptions } from '@runapi.ai/core';
import { EditVideo } from './resources/edit-video';
import { ImageToVideo } from './resources/image-to-video';
import { TextToVideo } from './resources/text-to-video';

/**
 * HappyHorse video generation and editing API client.
 *
 * @example
 * ```typescript
 * const client = new HappyHorseClient({ apiKey: 'your-api-key' });
 *
 * const result = await client.textToVideo.run({
 *   model: 'happyhorse-text-to-video',
 *   prompt: 'A horse galloping across a sunset beach',
 * });
 * ```
 */
export class HappyHorseClient extends BaseClient {
  /** Generate video from a text prompt, with optional character consistency via happyhorse-character. */
  public readonly textToVideo: TextToVideo;
  /** Animate a still first-frame image into video, guided by an optional text prompt. */
  public readonly imageToVideo: ImageToVideo;
  /** Transform an existing video with a text prompt and optional reference images. */
  public readonly editVideo: EditVideo;

  constructor(options: ClientOptions = {}) {
    super(options);
    this.textToVideo = new TextToVideo(this.http);
    this.imageToVideo = new ImageToVideo(this.http);
    this.editVideo = new EditVideo(this.http);
  }
}

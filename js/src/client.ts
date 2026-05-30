import { createHttpClient, type ClientOptions } from '@runapi.ai/core';
import { EditVideo } from './resources/edit-video';
import { ImageToVideo } from './resources/image-to-video';
import { ReferenceToVideo } from './resources/reference-to-video';
import { TextToVideo } from './resources/text-to-video';

export class HappyHorseClient {
  public readonly textToVideo: TextToVideo;
  public readonly imageToVideo: ImageToVideo;
  public readonly referenceToVideo: ReferenceToVideo;
  public readonly editVideo: EditVideo;

  constructor(options: ClientOptions = {}) {
    const http = createHttpClient(options);
    this.textToVideo = new TextToVideo(http);
    this.imageToVideo = new ImageToVideo(http);
    this.referenceToVideo = new ReferenceToVideo(http);
    this.editVideo = new EditVideo(http);
  }
}

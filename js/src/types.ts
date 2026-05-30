import type { AsyncTaskStatus } from '@runapi.ai/core';

export type HappyHorseTextToVideoModel = 'happyhorse-text-to-video';
export type HappyHorseImageToVideoModel = 'happyhorse-image-to-video';
export type HappyHorseReferenceToVideoModel = 'happyhorse-reference-to-video';
export type HappyHorseEditVideoModel = 'happyhorse-video-edit';
export type HappyHorseResolution = '720p' | '1080p';
export type HappyHorseAspectRatio = '16:9' | '9:16' | '1:1' | '4:3' | '3:4';
export type HappyHorseAudioSetting = 'auto' | 'origin';

export interface TextToVideoParams {
  model: HappyHorseTextToVideoModel;
  prompt: string;
  resolution?: HappyHorseResolution;
  aspect_ratio?: HappyHorseAspectRatio;
  duration?: number;
  seed?: number;
  callback_url?: string;
}

export interface ImageToVideoParams {
  model: HappyHorseImageToVideoModel;
  image_urls: string[];
  prompt?: string;
  resolution?: HappyHorseResolution;
  duration?: number;
  seed?: number;
  callback_url?: string;
}

export interface ReferenceToVideoParams {
  model: HappyHorseReferenceToVideoModel;
  prompt: string;
  reference_image: string[];
  resolution?: HappyHorseResolution;
  aspect_ratio?: HappyHorseAspectRatio;
  duration?: number;
  seed?: number;
  callback_url?: string;
}

export interface EditVideoParams {
  model: HappyHorseEditVideoModel;
  prompt: string;
  video_url: string;
  reference_image?: string[];
  resolution?: HappyHorseResolution;
  audio_setting?: HappyHorseAudioSetting;
  seed?: number;
  callback_url?: string;
}

export interface TaskCreateResponse {
  id: string;
  status?: AsyncTaskStatus;
}

export interface Video {
  url: string;
}

export interface TextToVideoResponse {
  id: string;
  status: AsyncTaskStatus;
  videos?: Video[];
  error?: string;
  [key: string]: unknown;
}

export type CompletedTextToVideoResponse = TextToVideoResponse & {
  status: 'completed';
  videos: Video[];
};

export type ImageToVideoResponse = TextToVideoResponse;

export type CompletedImageToVideoResponse = ImageToVideoResponse & {
  status: 'completed';
  videos: Video[];
};

export type ReferenceToVideoResponse = TextToVideoResponse;

export type CompletedReferenceToVideoResponse = ReferenceToVideoResponse & {
  status: 'completed';
  videos: Video[];
};

export type EditVideoResponse = TextToVideoResponse;

export type CompletedEditVideoResponse = EditVideoResponse & {
  status: 'completed';
  videos: Video[];
};

import type { AsyncTaskStatus } from '@runapi.ai/core';

export type HappyHorseTextToVideoModel = 'happyhorse-text-to-video' | 'happyhorse-character';
export type HappyHorseImageToVideoModel = 'happyhorse-image-to-video';
export type HappyHorseEditVideoModel = 'happyhorse-edit-video';
export type HappyHorseOutputResolution = '720p' | '1080p';
export type HappyHorseAspectRatio = '16:9' | '9:16' | '1:1' | '4:3' | '3:4';
export type HappyHorseAudioSetting = 'auto' | 'original';

export interface TextToVideoParams {
  model: HappyHorseTextToVideoModel;
  prompt: string;
  reference_image_urls?: string[];
  output_resolution?: HappyHorseOutputResolution;
  aspect_ratio?: HappyHorseAspectRatio;
  duration_seconds?: number;
  seed?: number;
  callback_url?: string;
}

export interface ImageToVideoParams {
  model: HappyHorseImageToVideoModel;
  first_frame_image_url: string;
  prompt?: string;
  output_resolution?: HappyHorseOutputResolution;
  duration_seconds?: number;
  seed?: number;
  callback_url?: string;
}

export interface EditVideoParams {
  model: HappyHorseEditVideoModel;
  prompt: string;
  source_video_url: string;
  reference_image_urls?: string[];
  output_resolution?: HappyHorseOutputResolution;
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

export type EditVideoResponse = TextToVideoResponse;

export type CompletedEditVideoResponse = EditVideoResponse & {
  status: 'completed';
  videos: Video[];
};

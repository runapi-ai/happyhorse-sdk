import type { AsyncTaskStatus } from '@runapi.ai/core';

/**
 * Text-to-video model variants. happyhorse-character requires 1-9 reference_image_urls
 * for character-consistent generation; happyhorse-text-to-video is the standard model.
 */
export type HappyHorseTextToVideoModel = 'happyhorse-text-to-video' | 'happyhorse-character';
export type HappyHorseImageToVideoModel = 'happyhorse-image-to-video';
export type HappyHorseEditVideoModel = 'happyhorse-edit-video';
/** Output resolution. Defaults to 1080p. */
export type HappyHorseOutputResolution = '720p' | '1080p';
/** Aspect ratio. Defaults to 16:9. */
export type HappyHorseAspectRatio = '16:9' | '9:16' | '1:1' | '4:3' | '3:4';
/** Audio handling for video editing. "auto" lets the model decide; "original" preserves the source video's audio. */
export type HappyHorseAudioSetting = 'auto' | 'original';

/**
 * Parameters for text-to-video generation. When using happyhorse-character,
 * reference_image_urls (1-9 images) is required for character consistency.
 */
export interface TextToVideoParams {
  model: HappyHorseTextToVideoModel;
  /** Video description prompt. Up to 5000 non-Chinese characters or 2500 Chinese characters. */
  prompt: string;
  /** Character reference images for happyhorse-character (1-9 URLs). Not supported on happyhorse-text-to-video. */
  reference_image_urls?: string[];
  /** Output resolution. Defaults to 1080p. */
  output_resolution?: HappyHorseOutputResolution;
  /** Aspect ratio. Defaults to 16:9. */
  aspect_ratio?: HappyHorseAspectRatio;
  /** Duration in seconds (3-15). Defaults to 5. */
  duration_seconds?: number;
  /** Reproducibility seed (0-2147483647). */
  seed?: number;
  /** URL for completion callback notifications. */
  callback_url?: string;
}

/**
 * Parameters for image-to-video animation. The first-frame image is animated
 * into video, optionally guided by a text prompt.
 */
export interface ImageToVideoParams {
  model: HappyHorseImageToVideoModel;
  /** Source image URL used as the video's opening frame. */
  first_frame_image_url: string;
  /** Optional motion description prompt. */
  prompt?: string;
  /** Output resolution. Defaults to 1080p. */
  output_resolution?: HappyHorseOutputResolution;
  /** Duration in seconds (3-15). Defaults to 5. */
  duration_seconds?: number;
  /** Reproducibility seed (0-2147483647). */
  seed?: number;
  /** URL for completion callback notifications. */
  callback_url?: string;
}

/**
 * Parameters for video editing. Transforms the source video according to the prompt.
 * Source video must be 3-60 seconds, MP4 or MOV format. Use audio_setting to control
 * whether the original audio is preserved.
 */
export interface EditVideoParams {
  model: HappyHorseEditVideoModel;
  /** Editing instruction prompt describing the desired transformation. */
  prompt: string;
  /** Source video URL to transform (3-60s, MP4/MOV). */
  source_video_url: string;
  /** Optional reference images to guide the edit (up to 5 URLs). */
  reference_image_urls?: string[];
  /** Output resolution. Defaults to 1080p. */
  output_resolution?: HappyHorseOutputResolution;
  /** Audio handling: "auto" lets the model decide, "original" preserves the source audio. */
  audio_setting?: HappyHorseAudioSetting;
  /** Reproducibility seed (0-2147483647). */
  seed?: number;
  /** URL for completion callback notifications. */
  callback_url?: string;
}

export interface TaskCreateResponse {
  id: string;
  status?: AsyncTaskStatus;
}

/** A generated video file with a download URL. */
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

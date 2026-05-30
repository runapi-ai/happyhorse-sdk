import { beforeEach, describe, expect, it, vi } from 'vitest';
import type { HttpClient } from '@runapi.ai/core';
import { EditVideo } from '../../src/resources/edit-video';
import { ImageToVideo } from '../../src/resources/image-to-video';
import { ReferenceToVideo } from '../../src/resources/reference-to-video';
import { TextToVideo } from '../../src/resources/text-to-video';

describe('HappyHorse resources', () => {
  const mockHttp: HttpClient = {
    request: vi.fn(),
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('creates text-to-video tasks with flat params', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({ id: 'task-1' });
    const textToVideo = new TextToVideo(mockHttp);

    await textToVideo.create({
      model: 'happyhorse-text-to-video',
      prompt: 'A cardboard city lights up at night',
      resolution: '1080p',
      aspect_ratio: '16:9',
      duration: 5,
      seed: 1622429582,
    });

    expect(mockHttp.request).toHaveBeenCalledWith('POST', '/api/v1/happyhorse/text_to_video', {
      body: {
        model: 'happyhorse-text-to-video',
        prompt: 'A cardboard city lights up at night',
        resolution: '1080p',
        aspect_ratio: '16:9',
        duration: 5,
        seed: 1622429582,
      },
    });
  });

  it('gets text-to-video tasks by id', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({
      id: 'task-2',
      status: 'completed',
      videos: [{ url: 'https://tempfile.runapi.ai/happyhorse/out.mp4' }],
    });
    const textToVideo = new TextToVideo(mockHttp);

    const result = await textToVideo.get('task-2');

    expect(mockHttp.request).toHaveBeenCalledWith('GET', '/api/v1/happyhorse/text_to_video/task-2', {});
    expect(result.videos?.[0]?.url).toBe('https://tempfile.runapi.ai/happyhorse/out.mp4');
  });

  it('creates image-to-video tasks with image_urls', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({ id: 'task-3' });
    const imageToVideo = new ImageToVideo(mockHttp);

    await imageToVideo.create({
      model: 'happyhorse-image-to-video',
      image_urls: ['https://cdn.runapi.ai/public/samples/image-to-video.jpg'],
      prompt: 'Bring the still frame to life',
      resolution: '720p',
      duration: 3,
      seed: 492720,
    });

    expect(mockHttp.request).toHaveBeenCalledWith('POST', '/api/v1/happyhorse/image_to_video', {
      body: {
        model: 'happyhorse-image-to-video',
        image_urls: ['https://cdn.runapi.ai/public/samples/image-to-video.jpg'],
        prompt: 'Bring the still frame to life',
        resolution: '720p',
        duration: 3,
        seed: 492720,
      },
    });
  });

  it('gets image-to-video tasks by id', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({
      id: 'task-4',
      status: 'completed',
      videos: [{ url: 'https://tempfile.runapi.ai/happyhorse/i2v.mp4' }],
    });
    const imageToVideo = new ImageToVideo(mockHttp);

    const result = await imageToVideo.get('task-4');

    expect(mockHttp.request).toHaveBeenCalledWith('GET', '/api/v1/happyhorse/image_to_video/task-4', {});
    expect(result.videos?.[0]?.url).toBe('https://tempfile.runapi.ai/happyhorse/i2v.mp4');
  });

  it('creates reference-to-video tasks with reference_image', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({ id: 'task-5' });
    const referenceToVideo = new ReferenceToVideo(mockHttp);

    await referenceToVideo.create({
      model: 'happyhorse-reference-to-video',
      prompt: 'Character1 walks through a paper city',
      reference_image: ['https://cdn.runapi.ai/public/samples/reference-1.jpg'],
      resolution: '720p',
      aspect_ratio: '9:16',
      duration: 3,
      seed: 493720,
    });

    expect(mockHttp.request).toHaveBeenCalledWith('POST', '/api/v1/happyhorse/reference_to_video', {
      body: {
        model: 'happyhorse-reference-to-video',
        prompt: 'Character1 walks through a paper city',
        reference_image: ['https://cdn.runapi.ai/public/samples/reference-1.jpg'],
        resolution: '720p',
        aspect_ratio: '9:16',
        duration: 3,
        seed: 493720,
      },
    });
  });

  it('gets reference-to-video tasks by id', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({
      id: 'task-6',
      status: 'completed',
      videos: [{ url: 'https://tempfile.runapi.ai/happyhorse/r2v.mp4' }],
    });
    const referenceToVideo = new ReferenceToVideo(mockHttp);

    const result = await referenceToVideo.get('task-6');

    expect(mockHttp.request).toHaveBeenCalledWith('GET', '/api/v1/happyhorse/reference_to_video/task-6', {});
    expect(result.videos?.[0]?.url).toBe('https://tempfile.runapi.ai/happyhorse/r2v.mp4');
  });

  it('creates edit-video tasks with video_url and reference_image', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({ id: 'task-7' });
    const editVideo = new EditVideo(mockHttp);

    await editVideo.create({
      model: 'happyhorse-video-edit',
      prompt: 'Make the source video look cinematic',
      video_url: 'https://tempfile.runapi.ai/happyhorse/source-5s.mp4',
      reference_image: ['https://cdn.runapi.ai/public/samples/reference-1.jpg'],
      resolution: '720p',
      audio_setting: 'origin',
      seed: 494720,
    });

    expect(mockHttp.request).toHaveBeenCalledWith('POST', '/api/v1/happyhorse/edit_video', {
      body: {
        model: 'happyhorse-video-edit',
        prompt: 'Make the source video look cinematic',
        video_url: 'https://tempfile.runapi.ai/happyhorse/source-5s.mp4',
        reference_image: ['https://cdn.runapi.ai/public/samples/reference-1.jpg'],
        resolution: '720p',
        audio_setting: 'origin',
        seed: 494720,
      },
    });
  });

  it('gets edit-video tasks by id', async () => {
    vi.mocked(mockHttp.request).mockResolvedValueOnce({
      id: 'task-8',
      status: 'completed',
      videos: [{ url: 'https://tempfile.runapi.ai/happyhorse/edit.mp4' }],
    });
    const editVideo = new EditVideo(mockHttp);

    const result = await editVideo.get('task-8');

    expect(mockHttp.request).toHaveBeenCalledWith('GET', '/api/v1/happyhorse/edit_video/task-8', {});
    expect(result.videos?.[0]?.url).toBe('https://tempfile.runapi.ai/happyhorse/edit.mp4');
  });
});

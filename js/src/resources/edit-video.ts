import type { HttpClient, PollingOptions, RequestOptions } from '@runapi.ai/core';
import { compactParams } from '@runapi.ai/core';
import { pollUntilComplete } from '@runapi.ai/core/internal';
import type {
  CompletedEditVideoResponse,
  EditVideoParams,
  EditVideoResponse,
  TaskCreateResponse,
} from '../types';

const ENDPOINT = '/api/v1/happyhorse/edit_video';

export class EditVideo {
  constructor(private readonly http: HttpClient) {}

  async run(params: EditVideoParams, options?: RequestOptions & PollingOptions): Promise<CompletedEditVideoResponse> {
    const { id } = await this.create(params, options);
    const response = await pollUntilComplete<EditVideoResponse>(() => this.get(id, options), {
      maxWaitMs: options?.maxWaitMs,
      pollIntervalMs: options?.pollIntervalMs,
    });
    return response as CompletedEditVideoResponse;
  }

  async create(params: EditVideoParams, options?: RequestOptions): Promise<TaskCreateResponse> {
    return this.http.request<TaskCreateResponse>('POST', ENDPOINT, {
      body: compactParams(params),
      ...options,
    });
  }

  async get(id: string, options?: RequestOptions): Promise<EditVideoResponse> {
    return this.http.request<EditVideoResponse>('GET', `${ENDPOINT}/${id}`, options ?? {});
  }
}

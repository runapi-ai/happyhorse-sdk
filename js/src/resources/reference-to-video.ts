import type { HttpClient, PollingOptions, RequestOptions } from '@runapi.ai/core';
import { compactParams } from '@runapi.ai/core';
import { pollUntilComplete } from '@runapi.ai/core/internal';
import type {
  CompletedReferenceToVideoResponse,
  ReferenceToVideoParams,
  ReferenceToVideoResponse,
  TaskCreateResponse,
} from '../types';

const ENDPOINT = '/api/v1/happyhorse/reference_to_video';

export class ReferenceToVideo {
  constructor(private readonly http: HttpClient) {}

  async run(params: ReferenceToVideoParams, options?: RequestOptions & PollingOptions): Promise<CompletedReferenceToVideoResponse> {
    const { id } = await this.create(params, options);
    const response = await pollUntilComplete<ReferenceToVideoResponse>(() => this.get(id, options), {
      maxWaitMs: options?.maxWaitMs,
      pollIntervalMs: options?.pollIntervalMs,
    });
    return response as CompletedReferenceToVideoResponse;
  }

  async create(params: ReferenceToVideoParams, options?: RequestOptions): Promise<TaskCreateResponse> {
    return this.http.request<TaskCreateResponse>('POST', ENDPOINT, {
      body: compactParams(params),
      ...options,
    });
  }

  async get(id: string, options?: RequestOptions): Promise<ReferenceToVideoResponse> {
    return this.http.request<ReferenceToVideoResponse>('GET', `${ENDPOINT}/${id}`, options ?? {});
  }
}

import { describe, expect, it } from 'vitest';
import { HappyHorseClient } from '../src';

describe('HappyHorseClient', () => {
  it('exposes video resources', () => {
    const client = new HappyHorseClient({ apiKey: 'test-key' });

    expect(client.textToVideo).toBeDefined();
    expect(client.imageToVideo).toBeDefined();
    expect(client.referenceToVideo).toBeDefined();
    expect(client.editVideo).toBeDefined();
  });
});

package happyhorse

import (
	"context"
	"encoding/json"
	"testing"

	"github.com/runapi-ai/core-sdk/go/core"
)

type stubHTTPClient struct {
	method string
	path   string
	body   any
}

func (s *stubHTTPClient) Request(_ context.Context, method, path string, opts *core.HTTPRequestOptions) (json.RawMessage, error) {
	s.method = method
	s.path = path
	if opts != nil {
		s.body = opts.Body
	}
	return json.RawMessage(`{"id":"task_123","status":"processing"}`), nil
}

func TestTextToVideoCreateSendsCorrectRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	duration := 5
	seed := 1622429582

	_, err := client.TextToVideo.Create(context.Background(), TextToVideoParams{
		Model:       ModelTextToVideo,
		Prompt:      "A cardboard city lights up at night",
		Resolution:  Resolution1080P,
		AspectRatio: AspectRatio169,
		Duration:    &duration,
		Seed:        &seed,
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/happyhorse/text_to_video" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body, ok := stub.body.(map[string]any)
	if !ok {
		t.Fatalf("expected flat body map, got %T", stub.body)
	}
	if body["model"] != string(ModelTextToVideo) || body["resolution"] != string(Resolution1080P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	if body["duration"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration and seed in body: %#v", body)
	}
}

func TestTextToVideoGetSendsCorrectPath(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	_, err := client.TextToVideo.Get(context.Background(), "task_abc")
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "GET" || stub.path != "/api/v1/happyhorse/text_to_video/task_abc" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
}

func TestImageToVideoCreateSendsCorrectRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	duration := 3
	seed := 492720

	_, err := client.ImageToVideo.Create(context.Background(), ImageToVideoParams{
		Model:      ModelImageToVideo,
		ImageURLs:  []string{"https://cdn.runapi.ai/public/samples/image-to-video.jpg"},
		Prompt:     "Bring the still frame to life",
		Resolution: Resolution720P,
		Duration:   &duration,
		Seed:       &seed,
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/happyhorse/image_to_video" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body, ok := stub.body.(map[string]any)
	if !ok {
		t.Fatalf("expected flat body map, got %T", stub.body)
	}
	if body["model"] != string(ModelImageToVideo) || body["resolution"] != string(Resolution720P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	imageURLs, ok := body["image_urls"].([]any)
	if !ok || len(imageURLs) != 1 {
		t.Fatalf("expected image_urls array in body: %#v", body)
	}
	if body["duration"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration and seed in body: %#v", body)
	}
}

func TestImageToVideoGetSendsCorrectPath(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	_, err := client.ImageToVideo.Get(context.Background(), "task_i2v")
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "GET" || stub.path != "/api/v1/happyhorse/image_to_video/task_i2v" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
}

func TestReferenceToVideoCreateSendsCorrectRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	duration := 3
	seed := 493720

	_, err := client.ReferenceToVideo.Create(context.Background(), ReferenceToVideoParams{
		Model:          ModelReferenceToVideo,
		Prompt:         "Character1 walks through a paper city",
		ReferenceImage: []string{"https://cdn.runapi.ai/public/samples/reference-1.jpg"},
		Resolution:     Resolution720P,
		AspectRatio:    AspectRatio916,
		Duration:       &duration,
		Seed:           &seed,
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/happyhorse/reference_to_video" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body, ok := stub.body.(map[string]any)
	if !ok {
		t.Fatalf("expected flat body map, got %T", stub.body)
	}
	if body["model"] != string(ModelReferenceToVideo) || body["resolution"] != string(Resolution720P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	referenceImage, ok := body["reference_image"].([]any)
	if !ok || len(referenceImage) != 1 {
		t.Fatalf("expected reference_image array in body: %#v", body)
	}
	if body["duration"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration and seed in body: %#v", body)
	}
}

func TestReferenceToVideoGetSendsCorrectPath(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	_, err := client.ReferenceToVideo.Get(context.Background(), "task_r2v")
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "GET" || stub.path != "/api/v1/happyhorse/reference_to_video/task_r2v" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
}

func TestEditVideoCreateSendsCorrectRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	seed := 494720

	_, err := client.EditVideo.Create(context.Background(), EditVideoParams{
		Model:          ModelEditVideo,
		Prompt:         "Make the source video look cinematic",
		VideoURL:       "https://tempfile.runapi.ai/happyhorse/source-5s.mp4",
		ReferenceImage: []string{"https://cdn.runapi.ai/public/samples/reference-1.jpg"},
		Resolution:     Resolution720P,
		AudioSetting:   AudioSettingOrigin,
		Seed:           &seed,
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/happyhorse/edit_video" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body, ok := stub.body.(map[string]any)
	if !ok {
		t.Fatalf("expected flat body map, got %T", stub.body)
	}
	if body["model"] != string(ModelEditVideo) || body["video_url"] != "https://tempfile.runapi.ai/happyhorse/source-5s.mp4" {
		t.Fatalf("unexpected body: %#v", body)
	}
	referenceImage, ok := body["reference_image"].([]any)
	if !ok || len(referenceImage) != 1 {
		t.Fatalf("expected reference_image array in body: %#v", body)
	}
	if body["audio_setting"] != string(AudioSettingOrigin) || body["seed"] != float64(seed) {
		t.Fatalf("expected audio_setting and numeric seed in body: %#v", body)
	}
}

func TestEditVideoGetSendsCorrectPath(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	_, err := client.EditVideo.Get(context.Background(), "task_edit")
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "GET" || stub.path != "/api/v1/happyhorse/edit_video/task_edit" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
}

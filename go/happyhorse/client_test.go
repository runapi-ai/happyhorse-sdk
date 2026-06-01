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
		Model:            ModelTextToVideo,
		Prompt:           "A cardboard city lights up at night",
		OutputResolution: OutputResolution1080P,
		AspectRatio:      AspectRatio169,
		DurationSeconds:  &duration,
		Seed:             &seed,
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
	if body["model"] != string(ModelTextToVideo) || body["output_resolution"] != string(OutputResolution1080P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	if body["duration_seconds"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration_seconds and seed in body: %#v", body)
	}
}

func TestTextToVideoCreateSendsCharacterRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	duration := 3
	seed := 493720

	_, err := client.TextToVideo.Create(context.Background(), TextToVideoParams{
		Model:              ModelCharacter,
		Prompt:             "Character1 walks through a paper city",
		ReferenceImageURLs: []string{"https://cdn.runapi.ai/public/samples/reference-1.jpg"},
		OutputResolution:   OutputResolution720P,
		AspectRatio:        AspectRatio916,
		DurationSeconds:    &duration,
		Seed:               &seed,
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
	if body["model"] != string(ModelCharacter) || body["output_resolution"] != string(OutputResolution720P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	referenceImageURLs, ok := body["reference_image_urls"].([]any)
	if !ok || len(referenceImageURLs) != 1 {
		t.Fatalf("expected reference_image_urls array in body: %#v", body)
	}
	if body["duration_seconds"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration_seconds and seed in body: %#v", body)
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
		Model:              ModelImageToVideo,
		FirstFrameImageURL: "https://cdn.runapi.ai/public/samples/image-to-video.jpg",
		Prompt:             "Bring the still frame to life",
		OutputResolution:   OutputResolution720P,
		DurationSeconds:    &duration,
		Seed:               &seed,
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
	if body["model"] != string(ModelImageToVideo) || body["output_resolution"] != string(OutputResolution720P) {
		t.Fatalf("unexpected body: %#v", body)
	}
	if body["first_frame_image_url"] != "https://cdn.runapi.ai/public/samples/image-to-video.jpg" {
		t.Fatalf("expected first_frame_image_url in body: %#v", body)
	}
	if _, ok := body["image_urls"]; ok {
		t.Fatalf("expected provider image_urls field to be absent from public body: %#v", body)
	}
	if body["duration_seconds"] != float64(duration) || body["seed"] != float64(seed) {
		t.Fatalf("expected numeric duration_seconds and seed in body: %#v", body)
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

func TestEditVideoCreateSendsCorrectRequest(t *testing.T) {
	stub := &stubHTTPClient{}
	client := NewClientWithHTTP(stub)
	seed := 494720

	_, err := client.EditVideo.Create(context.Background(), EditVideoParams{
		Model:              ModelEditVideo,
		Prompt:             "Make the source video look cinematic",
		SourceVideoURL:     "https://tempfile.runapi.ai/happyhorse/source-5s.mp4",
		ReferenceImageURLs: []string{"https://cdn.runapi.ai/public/samples/reference-1.jpg"},
		OutputResolution:   OutputResolution720P,
		AudioSetting:       AudioSettingOriginal,
		Seed:               &seed,
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
	if body["model"] != string(ModelEditVideo) || body["source_video_url"] != "https://tempfile.runapi.ai/happyhorse/source-5s.mp4" {
		t.Fatalf("unexpected body: %#v", body)
	}
	if _, ok := body["video_url"]; ok {
		t.Fatalf("expected provider video_url field to be absent from public body: %#v", body)
	}
	if body["output_resolution"] != string(OutputResolution720P) {
		t.Fatalf("expected output_resolution in body: %#v", body)
	}
	referenceImage, ok := body["reference_image_urls"].([]any)
	if !ok || len(referenceImage) != 1 {
		t.Fatalf("expected reference_image_urls array in body: %#v", body)
	}
	if _, ok := body["reference_image"]; ok {
		t.Fatalf("expected provider reference_image field to be absent from public body: %#v", body)
	}
	if body["audio_setting"] != string(AudioSettingOriginal) || body["seed"] != float64(seed) {
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

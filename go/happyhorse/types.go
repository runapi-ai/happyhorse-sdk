package happyhorse

// TextToVideoModel selects the HappyHorse text-to-video engine.
type TextToVideoModel string

// ImageToVideoModel selects the HappyHorse image-to-video engine.
type ImageToVideoModel string

// EditVideoModel selects the HappyHorse edit-video engine.
type EditVideoModel string

// OutputResolution controls the output video resolution.
type OutputResolution string

// AspectRatio controls the output video aspect ratio.
type AspectRatio string

// AudioSetting controls how audio is handled in edit-video tasks.
type AudioSetting string

// TaskStatus is the async task lifecycle state (e.g. "processing", "completed", "failed").
type TaskStatus string

const (
	// ModelTextToVideo generates video from a text prompt.
	ModelTextToVideo TextToVideoModel = "happyhorse-text-to-video"
	// ModelCharacter generates character-consistent video. Requires ReferenceImageURLs (1-9 images).
	ModelCharacter TextToVideoModel = "happyhorse-character"
	// ModelImageToVideo animates a still first-frame image into video.
	ModelImageToVideo ImageToVideoModel = "happyhorse-image-to-video"
	// ModelEditVideo transforms an existing video guided by a text prompt.
	ModelEditVideo EditVideoModel = "happyhorse-edit-video"

	OutputResolution720P  OutputResolution = "720p"
	OutputResolution1080P OutputResolution = "1080p"
	AspectRatio169        AspectRatio      = "16:9"
	AspectRatio916        AspectRatio      = "9:16"
	AspectRatio11         AspectRatio      = "1:1"
	AspectRatio43         AspectRatio      = "4:3"
	AspectRatio34         AspectRatio      = "3:4"
	// AudioSettingAuto lets the model decide whether to regenerate or preserve audio.
	AudioSettingAuto AudioSetting = "auto"
	// AudioSettingOriginal preserves the source video's original audio track.
	AudioSettingOriginal AudioSetting = "original"
)

// AsyncTaskResponse carries the task ID, lifecycle status, and error for all HappyHorse async operations.
type AsyncTaskResponse struct {
	ID     string     `json:"id"`
	Status TaskStatus `json:"status"`
	Error  string     `json:"error,omitempty"`
}

func (r AsyncTaskResponse) GetID() string     { return r.ID }
func (r AsyncTaskResponse) GetStatus() string { return string(r.Status) }
func (r AsyncTaskResponse) GetError() string  { return r.Error }

// Video holds a URL to a generated video file.
type Video struct {
	URL string `json:"url"`
}

// TextToVideoResponse is the completed result of a text-to-video, image-to-video, or edit-video task.
type TextToVideoResponse struct {
	AsyncTaskResponse
	Videos []Video `json:"videos,omitempty"`
}

// TextToVideoParams configures text-to-video and character-consistent video generation.
// When Model is [ModelCharacter], ReferenceImageURLs (1-9 images) is required for identity consistency.
type TextToVideoParams struct {
	Model              TextToVideoModel `json:"model" help:"required; model slug"`
	Prompt             string           `json:"prompt" help:"required; up to 5000 non-Chinese chars or 2500 Chinese chars"`
	ReferenceImageURLs []string         `json:"reference_image_urls,omitempty" help:"required for happyhorse-character; 1 to 9 public reference image URLs"`
	OutputResolution   OutputResolution `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1080p"`
	AspectRatio        AspectRatio      `json:"aspect_ratio,omitempty" help:"optional; output aspect ratio; Default: 16:9"`
	DurationSeconds    *int             `json:"duration_seconds,omitempty" help:"optional; duration in seconds; Default: 5"`
	Seed               *int             `json:"seed,omitempty" help:"optional; integer from 0 to 2147483647"`
	CallbackURL        string           `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

// ImageToVideoParams configures image-to-video generation from a first-frame image.
type ImageToVideoParams struct {
	Model              ImageToVideoModel `json:"model" help:"required; model slug"`
	FirstFrameImageURL string            `json:"first_frame_image_url" help:"required; public first-frame image URL"`
	Prompt             string            `json:"prompt,omitempty" help:"optional; up to 5000 non-Chinese chars or 2500 Chinese chars"`
	OutputResolution   OutputResolution  `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1080p"`
	DurationSeconds    *int              `json:"duration_seconds,omitempty" help:"optional; duration in seconds; Default: 5"`
	Seed               *int              `json:"seed,omitempty" help:"optional; integer from 0 to 2147483647"`
	CallbackURL        string            `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

// EditVideoParams configures video editing. Transforms an existing SourceVideoURL (3-60s MP4/MOV)
// guided by a text prompt and optional reference images. Use AudioSetting to preserve the original audio.
type EditVideoParams struct {
	Model              EditVideoModel   `json:"model" help:"required; model slug"`
	Prompt             string           `json:"prompt" help:"required; edit instruction, up to 5000 non-Chinese chars or 2500 Chinese chars"`
	SourceVideoURL     string           `json:"source_video_url" help:"required; exactly one public MP4 or MOV source video URL, 3 to 60 seconds"`
	ReferenceImageURLs []string         `json:"reference_image_urls,omitempty" help:"optional; up to 5 public reference image URLs"`
	OutputResolution   OutputResolution `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1080p"`
	AudioSetting       AudioSetting     `json:"audio_setting,omitempty" help:"optional; audio handling setting; Default: auto"`
	Seed               *int             `json:"seed,omitempty" help:"optional; integer from 0 to 2147483647"`
	CallbackURL        string           `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

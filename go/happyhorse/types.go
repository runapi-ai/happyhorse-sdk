package happyhorse

type TextToVideoModel string
type ImageToVideoModel string
type EditVideoModel string
type OutputResolution string
type AspectRatio string
type AudioSetting string
type TaskStatus string

const (
	ModelTextToVideo  TextToVideoModel  = "happyhorse-text-to-video"
	ModelCharacter    TextToVideoModel  = "happyhorse-character"
	ModelImageToVideo ImageToVideoModel = "happyhorse-image-to-video"
	ModelEditVideo    EditVideoModel    = "happyhorse-edit-video"

	OutputResolution720P  OutputResolution = "720p"
	OutputResolution1080P OutputResolution = "1080p"
	AspectRatio169        AspectRatio      = "16:9"
	AspectRatio916        AspectRatio      = "9:16"
	AspectRatio11         AspectRatio      = "1:1"
	AspectRatio43         AspectRatio      = "4:3"
	AspectRatio34         AspectRatio      = "3:4"
	AudioSettingAuto      AudioSetting     = "auto"
	AudioSettingOriginal  AudioSetting     = "original"
)

type AsyncTaskResponse struct {
	ID     string     `json:"id"`
	Status TaskStatus `json:"status"`
	Error  string     `json:"error,omitempty"`
}

func (r AsyncTaskResponse) GetID() string     { return r.ID }
func (r AsyncTaskResponse) GetStatus() string { return string(r.Status) }
func (r AsyncTaskResponse) GetError() string  { return r.Error }

type Video struct {
	URL string `json:"url"`
}

type TextToVideoResponse struct {
	AsyncTaskResponse
	Videos []Video `json:"videos,omitempty"`
}

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

type ImageToVideoParams struct {
	Model              ImageToVideoModel `json:"model" help:"required; model slug"`
	FirstFrameImageURL string            `json:"first_frame_image_url" help:"required; public first-frame image URL"`
	Prompt             string            `json:"prompt,omitempty" help:"optional; up to 5000 non-Chinese chars or 2500 Chinese chars"`
	OutputResolution   OutputResolution  `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1080p"`
	DurationSeconds    *int              `json:"duration_seconds,omitempty" help:"optional; duration in seconds; Default: 5"`
	Seed               *int              `json:"seed,omitempty" help:"optional; integer from 0 to 2147483647"`
	CallbackURL        string            `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

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

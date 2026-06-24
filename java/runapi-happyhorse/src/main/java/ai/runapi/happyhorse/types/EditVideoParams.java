package ai.runapi.happyhorse.types;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Parameters for edit video operations. */
public final class EditVideoParams {
  private final String model;
  private final String prompt;
  private final String sourceVideoUrl;
  private final List<String> referenceImageUrls;
  private final String outputResolution;
  private final String audioSetting;
  private final Integer seed;
  private final String callbackUrl;

  private EditVideoParams(Builder builder) {
    this.model = builder.model;
    this.prompt = builder.prompt;
    this.sourceVideoUrl = HappyhorseParamUtils.requireNonBlank(builder.sourceVideoUrl, "sourceVideoUrl");
    this.referenceImageUrls = HappyhorseParamUtils.strings(builder.referenceImageUrls);
    this.outputResolution = builder.outputResolution;
    this.audioSetting = builder.audioSetting;
    this.seed = builder.seed;
    this.callbackUrl = builder.callbackUrl;
  }

  /** Creates a new EditVideoParams builder. */
  public static Builder builder() {
    return new Builder();
  }

  /** Returns the RunAPI action key for this request. */
  public String action() {
    return "happyhorse/edit-video";
  }

  /** Converts these parameters to the JSON request body shape. */
  public Map<String, Object> toMap() {
    Map<String, Object> raw = new LinkedHashMap<String, Object>();
    raw.put("model", HappyhorseParamUtils.wireValue(model));
    raw.put("prompt", HappyhorseParamUtils.wireValue(prompt));
    raw.put("source_video_url", HappyhorseParamUtils.wireValue(sourceVideoUrl));
    raw.put("reference_image_urls", HappyhorseParamUtils.wireValue(referenceImageUrls));
    raw.put("output_resolution", HappyhorseParamUtils.wireValue(outputResolution));
    raw.put("audio_setting", HappyhorseParamUtils.wireValue(audioSetting));
    raw.put("seed", HappyhorseParamUtils.wireValue(seed));
    raw.put("callback_url", HappyhorseParamUtils.wireValue(callbackUrl));
    return HappyhorseParamUtils.compact(raw);
  }



  /** Builder for {@link EditVideoParams}. */
  public static final class Builder {
    private String model;
    private String prompt;
    private String sourceVideoUrl;
    private List<String> referenceImageUrls;
    private String outputResolution;
    private String audioSetting;
    private Integer seed;
    private String callbackUrl;

    private Builder() {}

    /** Sets the model slug using a typed model value. */
    public Builder model(EditVideoModel value) {
      this.model = java.util.Objects.requireNonNull(value, "model").value();
      return this;
    }

    /** Sets the model slug using a string value. */
    public Builder model(String value) {
      this.model = HappyhorseParamUtils.requireNonBlankTrim(value, "model");
      return this;
    }


    /** Sets the text prompt. */
    public Builder prompt(String value) {
      this.prompt = HappyhorseParamUtils.requireNonBlank(value, "prompt");
      return this;
    }

    /** Sets the source video URL. */
    public Builder sourceVideoUrl(String value) {
      this.sourceVideoUrl = HappyhorseParamUtils.requireNonBlank(value, "sourceVideoUrl");
      return this;
    }

    /** Sets the reference image URLs. */
    public Builder referenceImageUrls(List<String> value) {
      this.referenceImageUrls = value;
      return this;
    }

    /** Sets the output resolution. */
    public Builder outputResolution(String value) {
      this.outputResolution = HappyhorseParamUtils.requireNonBlank(value, "outputResolution");
      return this;
    }

    /** Sets the audio setting. */
    public Builder audioSetting(String value) {
      this.audioSetting = HappyhorseParamUtils.requireNonBlank(value, "audioSetting");
      return this;
    }

    /** Sets the random seed. */
    public Builder seed(int value) {
      this.seed = value;
      return this;
    }

    /** Sets the webhook URL for task completion notifications. */
    public Builder callbackUrl(String value) {
      this.callbackUrl = HappyhorseParamUtils.requireNonBlank(value, "callbackUrl");
      return this;
    }

    /** Builds immutable edit video parameters. */
    public EditVideoParams build() {
      return new EditVideoParams(this);
    }
  }
}

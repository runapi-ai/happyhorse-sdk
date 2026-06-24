package ai.runapi.happyhorse.types;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Parameters for image to video operations. */
public final class ImageToVideoParams {
  private final String model;
  private final String firstFrameImageUrl;
  private final String prompt;
  private final String outputResolution;
  private final Integer durationSeconds;
  private final Integer seed;
  private final String callbackUrl;

  private ImageToVideoParams(Builder builder) {
    this.model = builder.model;
    this.firstFrameImageUrl = HappyhorseParamUtils.requireNonBlank(builder.firstFrameImageUrl, "firstFrameImageUrl");
    this.prompt = builder.prompt;
    this.outputResolution = builder.outputResolution;
    this.durationSeconds = builder.durationSeconds;
    this.seed = builder.seed;
    this.callbackUrl = builder.callbackUrl;
  }

  /** Creates a new ImageToVideoParams builder. */
  public static Builder builder() {
    return new Builder();
  }

  /** Returns the RunAPI action key for this request. */
  public String action() {
    return "happyhorse/image-to-video";
  }

  /** Converts these parameters to the JSON request body shape. */
  public Map<String, Object> toMap() {
    Map<String, Object> raw = new LinkedHashMap<String, Object>();
    raw.put("model", HappyhorseParamUtils.wireValue(model));
    raw.put("first_frame_image_url", HappyhorseParamUtils.wireValue(firstFrameImageUrl));
    raw.put("prompt", HappyhorseParamUtils.wireValue(prompt));
    raw.put("output_resolution", HappyhorseParamUtils.wireValue(outputResolution));
    raw.put("duration_seconds", HappyhorseParamUtils.wireValue(durationSeconds));
    raw.put("seed", HappyhorseParamUtils.wireValue(seed));
    raw.put("callback_url", HappyhorseParamUtils.wireValue(callbackUrl));
    return HappyhorseParamUtils.compact(raw);
  }



  /** Builder for {@link ImageToVideoParams}. */
  public static final class Builder {
    private String model;
    private String firstFrameImageUrl;
    private String prompt;
    private String outputResolution;
    private Integer durationSeconds;
    private Integer seed;
    private String callbackUrl;

    private Builder() {}

    /** Sets the model slug using a typed model value. */
    public Builder model(ImageToVideoModel value) {
      this.model = java.util.Objects.requireNonNull(value, "model").value();
      return this;
    }

    /** Sets the model slug using a string value. */
    public Builder model(String value) {
      this.model = HappyhorseParamUtils.requireNonBlankTrim(value, "model");
      return this;
    }


    /** Sets the first frame image URL. */
    public Builder firstFrameImageUrl(String value) {
      this.firstFrameImageUrl = HappyhorseParamUtils.requireNonBlank(value, "firstFrameImageUrl");
      return this;
    }

    /** Sets the text prompt. */
    public Builder prompt(String value) {
      this.prompt = HappyhorseParamUtils.requireNonBlank(value, "prompt");
      return this;
    }

    /** Sets the output resolution. */
    public Builder outputResolution(String value) {
      this.outputResolution = HappyhorseParamUtils.requireNonBlank(value, "outputResolution");
      return this;
    }

    /** Sets the duration in seconds. */
    public Builder durationSeconds(int value) {
      this.durationSeconds = value;
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

    /** Builds immutable image to video parameters. */
    public ImageToVideoParams build() {
      return new ImageToVideoParams(this);
    }
  }
}

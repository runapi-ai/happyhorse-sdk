package ai.runapi.happyhorse.types;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Parameters for text to video operations. */
public final class TextToVideoParams {
  private final String model;
  private final String prompt;
  private final List<String> referenceImageUrls;
  private final String outputResolution;
  private final String aspectRatio;
  private final Integer durationSeconds;
  private final Integer seed;
  private final String callbackUrl;

  private TextToVideoParams(Builder builder) {
    this.model = builder.model;
    this.prompt = builder.prompt;
    this.referenceImageUrls = HappyhorseParamUtils.strings(builder.referenceImageUrls);
    this.outputResolution = builder.outputResolution;
    this.aspectRatio = builder.aspectRatio;
    this.durationSeconds = builder.durationSeconds;
    this.seed = builder.seed;
    this.callbackUrl = builder.callbackUrl;
  }

  /** Creates a new TextToVideoParams builder. */
  public static Builder builder() {
    return new Builder();
  }

  /** Returns the RunAPI action key for this request. */
  public String action() {
    return "happyhorse/text-to-video";
  }

  /** Converts these parameters to the JSON request body shape. */
  public Map<String, Object> toMap() {
    Map<String, Object> raw = new LinkedHashMap<String, Object>();
    raw.put("model", HappyhorseParamUtils.wireValue(model));
    raw.put("prompt", HappyhorseParamUtils.wireValue(prompt));
    raw.put("reference_image_urls", HappyhorseParamUtils.wireValue(referenceImageUrls));
    raw.put("output_resolution", HappyhorseParamUtils.wireValue(outputResolution));
    raw.put("aspect_ratio", HappyhorseParamUtils.wireValue(aspectRatio));
    raw.put("duration_seconds", HappyhorseParamUtils.wireValue(durationSeconds));
    raw.put("seed", HappyhorseParamUtils.wireValue(seed));
    raw.put("callback_url", HappyhorseParamUtils.wireValue(callbackUrl));
    return HappyhorseParamUtils.compact(raw);
  }



  /** Builder for {@link TextToVideoParams}. */
  public static final class Builder {
    private String model;
    private String prompt;
    private List<String> referenceImageUrls;
    private String outputResolution;
    private String aspectRatio;
    private Integer durationSeconds;
    private Integer seed;
    private String callbackUrl;

    private Builder() {}

    /** Sets the model slug using a typed model value. */
    public Builder model(TextToVideoModel value) {
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

    /** Sets the output aspect ratio. */
    public Builder aspectRatio(String value) {
      this.aspectRatio = HappyhorseParamUtils.requireNonBlank(value, "aspectRatio");
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

    /** Builds immutable text to video parameters. */
    public TextToVideoParams build() {
      return new TextToVideoParams(this);
    }
  }
}

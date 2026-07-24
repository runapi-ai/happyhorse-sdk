package ai.runapi.happyhorse.types;

import com.fasterxml.jackson.annotation.JsonCreator;

/** Model slug for image to video operations. */
public final class ImageToVideoModel extends HappyhorseValue {
  /** happyhorse-image-to-video model slug. */
  public static final ImageToVideoModel HAPPYHORSE_IMAGE_TO_VIDEO = new ImageToVideoModel("happyhorse-image-to-video");
  public static final ImageToVideoModel HAPPYHORSE_1_0_I2V = new ImageToVideoModel("happyhorse-1.0-i2v");

  /** Creates a model value from a literal model slug. */
  @JsonCreator
  public ImageToVideoModel(String value) {
    super(value);
  }
}

package ai.runapi.happyhorse.types;

import com.fasterxml.jackson.annotation.JsonCreator;

/** Model slug for text to video operations. */
public final class TextToVideoModel extends HappyhorseValue {
  /** happyhorse-character model slug. */
  public static final TextToVideoModel HAPPYHORSE_CHARACTER = new TextToVideoModel("happyhorse-character");
  /** happyhorse-text-to-video model slug. */
  public static final TextToVideoModel HAPPYHORSE_TEXT_TO_VIDEO = new TextToVideoModel("happyhorse-text-to-video");

  /** Creates a model value from a literal model slug. */
  @JsonCreator
  public TextToVideoModel(String value) {
    super(value);
  }
}

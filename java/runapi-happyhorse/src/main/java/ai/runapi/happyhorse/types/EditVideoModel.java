package ai.runapi.happyhorse.types;

import com.fasterxml.jackson.annotation.JsonCreator;

/** Model slug for edit video operations. */
public final class EditVideoModel extends HappyhorseValue {
  /** happyhorse-edit-video model slug. */
  public static final EditVideoModel HAPPYHORSE_EDIT_VIDEO = new EditVideoModel("happyhorse-edit-video");

  /** Creates a model value from a literal model slug. */
  @JsonCreator
  public EditVideoModel(String value) {
    super(value);
  }
}

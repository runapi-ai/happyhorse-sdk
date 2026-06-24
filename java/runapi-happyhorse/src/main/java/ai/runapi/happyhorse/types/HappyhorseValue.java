package ai.runapi.happyhorse.types;

import ai.runapi.core.types.RunApiValue;

abstract class HappyhorseValue extends RunApiValue {
  HappyhorseValue(String value) {
    super(value);
  }
}

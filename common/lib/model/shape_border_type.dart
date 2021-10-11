/*
 * Copyright 2020 Cagatay Ulusoy (Ulus Oy Apps). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/cupertino.dart';

const String BEVELED_SHAPE = "beveled";
const String CIRCLE_SHAPE = "circle";
const String CONTINUOUS_SHAPE = "continuous";
const String ROUNDED_SHAPE = "rounded";
const String STADIUM_SHAPE = "stadium";

enum ShapeBorderType { BEVELED, CONTINUOUS, ROUNDED, STADIUM, CIRCLE }

extension ShapeBorderTypeExtensions on ShapeBorderType {
  String stringRepresentation() {
    switch (this) {
      case ShapeBorderType.CONTINUOUS:
        return CONTINUOUS_SHAPE;
      case ShapeBorderType.BEVELED:
        return BEVELED_SHAPE;
      case ShapeBorderType.ROUNDED:
        return ROUNDED_SHAPE;
      case ShapeBorderType.STADIUM:
        return STADIUM_SHAPE;
      case ShapeBorderType.CIRCLE:
        return CIRCLE_SHAPE;
    }
  }

  ShapeBorder getShapeBorder() {
    switch (this) {
      case ShapeBorderType.CONTINUOUS:
        return ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_SPACING_LARGE));
      case ShapeBorderType.BEVELED:
        return BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppDimens.SIZE_SPACING_LARGE)));
      case ShapeBorderType.ROUNDED:
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppDimens.SIZE_SPACING_LARGE)));
      case ShapeBorderType.STADIUM:
        return StadiumBorder();
      case ShapeBorderType.CIRCLE:
        return CircleBorder();
    }
  }
}

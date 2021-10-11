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
import 'package:flutter/material.dart';
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';

import 'company_shapes.dart';

class CodelandShapes extends CompanyShapes {
  CodelandShapes(CompanyColors colors) : super(colors);

  @override
  ShapeBorder get buttonShapeBorder =>
      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0));

  @override
  ShapeBorder get cardShapeBorder =>
      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0));

  @override
  ShapeBorder get chipShapeBorder =>
      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0));

  @override
  ShapeBorder get legendBoxShapeBorder =>
      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0));

  @override
  ShapeBorder get toggleButtonShapeBorder => ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: primaryColor));

  @override
  ShapeBorder get fabShapeBorder =>
      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12.0));

  @override
  ShapeBorder get barGraphShapeBorder => ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ));

  @override
  NotchedShape get bottomAppBarShape => AutomaticNotchedShape(
        ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      );
}

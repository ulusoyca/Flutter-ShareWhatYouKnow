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

class BiohackShapes extends CompanyShapes {
  BiohackShapes(CompanyColors colors) : super(colors);

  @override
  ShapeBorder get buttonShapeBorder =>
      BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  ShapeBorder get cardShapeBorder =>
      BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)));

  @override
  ShapeBorder get chipShapeBorder =>
      BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)));

  @override
  ShapeBorder get legendBoxShapeBorder =>
      BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)));

  @override
  ShapeBorder get toggleButtonShapeBorder => BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)), side: BorderSide(color: primaryColor));

  @override
  ShapeBorder get fabShapeBorder =>
      BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28)));

  @override
  ShapeBorder get barGraphShapeBorder => BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ));

  @override
  NotchedShape get bottomAppBarShape => AutomaticNotchedShape(
        BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
      );
}

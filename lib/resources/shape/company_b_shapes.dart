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

import 'company_shapes.dart';

class CompanyShapesB extends CompanyShapes {
  ShapeBorder buttonShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
  ShapeBorder cardShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );
  ShapeBorder chipShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );
  ShapeBorder toggleButtonShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(28)),
  );
  ShapeBorder fabShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(28)),
  );
  ShapeBorder barGraphShapeBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );
}

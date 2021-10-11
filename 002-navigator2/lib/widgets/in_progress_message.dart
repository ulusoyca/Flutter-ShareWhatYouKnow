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
import 'package:flutter/material.dart';

class InProgressMessage extends StatelessWidget {
  final String screenName;
  final String progressName;

  const InProgressMessage({
    Key? key,
    required this.screenName,
    required this.progressName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: Text(
          '$progressName is in progress...\n\nStill in $screenName\n\n',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

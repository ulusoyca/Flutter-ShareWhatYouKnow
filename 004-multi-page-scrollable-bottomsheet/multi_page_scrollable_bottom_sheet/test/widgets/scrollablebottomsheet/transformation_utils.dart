import 'package:flutter_test/flutter_test.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/transformation_utils.dart';

void main() {
  group('TransformationUtils', () {
    test('progress at 0 gives the start value when start value is greater than end value', () {
      double progress0 = calculateTransformationValue(
        startValue: 1.1,
        endValue: 1.0,
        rangeInPx: 200,
        progressInRangeInPx: 0,
      );
      expect(progress0, 1.1);
    });

    test('progress at 0 gives the start value when start value is smaller than end value', () {
      double progress0 = calculateTransformationValue(
        startValue: 1.0,
        endValue: 1.1,
        rangeInPx: 200,
        progressInRangeInPx: 0,
      );
      expect(progress0, 1.0);
    });

    test('progress is correct when start value is greater than end value', () {
      double progress1 = calculateTransformationValue(
        startValue: 1.1,
        endValue: 1.0,
        rangeInPx: 200,
        progressInRangeInPx: 100,
      );
      expect(progress1, 1.05);
    });

    test('progress is correct when start value is smaller than end value', () {
      double progress1 = calculateTransformationValue(
        startValue: 1.0,
        endValue: 1.1,
        rangeInPx: 200,
        progressInRangeInPx: 200,
      );
      expect(progress1, 1.1);
    });
  });
}

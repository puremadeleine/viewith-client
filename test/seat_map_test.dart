import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:viewith/feature/seatmap/presentation/widget/painter/path_painter.dart';
import 'package:viewith/feature/seatmap/presentation/widget/seat_map.dart';

@GenerateMocks([AssetBundle])
import 'seat_map_test.mocks.dart';
import 'test_svg_data.dart';

abstract class SectionCallback {
  void call(String id);
}

class MockSectionCallback extends Mock implements SectionCallback {}

void main() {
  late MockAssetBundle mockAssetBundle;
  late MockSectionCallback mockCallback;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    mockCallback = MockSectionCallback();
  });

  testWidgets('SeatMap widget renders correctly', (WidgetTester tester) async {
    when(mockAssetBundle.loadString('assets/seat_map.svg'))
        .thenAnswer((_) async => testSvgData);

    await tester.pumpWidget(
      MaterialApp(
        home: DefaultAssetBundle(
          bundle: mockAssetBundle,
          child: SeatMap(
            seatmapSource: 'assets/seat_map.svg',
            onSectionSelected: mockCallback.call,
            mode: const SeatMapWritable(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SeatMap), findsOneWidget);
    expect(find.byKey(const ValueKey('seatMapCustomPaint')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('seatMapGestureDetector')));
    await tester.pumpAndSettle();

    verify(mockCallback.call('SEAT_8')).called(1);
  });

  testWidgets('SeatMap changes background color on tap',
      (WidgetTester tester) async {
    when(mockAssetBundle.loadString('assets/seat_map.svg'))
        .thenAnswer((_) async => testSvgData);

    await tester.pumpWidget(
      MaterialApp(
        home: DefaultAssetBundle(
          bundle: mockAssetBundle,
          child: SeatMap(
            key: const ValueKey('seatMap'),
            seatmapSource: 'assets/seat_map.svg',
            onSectionSelected: mockCallback.call,
            mode: const SeatMapWritable(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final initialPaint = tester
        .widget<CustomPaint>(find.byKey(const ValueKey('seatMapCustomPaint')));
    final initialPainter = initialPaint.painter as PathPainter;

    expect(initialPainter.colors, isNotNull);
    expect(initialPainter.colors['SEAT_8'], isNotNull);

    final initialColor = initialPainter.colors['SEAT_8'];

    await tester.tap(find.byKey(const ValueKey('seatMapGestureDetector')));
    await tester.pumpAndSettle();

    final updatedPaint = tester
        .widget<CustomPaint>(find.byKey(const ValueKey('seatMapCustomPaint')));
    final updatedPainter = updatedPaint.painter as PathPainter;

    expect(updatedPainter.colors, isNotNull);
    expect(updatedPainter.colors['SEAT_8'], isNotNull);

    final updatedColor = updatedPainter.colors['SEAT_8'];
    expect(initialColor, isNot(equals(updatedColor)));
    expect(updatedColor, equals(Colors.black));
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:endstream/main.dart';

void main() {
  testWidgets('App renders splash screen', (tester) async {
    await tester.pumpWidget(const EndStreamApp());
    await tester.pumpAndSettle();

    expect(find.text('ENDSTREAM'), findsOneWidget);
  });
}

import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrimaryButton Widget Tests', () {
    testWidgets('Renders correct text and no icon by default', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(text: 'Submit', onPressed: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('Submit'), findsOneWidget);
      expect(
        find.byType(Icon),
        findsNothing,
      ); // Ensures no icon is rendered if not passed
    });

    testWidgets('Triggers onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool buttonWasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Click Me',
              onPressed: () {
                buttonWasTapped = true;
              },
            ),
          ),
        ),
      );

      // Act - Simulate a user tapping the button
      await tester.tap(find.byType(PrimaryButton));
      await tester.pump(); // Rebuild the widget after state change

      // Assert
      expect(buttonWasTapped, isTrue);
    });

    testWidgets('Renders icon when provided', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Next',
              icon: Icons.arrow_forward,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Next'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}

import 'package:ai_emotion_app/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Utils.goBack successfully pops the navigator if canPop is true',
    (WidgetTester tester) async {
      // Arrange: Build an app with two screens to test the navigation
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    // Push a second screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: Builder(
                            builder: (innerContext) {
                              return ElevatedButton(
                                onPressed: () {
                                  // ACT: Call your Utils function
                                  Utils.goBack(innerContext);
                                },
                                child: const Text('Go Back Button'),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Screen 1 Push'),
                );
              },
            ),
          ),
        ),
      );

      // Act: Tap button to navigate to Screen 2
      await tester.tap(find.text('Screen 1 Push'));
      await tester.pumpAndSettle(); // Wait for the animation to finish

      // Assert: Verify we are on Screen 2
      expect(find.text('Go Back Button'), findsOneWidget);

      // Act: Tap the button that triggers Utils.goBack()
      await tester.tap(find.text('Go Back Button'));
      await tester.pumpAndSettle(); // Wait for the pop animation to finish

      // Assert: Verify we are back on Screen 1
      expect(find.text('Screen 1 Push'), findsOneWidget);
      expect(find.text('Go Back Button'), findsNothing);
    },
  );
}

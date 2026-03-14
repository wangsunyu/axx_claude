import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:axx_flutter_multiplatform/models/ad_response.dart';
import 'package:axx_flutter_multiplatform/pages/ad_splash_page.dart';
import 'package:axx_flutter_multiplatform/services/ad_service.dart';

/// Mock AdService，返回空广告（不发起真实网络请求）
class MockAdService extends AdService {
  final AdResponse? mockResponse;

  MockAdService({this.mockResponse});

  @override
  Future<AdResponse?> getSplashAd() async {
    return mockResponse;
  }
}

void main() {
  group('AdSplashPage UI', () {
    testWidgets('应该显示跳过按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home')),
          },
          home: AdSplashPage(adService: MockAdService()),
        ),
      );

      await tester.pump();
      expect(find.textContaining('跳过'), findsOneWidget);

      // 清理 Timer
      await tester.pumpAndSettle(const Duration(seconds: 6));
    });

    testWidgets('跳过按钮应该显示初始倒计时 5', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home')),
          },
          home: AdSplashPage(adService: MockAdService()),
        ),
      );

      await tester.pump();
      expect(find.text('跳过 5'), findsOneWidget);

      // 清理 Timer
      await tester.pumpAndSettle(const Duration(seconds: 6));
    });

    testWidgets('点击跳过按钮应该跳转到主页', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home')),
          },
          home: AdSplashPage(adService: MockAdService()),
        ),
      );

      await tester.pump();

      // 点击跳过按钮
      await tester.tap(find.textContaining('跳过'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });
  });
}

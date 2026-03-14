import 'package:flutter_test/flutter_test.dart';
import 'package:axx_flutter_multiplatform/models/ad_response.dart';

void main() {
  group('AdResponse', () {
    test('fromJson 应该正确解析成功响应', () {
      final json = {
        'code': 0,
        'message': 'success',
        'data': {
          'imageUrl': 'https://example.com/ad.jpg',
        },
      };

      final response = AdResponse.fromJson(json);

      expect(response.code, equals(0));
      expect(response.message, equals('success'));
      expect(response.data, isNotNull);
      expect(response.data!.imageUrl, equals('https://example.com/ad.jpg'));
      expect(response.isSuccess, isTrue);
    });

    test('fromJson 应该处理失败响应', () {
      final json = {
        'code': -1,
        'message': 'error',
      };

      final response = AdResponse.fromJson(json);

      expect(response.code, equals(-1));
      expect(response.message, equals('error'));
      expect(response.data, isNull);
      expect(response.isSuccess, isFalse);
    });

    test('toJson 应该正确序列化', () {
      final response = AdResponse(
        code: 0,
        message: 'success',
        data: AdData(imageUrl: 'https://example.com/ad.jpg'),
      );

      final json = response.toJson();

      expect(json['code'], equals(0));
      expect(json['message'], equals('success'));
      expect(json['data'], isNotNull);
      expect(json['data']['imageUrl'], equals('https://example.com/ad.jpg'));
    });
  });

  group('AdData', () {
    test('fromJson 应该正确解析', () {
      final json = {'imageUrl': 'https://example.com/ad.jpg'};
      final data = AdData.fromJson(json);

      expect(data.imageUrl, equals('https://example.com/ad.jpg'));
    });

    test('fromJson 应该处理空 imageUrl', () {
      final json = <String, dynamic>{};
      final data = AdData.fromJson(json);

      expect(data.imageUrl, equals(''));
    });

    test('toJson 应该正确序列化', () {
      final data = AdData(imageUrl: 'https://example.com/ad.jpg');
      final json = data.toJson();

      expect(json['imageUrl'], equals('https://example.com/ad.jpg'));
    });
  });
}

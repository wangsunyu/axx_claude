/// 广告接口响应模型
class AdResponse {
  final int code;
  final String? message;
  final AdData? data;

  AdResponse({
    required this.code,
    this.message,
    this.data,
  });

  factory AdResponse.fromJson(Map<String, dynamic> json) {
    return AdResponse(
      code: json['code'] as int? ?? -1,
      message: json['message'] as String?,
      data: json['data'] != null ? AdData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }

  bool get isSuccess => code == 0;
}

/// 广告数据
class AdData {
  final String imageUrl;

  AdData({required this.imageUrl});

  factory AdData.fromJson(Map<String, dynamic> json) {
    return AdData(
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
    };
  }
}

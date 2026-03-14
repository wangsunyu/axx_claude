import 'dart:async';
import 'package:flutter/material.dart';
import '../services/ad_service.dart';

/// 广告启动页
/// 全屏展示广告图片，5秒倒计时后自动跳转主页
class AdSplashPage extends StatefulWidget {
  final AdService? adService; // 支持依赖注入，方便测试

  const AdSplashPage({super.key, this.adService});

  @override
  State<AdSplashPage> createState() => _AdSplashPageState();
}

class _AdSplashPageState extends State<AdSplashPage> {
  late final AdService _adService;
  String? _imageUrl;
  int _countdown = 5;
  Timer? _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _adService = widget.adService ?? AdService();
    _loadAd();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 加载广告
  Future<void> _loadAd() async {
    try {
      final response = await _adService.getSplashAd();
      if (mounted && response != null && response.isSuccess) {
        setState(() {
          _imageUrl = response.data?.imageUrl;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // 加载广告失败，静默处理
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 开始倒计时
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        _navigateToHome();
      }
    });
  }

  /// 跳转到主页
  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  /// 跳过按钮点击
  void _onSkipTap() {
    _timer?.cancel();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 广告图片（全屏）
          _buildAdImage(),

          // 右上角跳过按钮
          _buildSkipButton(),
        ],
      ),
    );
  }

  /// 构建广告图片
  Widget _buildAdImage() {
    if (_isLoading) {
      // 加载中显示纯色背景
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_imageUrl == null || _imageUrl!.isEmpty) {
      // 没有广告图片，显示纯色背景
      return Container(
        color: Colors.white,
      );
    }

    // 显示广告图片
    return Image.network(
      _imageUrl!,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // 图片加载失败，显示纯色背景
        return Container(
          color: Colors.white,
        );
      },
    );
  }

  /// 构建跳过按钮
  Widget _buildSkipButton() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 16),
            child: GestureDetector(
              onTap: _onSkipTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '跳过 $_countdown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

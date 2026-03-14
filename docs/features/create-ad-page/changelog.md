# 功能变更：广告启动页

**日期**: 2026-03-13
**版本**: 1.0.0

## 功能描述

在应用启动后展示全屏广告页面，支持 5 秒倒计时自动跳转或点击跳过按钮直接进入主页。广告图片通过 POST 接口动态加载，支持测试和生产环境切换。

## 新增文件

### 配置层
- `lib/config/env_config.dart` - 环境配置（测试/生产）
- `lib/config/api_config.dart` - API 基础地址管理

### 数据层
- `lib/models/ad_response.dart` - 广告接口响应模型

### 服务层
- `lib/services/http_service.dart` - HTTP 请求基础封装
- `lib/services/ad_service.dart` - 广告接口服务

### UI 层
- `lib/pages/ad_splash_page.dart` - 广告启动页

### 测试
- `test/unit/env_config_test.dart` - 环境配置测试
- `test/unit/api_config_test.dart` - API 配置测试
- `test/unit/ad_response_test.dart` - 数据模型测试
- `test/widget/ad_splash_page_test.dart` - 广告页 UI 测试

## 修改文件

- `lib/main.dart` - 添加路由配置，初始路由改为 `/ad`
- `pubspec.yaml` - 添加 `dio: ^5.4.0` 依赖

## 使用方式

### 环境切换

```bash
# 测试环境（默认）
flutter run --dart-define=ENV=dev

# 生产环境
flutter run --dart-define=ENV=prod
```

### 配置 API 地址

在 `lib/config/api_config.dart` 中修改对应环境的地址：

```dart
static String get adBaseUrl => EnvConfig.isDev
    ? 'https://dev-ad-api.example.com'  // 测试环境地址
    : 'https://ad-api.example.com';     // 生产环境地址
```

### 广告接口

**请求**:
```
POST /api/ad/splash
Content-Type: application/json

{}
```

**响应**:
```json
{
  "code": 0,
  "message": "success",
  "data": {
    "imageUrl": "https://example.com/ad.jpg"
  }
}
```

### 启动流程

```
应用启动 → 广告页（/ad）→ 主页（/home）
         ↓
    5秒倒计时或点击跳过
```

## 功能特性

- ✅ 全屏广告图片展示（BoxFit.cover）
- ✅ 右上角跳过按钮（显示倒计时秒数）
- ✅ 5 秒自动跳转主页
- ✅ 点击跳过按钮立即跳转
- ✅ 广告加载失败时静默降级（显示白色背景）
- ✅ 支持测试/生产环境切换
- ✅ 完整的单元测试和 Widget 测试

## 依赖变更

新增依赖：
- `dio: ^5.4.0` - HTTP 客户端

## 测试覆盖

- 环境配置测试（3 个测试用例）
- API 配置测试（4 个测试用例）
- 数据模型测试（7 个测试用例）
- 广告页 UI 测试（3 个测试用例）

运行测试：
```bash
flutter test
```

## 注意事项

1. **生产环境构建**必须传入 `--dart-define=ENV=prod`
2. 广告接口地址需要替换为实际地址
3. 广告加载失败不会阻塞用户，倒计时照常运行
4. 图片建议尺寸：1080x1920（9:16）或 1242x2208（iPhone 尺寸）

## 后续扩展

- 支持从接口获取倒计时秒数
- 支持广告点击跳转外部链接
- 添加广告曝光埋点
- 支持多张广告轮播

# AI Context: create-ad-page

## 实现的文件

| 文件 | 职责 |
|------|------|
| `lib/config/env_config.dart` | 编译时环境变量读取，区分 dev/prod |
| `lib/config/api_config.dart` | 所有服务基础地址集中管理 |
| `lib/services/http_service.dart` | Dio 封装，createDio/post/get 静态方法 |
| `lib/models/ad_response.dart` | 广告接口响应模型，AdResponse + AdData |
| `lib/services/ad_service.dart` | 广告 POST 接口，错误静默处理 |
| `lib/pages/ad_splash_page.dart` | 广告启动页 UI，倒计时，跳过按钮 |
| `lib/main.dart` | 路由配置，初始路由为 /ad |

## 关键设计决策

### 环境切换
- 使用 `--dart-define=ENV=prod` 编译时注入，不是运行时判断
- 默认值是 `dev`，发布生产包必须显式传入 prod
- `EnvConfig` 是纯静态类，不需要实例化

### 网络层
- `HttpService` 是工厂类，`createDio(baseUrl)` 返回配置好的 Dio 实例
- 每个服务（AdService、未来的 UserService 等）各自持有自己的 Dio 实例
- 超时统一 10 秒（connectTimeout + receiveTimeout）

### 广告页布局 Bug（已修复）
- **坑**: `SafeArea` 包裹 `Positioned` 会报错，因为 SafeArea 内部是 Padding，不是 Stack
- **正确做法**: `Positioned` 在外，`SafeArea` 在内，再用 `Align` 定位

```dart
// 错误写法
SafeArea(
  child: Positioned(...), // ❌ Positioned 必须是 Stack 的直接子组件
)

// 正确写法
Positioned(
  top: 0, right: 0, left: 0,
  child: SafeArea(
    child: Align(alignment: Alignment.topRight, ...),
  ),
)
```

### 依赖注入（测试需要）
- `AdSplashPage` 接受可选的 `adService` 参数
- 生产环境不传，默认 `new AdService()`
- 测试时传入 `MockAdService`，避免真实网络请求

```dart
class AdSplashPage extends StatefulWidget {
  final AdService? adService; // 可选注入
  const AdSplashPage({super.key, this.adService});
}
```

### 错误降级
- 广告接口失败 → 静默处理，`_imageUrl` 保持 null
- `_imageUrl` 为 null → 显示白色背景
- 倒计时照常运行，5 秒后正常跳转主页
- 用户体验不受网络异常影响

## 测试结构

```
test/
├── unit/
│   ├── env_config_test.dart     # 环境配置单元测试
│   ├── api_config_test.dart     # API 配置单元测试
│   └── ad_response_test.dart    # 数据模型单元测试
└── widget/
    └── ad_splash_page_test.dart # 广告页 Widget 测试（使用 MockAdService）
```

## 扩展注意事项

- 新增服务时，在 `api_config.dart` 添加对应的 `baseUrl` 和路径常量
- 新增页面时，在 `main.dart` 的 `routes` 中注册路由
- Widget 测试中凡是有网络请求的页面，都需要通过依赖注入传入 Mock 服务
- 倒计时秒数目前硬编码为 5，如需从接口获取，在 `AdResponse` 中添加 `duration` 字段

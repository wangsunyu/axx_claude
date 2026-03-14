#!/bin/bash

# Flutter多平台构建脚本
# 用法: ./build.sh [platform] [mode]
# platform: ios, android, all
# mode: debug, release (默认: release)

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 默认参数
PLATFORM=${1:-all}
MODE=${2:-release}

echo -e "${GREEN}Flutter多平台构建脚本${NC}"
echo "平台: $PLATFORM"
echo "模式: $MODE"
echo ""

# 检查Flutter环境
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}错误: Flutter未安装或不在PATH中${NC}"
    echo "请先安装Flutter: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# 清理构建缓存
clean_build() {
    echo -e "${YELLOW}清理构建缓存...${NC}"
    flutter clean
    flutter pub get
    echo -e "${GREEN}✓ 清理完成${NC}"
    echo ""
}

# iOS构建
build_ios() {
    echo -e "${YELLOW}开始构建iOS应用...${NC}"

    if [ "$MODE" == "release" ]; then
        flutter build ios --release
    else
        flutter build ios --debug
    fi

    echo -e "${GREEN}✓ iOS构建完成${NC}"
    echo "构建产物位置: build/ios/"
    echo ""
}

# Android APK构建
build_android_apk() {
    echo -e "${YELLOW}开始构建Android APK...${NC}"

    if [ "$MODE" == "release" ]; then
        flutter build apk --release
    else
        flutter build apk --debug
    fi

    echo -e "${GREEN}✓ Android APK构建完成${NC}"
    echo "构建产物位置: build/app/outputs/flutter-apk/"
    echo ""
}

# Android App Bundle构建
build_android_bundle() {
    echo -e "${YELLOW}开始构建Android App Bundle...${NC}"

    if [ "$MODE" == "release" ]; then
        flutter build appbundle --release
    else
        flutter build appbundle --debug
    fi

    echo -e "${GREEN}✓ Android App Bundle构建完成${NC}"
    echo "构建产物位置: build/app/outputs/bundle/"
    echo ""
}

# 鸿蒙构建（占位）
build_harmonyos() {
    echo -e "${YELLOW}鸿蒙平台构建...${NC}"
    echo -e "${YELLOW}注意: 鸿蒙平台需要在DevEco Studio中构建${NC}"
    echo "1. 在DevEco Studio中打开 ohos/ 目录"
    echo "2. 选择 Build > Build Hap(s)/APP(s)"
    echo "3. 构建产物位于: ohos/entry/build/outputs/"
    echo ""
}

# 主构建流程
main() {
    # 清理
    clean_build

    case $PLATFORM in
        ios)
            build_ios
            ;;
        android)
            build_android_apk
            build_android_bundle
            ;;
        harmonyos|ohos)
            build_harmonyos
            ;;
        all)
            build_ios
            build_android_apk
            build_android_bundle
            build_harmonyos
            ;;
        *)
            echo -e "${RED}错误: 未知平台 '$PLATFORM'${NC}"
            echo "支持的平台: ios, android, harmonyos, all"
            exit 1
            ;;
    esac

    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}构建完成！${NC}"
    echo -e "${GREEN}========================================${NC}"
}

# 显示帮助
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "用法: ./build.sh [platform] [mode]"
    echo ""
    echo "参数:"
    echo "  platform  目标平台 (ios, android, harmonyos, all)"
    echo "  mode      构建模式 (debug, release)"
    echo ""
    echo "示例:"
    echo "  ./build.sh ios release       # 构建iOS发布版"
    echo "  ./build.sh android debug     # 构建Android调试版"
    echo "  ./build.sh all release       # 构建所有平台发布版"
    echo ""
    exit 0
fi

# 执行构建
main

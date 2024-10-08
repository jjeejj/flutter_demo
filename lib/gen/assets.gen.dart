/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $ImagesGen {
  const $ImagesGen();

  /// File path: images/big.png
  AssetGenImage get big => const AssetGenImage('images/big.png');

  /// File path: images/daily_task_icon.png
  AssetGenImage get dailyTaskIcon =>
      const AssetGenImage('images/daily_task_icon.png');

  /// File path: images/launcher_icon.png
  AssetGenImage get launcherIcon =>
      const AssetGenImage('images/launcher_icon.png');

  /// File path: images/login_bg.png
  AssetGenImage get loginBg => const AssetGenImage('images/login_bg.png');

  /// File path: images/small.png
  AssetGenImage get small => const AssetGenImage('images/small.png');

  /// File path: images/top_one.png
  AssetGenImage get topOne => const AssetGenImage('images/top_one.png');

  /// File path: images/top_three.png
  AssetGenImage get topThree => const AssetGenImage('images/top_three.png');

  /// File path: images/top_two.png
  AssetGenImage get topTwo => const AssetGenImage('images/top_two.png');

  /// File path: images/user_rank_bg.png
  AssetGenImage get userRankBg =>
      const AssetGenImage('images/user_rank_bg.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        big,
        dailyTaskIcon,
        launcherIcon,
        loginBg,
        small,
        topOne,
        topThree,
        topTwo,
        userRankBg
      ];
}

class Assets {
  Assets._();

  static const $ImagesGen images = $ImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

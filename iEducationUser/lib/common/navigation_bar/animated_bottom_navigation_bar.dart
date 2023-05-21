library animated_bottom_navigation_bar;

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user/common/navigation_bar/navigation/around_custom_painter.dart';
import 'package:user/common/navigation_bar/navigation/circular_notch_and_corner_clipper.dart';
import 'package:user/common/navigation_bar/navigation/circular_notched_and_cornered_shape.dart';
import 'package:user/common/navigation_bar/navigation/exceptions.dart';
import 'package:user/common/navigation_bar/navigation/gap_item.dart';
import 'package:user/common/navigation_bar/navigation/navigation_bar_item.dart';
import 'package:user/common/navigation_bar/navigation/safe_area_values.dart';
import 'package:user/common/navigation_bar/navigation/visible_animator.dart';

typedef IndexedWidgetBuilder = Widget Function(int index, bool isActive);

class AnimatedBottomNavigationBar extends StatefulWidget {
  final IndexedWidgetBuilder? tabBuilder;

  final int? itemCount;
  final List<IconData>? icons;
  final Function(int) onTap;
  final int activeIndex;
  final double? iconSize;
  final double? height;
  final double? notchMargin;

  final double splashRadius;

  final int? splashSpeedInMilliseconds;

  final double? leftCornerRadius;

  final double? rightCornerRadius;

  final Color? backgroundColor;

  final Color? splashColor;

  final Color? activeColor;

  final Color? inactiveColor;

  final Animation<double>? notchAndCornersAnimation;

  final NotchSmoothness? notchSmoothness;

  final GapLocation? gapLocation;

  final double? gapWidth;

  final double? elevation;

  final Shadow? shadow;

  final SafeAreaValues safeAreaValues;
  final Curve? hideAnimationCurve;

  final Color? borderColor;

  final double? borderWidth;

  final AnimationController? hideAnimationController;
  final Gradient? backgroundGradient;
  final bool blurEffect;

  static const _defaultSplashRadius = 24.0;

  AnimatedBottomNavigationBar._internal({
    Key? key,
    required this.activeIndex,
    required this.onTap,
    this.tabBuilder,
    this.itemCount,
    this.icons,
    this.height,
    this.splashRadius = _defaultSplashRadius,
    this.splashSpeedInMilliseconds,
    this.notchMargin,
    this.backgroundColor,
    this.splashColor,
    this.activeColor,
    this.inactiveColor,
    this.notchAndCornersAnimation,
    this.leftCornerRadius,
    this.rightCornerRadius,
    this.iconSize,
    this.notchSmoothness,
    this.gapLocation,
    this.gapWidth,
    this.elevation,
    this.shadow,
    this.borderColor,
    this.borderWidth,
    this.safeAreaValues = const SafeAreaValues(),
    this.hideAnimationCurve,
    this.hideAnimationController,
    this.backgroundGradient,
    this.blurEffect = false,
  })  : assert(icons != null || itemCount != null),
        assert(
          ((itemCount ?? icons!.length) >= 2) &&
              ((itemCount ?? icons!.length) <= 5),
        ),
        super(key: key) {
    if (gapLocation == GapLocation.end) {
      if (rightCornerRadius != 0) {
        throw NonAppropriatePathException(
            'RightCornerRadius along with ${GapLocation.end} or/and ${FloatingActionButtonLocation.endDocked} causes render issue => '
            'consider set rightCornerRadius to 0.');
      }
    }
    if (gapLocation == GapLocation.center) {
      final iconsCountIsOdd = (itemCount ?? icons!.length).isOdd;
      if (iconsCountIsOdd) {
        throw NonAppropriatePathException(
            'Odd count of icons along with $gapLocation causes render issue => '
            'consider set gapLocation to ${GapLocation.end}');
      }
    }
  }

  AnimatedBottomNavigationBar({
    Key? key,
    required List<IconData> icons,
    required int activeIndex,
    required Function(int) onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    Color? activeColor,
    Color? inactiveColor,
    Animation<double>? notchAndCornersAnimation,
    double? leftCornerRadius,
    double? rightCornerRadius,
    double? iconSize,
    NotchSmoothness? notchSmoothness,
    GapLocation? gapLocation,
    double? gapWidth,
    double? elevation,
    Shadow? shadow,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
    bool blurEffect = false,
  }) : this._internal(
          key: key,
          icons: icons,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          splashRadius: splashRadius ?? _defaultSplashRadius,
          splashSpeedInMilliseconds: splashSpeedInMilliseconds,
          notchMargin: notchMargin,
          backgroundColor: backgroundColor,
          splashColor: splashColor,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          notchAndCornersAnimation: notchAndCornersAnimation,
          leftCornerRadius: leftCornerRadius ?? 0,
          rightCornerRadius: rightCornerRadius ?? 0,
          iconSize: iconSize,
          notchSmoothness: notchSmoothness,
          gapLocation: gapLocation ?? GapLocation.end,
          gapWidth: gapWidth,
          elevation: elevation,
          shadow: shadow,
          borderColor: borderColor,
          borderWidth: borderWidth,
          safeAreaValues: safeAreaValues,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
          backgroundGradient: backgroundGradient,
          blurEffect: blurEffect,
        );

  AnimatedBottomNavigationBar.builder({
    Key? key,
    required int itemCount,
    required IndexedWidgetBuilder tabBuilder,
    required int activeIndex,
    required Function(int) onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    Animation<double>? notchAndCornersAnimation,
    double? leftCornerRadius,
    double? rightCornerRadius,
    NotchSmoothness? notchSmoothness,
    GapLocation? gapLocation,
    double? gapWidth,
    double? elevation,
    Shadow? shadow,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
    bool blurEffect = false,
  }) : this._internal(
          key: key,
          tabBuilder: tabBuilder,
          itemCount: itemCount,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          splashRadius: splashRadius ?? _defaultSplashRadius,
          splashSpeedInMilliseconds: splashSpeedInMilliseconds,
          notchMargin: notchMargin,
          backgroundColor: backgroundColor,
          splashColor: splashColor,
          notchAndCornersAnimation: notchAndCornersAnimation,
          leftCornerRadius: leftCornerRadius ?? 0,
          rightCornerRadius: rightCornerRadius ?? 0,
          notchSmoothness: notchSmoothness,
          gapLocation: gapLocation ?? GapLocation.end,
          gapWidth: gapWidth,
          elevation: elevation,
          shadow: shadow,
          borderColor: borderColor,
          borderWidth: borderWidth,
          safeAreaValues: safeAreaValues,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
          backgroundGradient: backgroundGradient,
          blurEffect: blurEffect,
        );

  @override
  AnimatedBottomNavigationBarState createState() =>
      AnimatedBottomNavigationBarState();
}

class AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  late AnimationController _bubbleController;

  double _bubbleRadius = 0;
  double _iconScale = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);

    widget.notchAndCornersAnimation?.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeIndex != oldWidget.activeIndex) {
      _startBubbleAnimation();
    }
  }

  _startBubbleAnimation() {
    _bubbleController = AnimationController(
      duration: Duration(milliseconds: widget.splashSpeedInMilliseconds ?? 300),
      vsync: this,
    );

    final bubbleCurve = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.linear,
    );

    Tween<double>(begin: 0, end: 1).animate(bubbleCurve).addListener(() {
      setState(() {
        _bubbleRadius = widget.splashRadius * bubbleCurve.value;
        if (_bubbleRadius == widget.splashRadius) {
          _bubbleRadius = 0;
        }

        if (bubbleCurve.value < 0.5) {
          _iconScale = 1 + bubbleCurve.value;
        } else {
          _iconScale = 2 - bubbleCurve.value;
        }
      });
    });

    if (_bubbleController.isAnimating) {
      _bubbleController.reset();
    }
    _bubbleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = CircularNotchedAndCorneredRectangleClipper(
      shape: CircularNotchedAndCorneredRectangle(
        animation: widget.notchAndCornersAnimation,
        notchSmoothness: widget.notchSmoothness ?? NotchSmoothness.defaultEdge,
        gapLocation: widget.gapLocation ?? GapLocation.end,
        leftCornerRadius: widget.leftCornerRadius ?? 0.0,
        rightCornerRadius: widget.rightCornerRadius ?? 0.0,
      ),
      geometry: geometryListenable,
      notchMargin: widget.notchMargin ?? 8,
    );

    return PhysicalShape(
      elevation: widget.elevation ?? 8,
      color: Colors.transparent,
      clipper: clipper,
      child: AroundCustomPainter(
        clipper: clipper,
        shadow: widget.shadow,
        borderColor: widget.borderColor ?? Colors.transparent,
        borderWidth: widget.borderWidth ?? 2,
        child: widget.hideAnimationController != null
            ? VisibleAnimator(
                showController: widget.hideAnimationController!,
                curve: widget.hideAnimationCurve ?? Curves.fastOutSlowIn,
                child: _buildBottomBar(),
              )
            : _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: widget.backgroundColor ?? Colors.white,
      child: SafeArea(
        left: widget.safeAreaValues.left,
        top: widget.safeAreaValues.top,
        right: widget.safeAreaValues.right,
        bottom: widget.safeAreaValues.bottom,
        child: widget.blurEffect
            ? ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                  child: _buildBody(),
                ),
              )
            : _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: widget.height ?? kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        gradient: widget.backgroundGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final gapWidth = widget.gapWidth ?? 72;
    final gapItemWidth = widget.notchAndCornersAnimation != null
        ? gapWidth * widget.notchAndCornersAnimation!.value
        : gapWidth;
    final itemCount = widget.itemCount ?? widget.icons!.length;

    final items = <Widget>[];
    for (var i = 0; i < itemCount; i++) {
      final isActive = i == widget.activeIndex;

      if (widget.gapLocation == GapLocation.center && i == itemCount / 2) {
        items.add(GapItem(width: gapItemWidth));
      }

      items.add(
        NavigationBarItem(
          isActive: isActive,
          bubbleRadius: _bubbleRadius,
          maxBubbleRadius: widget.splashRadius,
          bubbleColor: widget.splashColor,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          iconData: widget.icons?.elementAt(i),
          iconScale: _iconScale,
          iconSize: widget.iconSize,
          onTap: () => widget.onTap(i),
          child: widget.tabBuilder?.call(i, isActive),
        ),
      );

      if (widget.gapLocation == GapLocation.end && i == itemCount - 1) {
        items.add(GapItem(width: gapItemWidth));
      }
    }
    return items;
  }
}

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}

enum GapLocation { none, center, end }

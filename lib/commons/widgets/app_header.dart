import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/widgets/greetings_widget.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';

class AppHeader extends StatefulWidget {
  final String? title;
  final bool hasOptions;
  final VoidCallback? onPressed;

  const AppHeader({
    Key? key,
    this.title,
    this.hasOptions = false,
    this.onPressed,
  }) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  Widget get _child => widget.title != null
      ? Text(
          textAlign: TextAlign.center,
          widget.title!,
          style: AppTextStyles.mediumText18.apply(
            color: AppColors.white,
          ),
        )
      : const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GreetingsWidget(),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.blueGradient,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(500, 30),
                bottomRight: Radius.elliptical(500, 30),
              ),
            ),
            height: 287.h,
          ),
        ),
        Positioned(
          left: 24.0.w,
          right: 24.0.w,
          top: 74.h,
          child: _child,
        ),
        if (widget.title != null)
          Positioned(
            left: 8.0.w,
            top: 56.h,
            child: GestureDetector(
              onTap: widget.onPressed ?? () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        if (widget.hasOptions)
          Positioned(
            right: 8.0.w,
            top: 56.0.h,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.more_horiz,
                color: AppColors.white,
              ),
            ),
          ),
      ],
    );
  }
}

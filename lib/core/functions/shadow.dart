
  import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';


BoxShadow customshadow() {
    return BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: .1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          );
  }
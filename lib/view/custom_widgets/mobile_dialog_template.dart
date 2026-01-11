import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileDialogTemplate extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool showCloseButton;
  final double? maxWidth;

  const MobileDialogTemplate({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      insetPadding: EdgeInsets.all(
        isMobile ? DesignTokens.spacing16 : DesignTokens.spacing24,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? (isMobile ? double.infinity : 500),
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.borderLight,
                    width: DesignTokens.borderWidthThin,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (showCloseButton)
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                      color: AppColors.textSecondary,
                      iconSize: 24,
                      constraints: const BoxConstraints(
                        minWidth: DesignTokens.minTouchTarget,
                        minHeight: DesignTokens.minTouchTarget,
                      ),
                    ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DesignTokens.spacing20),
                child: content,
              ),
            ),

            // Actions
            if (actions != null && actions!.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.borderLight,
                      width: DesignTokens.borderWidthThin,
                    ),
                  ),
                ),
                child:
                    isMobile
                        ? Column(
                          children:
                              actions!
                                  .map(
                                    (action) => Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                        bottom: DesignTokens.spacing8,
                                      ),
                                      child: action,
                                    ),
                                  )
                                  .toList(),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              actions!
                                  .map(
                                    (action) => Container(
                                      margin: const EdgeInsets.only(
                                        left: DesignTokens.spacing8,
                                      ),
                                      child: action,
                                    ),
                                  )
                                  .toList(),
                        ),
              ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show mobile-optimized dialogs
Future<T?> showMobileDialog<T>({
  required String title,
  required Widget content,
  List<Widget>? actions,
  bool showCloseButton = true,
  double? maxWidth,
  bool barrierDismissible = true,
}) {
  return Get.dialog<T>(
    MobileDialogTemplate(
      title: title,
      content: content,
      actions: actions,
      showCloseButton: showCloseButton,
      maxWidth: maxWidth,
    ),
    barrierDismissible: barrierDismissible,
  );
}

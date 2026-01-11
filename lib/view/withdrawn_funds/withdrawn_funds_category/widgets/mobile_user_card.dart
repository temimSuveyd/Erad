import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileUserCard extends GetView<WithdrawnFundsCategoryControllerImp> {
  const MobileUserCard({super.key, required this.id, required this.userName});

  final String userName;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: DesignTokens.spacing8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(
          color: AppColors.border,
          width: DesignTokens.borderWidthThin,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textLight.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: DesignTokens.borderRadiusMedium,
          onTap: () => controller.goTOWithdrawnFundsPage(id),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: User Avatar and Name
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: DesignTokens.spacing4),
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: AppColors.textSecondary,
                                size: 16,
                              ),
                              const SizedBox(width: DesignTokens.spacing4),
                              Text(
                                'الأموال المسحوبة',
                                style: DesignTokens.getBodyMedium(
                                  context,
                                ).copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Divider
                Container(height: 1, color: AppColors.borderLight),

                const SizedBox(height: DesignTokens.spacing12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'تعديل الاسم',
                        Icons.edit_outlined,
                        AppColors.primary,
                        () => controller.showEditWithdrawnFundsCategoryDailog(
                          id,
                          userName,
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing8),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'حذف المستخدم',
                        Icons.person_remove_outlined,
                        AppColors.error,
                        () => controller
                            .showaDeleteWithdrawnFundsCategoryDailog(id),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing8),

                // View funds button
                SizedBox(
                  width: double.infinity,
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.goTOWithdrawnFundsPage(id),
                    icon: Icon(Icons.visibility_outlined, size: 18),
                    label: Text(
                      'عرض الأموال المسحوبة',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing8,
          vertical: DesignTokens.spacing6,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: DesignTokens.borderRadiusSmall,
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: DesignTokens.spacing4),
            Expanded(
              child: Text(
                title,
                style: DesignTokens.getBodySmall(
                  context,
                ).copyWith(color: color, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

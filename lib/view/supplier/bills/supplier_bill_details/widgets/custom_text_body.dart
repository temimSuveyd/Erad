import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_text_body extends StatelessWidget {
  const Custom_text_body({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
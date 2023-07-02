import 'dart:developer';

import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/extensions/sizes.dart';
import 'package:bolso_organizado/features/balance/balance.dart';
import 'package:flutter/material.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BalanceController controller;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor =
        MediaQuery.of(context).size.width <= 360 ? 0.8 : 1.0;

    return Positioned(
      left: 24.w,
      right: 24.w,
      top: 155.h,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        decoration: const BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyles.mediumText16w600
                          .apply(color: AppColors.white),
                    ),
                    AnimatedBuilder(
                        animation: controller,
                        builder: (context, _) {
                          if (controller.state is BalanceStateLoading) {
                            return Container(
                              color: AppColors.blueTwo,
                              constraints:
                                  BoxConstraints.tightFor(width: 128.0.w),
                              height: 48.0.h,
                            );
                          }
                          return ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 250.0.w),
                            child: Text(
                              'R\$${controller.balances.totalBalance.toStringAsFixed(2)}',
                              textScaleFactor: textScaleFactor,
                              style: AppTextStyles.mediumText30
                                  .apply(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        })
                  ],
                ),
              ],
            ),
            SizedBox(height: 36.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return TransactionValueWidget(
                      amount: controller.balances.totalIncome,
                      controller: controller,
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return TransactionValueWidget(
                      amount: controller.balances.totalOutcome,
                      controller: controller,
                      type: TransactionType.outcome,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum TransactionType { income, outcome }

class TransactionValueWidget extends StatelessWidget {
  const TransactionValueWidget({
    super.key,
    required this.amount,
    required this.controller,
    this.type = TransactionType.income,
  });
  final BalanceController controller;
  final double amount;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor =
        MediaQuery.of(context).size.width <= 360 ? 0.8 : 1.0;

    double iconSize = MediaQuery.of(context).size.width <= 360 ? 16.0 : 24.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.06),
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Icon(
            type == TransactionType.income
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: AppColors.white,
            size: iconSize,
          ),
        ),
        const SizedBox(width: 4.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type == TransactionType.income ? 'Renda' : 'Despesa',
              textScaleFactor: textScaleFactor,
              style:
                  AppTextStyles.mediumText16w500.apply(color: AppColors.white),
            ),
            AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  if (controller.state is BalanceStateLoading) {
                    return Container(
                      color: AppColors.blueTwo,
                      constraints: BoxConstraints.tightFor(width: 80.0.w),
                      height: 36.0.h,
                    );
                  }
                  return ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 120.0.w),
                    child: Text(
                      'R\$${amount.toStringAsFixed(2)}',
                      textScaleFactor: textScaleFactor,
                      style: AppTextStyles.mediumText20
                          .apply(color: AppColors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
          ],
        )
      ],
    );
  }
}

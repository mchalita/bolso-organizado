import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/widgets/custom_bottom_sheet.dart';
import 'package:bolso_organizado/commons/widgets/custom_snackbar.dart';
import 'package:bolso_organizado/commons/widgets/primary_button.dart';
import 'package:bolso_organizado/features/transaction/transaction.dart';
import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../locator.dart';
import '../extensions/extensions.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({
    super.key,
    required this.transactionList,
    this.itemCount,
    required this.onChange,
  }) : showDate = false;

  const TransactionListView.withCalendar({
    super.key,
    required this.transactionList,
    this.itemCount,
    required this.onChange,
  }) : showDate = true;

  final List<TransactionModel> transactionList;
  final int? itemCount;
  final bool showDate;

  ///Called when transaction is updated or deleted
  final VoidCallback onChange;

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView>
    with CustomModalSheetMixin, CustomSnackBar, SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final transactionController = locator.get<TransactionController>();
  bool? confirmDelete = false;

  late TabController _tabController;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();

    _currentMonth = DateTime.now();
    _tabController = TabController(length: 1, vsync: this);

    transactionController.addListener(() {
      if (transactionController.state is TransactionStateError) {
        if (!mounted) return;
        final state = transactionController.state as TransactionStateError;
        setState(() {
          showCustomSnackBar(
            context: context,
            text: state.message,
            type: SnackBarType.error,
          );
        });
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      _tabController.index = 0;
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      _tabController.index = 0;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    locator.resetLazySingleton<TransactionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      slivers: [
        if (widget.showDate)
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: AppColors.blue,
                    onPressed: _goToPreviousMonth,
                  ),
                  TabBar(
                    labelColor: AppColors.blue,
                    labelStyle: AppTextStyles.mediumText16w600,
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: DateFormat('MMMM yyyy').format(_currentMonth),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    color: AppColors.blue,
                    onPressed: _goToNextMonth,
                  ),
                ],
              ),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: widget.itemCount ?? widget.transactionList.length,
            (context, index) {
              final item = widget.transactionList[index];
              final itemDate = DateTime.fromMillisecondsSinceEpoch(item.date);
              final isCurrentDate = itemDate.month == _currentMonth.month &&
                  itemDate.year == _currentMonth.year;

              final color =
                  item.value.isNegative ? AppColors.outcome : AppColors.income;

              final value = "R\$${item.value.toStringAsFixed(2)}".replaceAll(".", ",");

              if (widget.showDate && !isCurrentDate) {
                return const SizedBox.shrink();
              }

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                dismissThresholds: const {DismissDirection.endToStart: 0.5},
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) async {
                  if (confirmDelete!) {
                    await transactionController.deleteTransaction(item);
                    if (!mounted) return;
                    widget.onChange();
                  }
                },
                confirmDismiss: (direction) async {
                  confirmDelete = await showCustomModalBottomSheet(
                    context: context,
                    content: 'Tem certeza que deseja deletar?',
                    actions: [
                      Flexible(
                        child: PrimaryButton(
                          text: 'Cancelar',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        child: PrimaryButton(
                          text: 'Confirmar',
                          onPressed: () {
                            if (mounted) {
                              Navigator.pop(context, true);
                            }
                          },
                        ),
                      ),
                    ],
                  );

                  return confirmDelete;
                },
                child: ListTile(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/transaction',
                      arguments: item,
                    );
                    if (result != null) {
                      if (!mounted) return;
                      widget.onChange();
                    }
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.antiFlashWhite,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.monetization_on_outlined,
                    ),
                  ),
                  title: Text(
                    item.description,
                    style: AppTextStyles.mediumText16w500,
                  ),
                  subtitle: Text(
                    DateTime.fromMillisecondsSinceEpoch(item.date).toText,
                    style: AppTextStyles.smallText13,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: AppTextStyles.mediumText18.apply(color: color),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

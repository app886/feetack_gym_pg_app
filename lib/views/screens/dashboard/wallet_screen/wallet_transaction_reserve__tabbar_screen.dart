import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/wallet_controller.dart';
import '../../../../../services/constants.dart';
import '../../../../../services/theme.dart';
import '../../transaction_screen/transaction_screen.dart';
import 'wallet_screen.dart';

class WalletTransactionReserveTabbarScreen extends StatefulWidget {
  const WalletTransactionReserveTabbarScreen({super.key});

  @override
  State<WalletTransactionReserveTabbarScreen> createState() =>
      _WalletTransactionReserveTabbarScreenState();
}

class _WalletTransactionReserveTabbarScreenState
    extends State<WalletTransactionReserveTabbarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<WalletController>();
      controller.fetchHistoryData();
      controller.fetchReserveHistory();
      controller.fetchWalletBalance();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
        ),
        title: Text(
          "Wallet Activity",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
              ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                if (index == 1) {
                  // Navigate to TransactionScreen on tap
                  navigate(context: context, page: const TransactionScreen());
                  // Reset to previous index so the tab doesn't stay on 'Transaction'
                  _tabController.index = _tabController.previousIndex;
                }
              },
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF002060),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF002060).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              tabs: const [
                Tab(text: "Wallet"),
                Tab(text: "Transaction"),
                Tab(text: "Reserve"),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<WalletController>(
        builder: (walletController) {
          return TabBarView(
            controller: _tabController,
            children: [
              // Wallet Tab - Shows the Wallet Summary/Actions screen
              const WalletScreen(),
              
              // Transaction Tab - Wallet Transaction History
              _buildHistoryList(
                context,
                walletController.isHistoryLoading,
                walletController.walletHistory,
                (item) => _buildWalletItem(context, item),
                "No wallet transactions found",
              ),
              
              // Reserve Tab - Reserve Amount History
              _buildHistoryList(
                context,
                walletController.isHistoryLoading,
                walletController.reserveHistory,
                (item) => _buildReserveItem(context, item),
                "No reserve records found",
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    bool isLoading,
    List<dynamic> list,
    Widget Function(dynamic) itemBuilder,
    String emptyMessage,
  ) {
    if (isLoading && list.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF002060)));
    }

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 64, color: Colors.grey.shade200),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => itemBuilder(list[index]),
    );
  }

  Widget _buildWalletItem(BuildContext context, dynamic item) {
    final bool isCredit = item['type'] == 'credit';
    final String amount = (isCredit ? "+ " : "- ") + PriceConverter.convertToNumberFormat((item['amount'] as num?)?.toDouble() ?? 0.0);
    final String date = DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(item['created_at']));
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isCredit ? Colors.green.shade50 : Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.add_rounded : Icons.remove_rounded,
              color: isCredit ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['description'] ?? "Transaction",
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: isCredit ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReserveItem(BuildContext context, dynamic item) {
    final String status = item['status'].toString().toUpperCase();
    final Color statusColor = status == "ACTIVE" ? Colors.green : Colors.orange;
    final String date = DateFormat('dd MMM yyyy').format(DateTime.parse(item['created_at']));
    final breakdown = item['breakdown'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['listing']?['title'] ?? "Reserve Amount",
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Booking ID: ${item['booking_id']}",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Reserved",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "₹${item['amount']}",
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF002060)),
                  ),
                ],
              ),
              if (breakdown != null) ...[
                Row(
                  children: [
                    _buildSmallBreakdown("Rent", "₹${breakdown['rent']}"),
                    const SizedBox(width: 16),
                    _buildSmallBreakdown("Deposit", "₹${breakdown['deposit']}"),
                  ],
                )
              ] else ...[
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBreakdown(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 9, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vlr/controllers/wallet_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isBalanceVisible = true;
  int _selectedActionIndex = -1; // -1: None, 1: Recharge, 2: Withdraw

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<WalletController>();
      controller.fetchWalletBalance();
      controller.fetchWalletSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController) {
      return Container(
        color: const Color(0xFFF8F9FE),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildSummaryCard(
                      title: "Balance",
                      amount: walletController.walletBalance,
                      icon: Icons.account_balance_wallet_rounded,
                      color: const Color(0xFF002060),
                    ),
                    const SizedBox(width: 16),
                    _buildSummaryCard(
                      title: "Total Credit",
                      amount: walletController.totalCredit,
                      icon: Icons.arrow_downward_rounded,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 16),
                    _buildSummaryCard(
                      title: "Total Debit",
                      amount: walletController.totalDebit,
                      icon: Icons.arrow_upward_rounded,
                      color: Colors.red.shade700,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Available Balance Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        _isBalanceVisible 
                          ? PriceConverter.convertToNumberFormat(walletController.walletBalance)
                          : "₹ ••••••••",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A3B5D),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
                        child: Icon(
                          _isBalanceVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Actions Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickAction(
                      icon: Icons.add_circle_outline_rounded,
                      label: "Add Money",
                      color: const Color(0xFF6366F1),
                      onTap: () => walletController.navigateToAddMoney(context),
                      isSelected: false,
                    ),
                    _buildQuickAction(
                      icon: Icons.lock_clock_outlined,
                      label: "Recharge",
                      color: const Color(0xFFF59E0B),
                      onTap: () {
                        if (_selectedActionIndex == 1) {
                          setState(() => _selectedActionIndex = -1);
                        } else {
                          setState(() => _selectedActionIndex = 1);
                          walletController.setHistoryTabIndex(1);
                        }
                      },
                      isSelected: _selectedActionIndex == 1,
                    ),
                    _buildQuickAction(
                      icon: Icons.outbond_outlined,
                      label: "Withdraw",
                      color: const Color(0xFF10B981),
                      onTap: () {
                        if (_selectedActionIndex == 2) {
                          setState(() => _selectedActionIndex = -1);
                        } else {
                          setState(() => _selectedActionIndex = 2);
                          walletController.setHistoryTabIndex(2);
                        }
                      },
                      isSelected: _selectedActionIndex == 2,
                    ),
                    _buildQuickAction(
                      icon: Icons.history_rounded,
                      label: "History",
                      color: const Color(0xFF6366F1),
                      onTap: () {
                        if (_selectedActionIndex == 3) {
                          setState(() => _selectedActionIndex = -1);
                        } else {
                          setState(() => _selectedActionIndex = 3);
                          walletController.setHistoryTabIndex(3);
                        }
                      },
                      isSelected: _selectedActionIndex == 3,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Dynamic History List
              if (_selectedActionIndex != -1) ...[
                Text(
                  _selectedActionIndex == 1 
                    ? "Recharge History" 
                    : (_selectedActionIndex == 2 ? "Withdrawal History" : "Wallet History"),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A3B5D),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDynamicHistoryList(walletController),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDynamicHistoryList(WalletController controller) {
    if (controller.isHistoryLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF002060)));
    }

    final List<dynamic> currentList = _selectedActionIndex == 1 
        ? controller.rechargeHistory 
        : (_selectedActionIndex == 2 ? controller.withdrawalHistory : controller.walletHistory);

    if (currentList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(Icons.history_rounded, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              "No records found",
              style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = currentList[index];
        return _buildHistoryItem(item);
      },
    );
  }

  Widget _buildHistoryItem(dynamic item) {
    String title = "";
    String subtitle = "";
    String amount = "";
    String date = "";
    String status = "";
    Color statusColor = Colors.orange;
    IconData icon = Icons.history_rounded;
    bool isCredit = true;

    if (_selectedActionIndex == 1) {
      // Recharge History
      title = "Wallet Top Up";
      subtitle = item['transaction_id'] != null ? "UTR: ${item['transaction_id']}" : "Manual Top Up";
      amount = "+ ₹${item['amount']}";
      date = DateFormat('dd MMM yyyy').format(DateTime.parse(item['created_at']));
      status = item['status'].toString().toUpperCase();
      icon = Icons.add_to_photos_rounded;
      isCredit = true;
    } else if (_selectedActionIndex == 2) {
      // Withdrawal History
      title = "Withdrawal Request";
      subtitle = item['payment_method'] ?? "Wallet Withdrawal";
      amount = "- ₹${item['amount']}";
      date = DateFormat('dd MMM yyyy').format(DateTime.parse(item['created_at']));
      status = item['status'].toString().toUpperCase();
      icon = Icons.account_balance_rounded;
      isCredit = false;
    } else {
      // General Wallet History
      title = item['description'] ?? "Wallet Transaction";
      subtitle = (item['reference_type'] ?? "Wallet").toString().toUpperCase();
      isCredit = item['type'] == 'credit';
      amount = (isCredit ? "+ " : "- ") + "₹${item['amount']}";
      date = DateFormat('dd MMM yyyy').format(DateTime.parse(item['created_at']));
      status = isCredit ? "CREDIT" : "DEBIT";
      icon = isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
      statusColor = isCredit ? Colors.green : Colors.red;
    }
    
    // Status color logic for Recharge & Withdrawal
    if (_selectedActionIndex == 1 || _selectedActionIndex == 2) {
      if (status == "APPROVED" || status == "PAID" || status == "SUCCESS") statusColor = Colors.green;
      if (status == "REJECTED" || status == "FAILED") statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.w900, 
                  fontSize: 15, 
                  color: isCredit ? Colors.green.shade700 : Colors.red.shade700
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 9),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? color : color.withValues(alpha: 0.1), 
                width: 1.5
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ] : [],
            ),
            child: Icon(
              icon, 
              color: isSelected ? Colors.white : color, 
              size: 28
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? color : const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4,
            offset: const Offset(0, 1),
          )
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade500,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              Icon(icon, size: 10, color: color),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 7,
                color: color.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 3),
              Text(
                "Active",
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w800,
                  color: color.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

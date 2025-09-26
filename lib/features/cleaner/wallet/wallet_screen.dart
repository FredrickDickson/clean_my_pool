import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletBalanceProvider = StateProvider<double>((ref) => 120.50);

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(walletBalanceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Balance: \$${balance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle withdrawal logic
                ref.read(walletBalanceProvider.notifier).state -= 50.0; // Example deduction
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal requested!')));
              },
              child: const Text('Withdraw'),
            ),
            const SizedBox(height: 16),
            const Text('Earnings History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(title: const Text('Sep 26, 2025: $50'), trailing: const Text('Completed')),
          ],
        ),
      ),
    );
  }
}
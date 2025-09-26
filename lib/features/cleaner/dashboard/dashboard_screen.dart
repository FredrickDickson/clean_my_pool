import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedJobProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

class CleanerDashboardScreen extends ConsumerWidget {
  const CleanerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cleaner Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Today’s Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(child: _JobList(ref: ref)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _JobList extends ConsumerWidget {
  final WidgetRef ref;
  const _JobList({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = [
      {'customer': 'John Doe', 'service': 'Deep Clean', 'price': 50, 'status': 'Pending'},
      {'customer': 'Jane Smith', 'service': 'Basic Clean', 'price': 30, 'status': 'Pending'},
    ];

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Card(
          child: ListTile(
            title: Text(job['customer'] as String),
            subtitle: Text('${job['service']} • \$${job['price']}'),
            trailing: job['status'] == 'Pending'
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref.read(selectedJobProvider.notifier).state = job;
                          _showJobActions(context, ref);
                        },
                        child: const Text('Accept'),
                      ),
                      TextButton(onPressed: () {}, child: const Text('Decline')),
                    ],
                  )
                : const Text('Completed'),
          ),
        );
      },
    );
  }

  void _showJobActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final job = ref.watch(selectedJobProvider);
        if (job == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Job: ${job['service']} for ${job['customer']}'),
              ElevatedButton(
                onPressed: () {
                  // Mark as completed (update status)
                  ref.read(selectedJobProvider.notifier).state = {...job, 'status': 'Completed'};
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job marked as completed!')));
                },
                child: const Text('Complete Job'),
              ),
            ],
          ),
        );
      },
    );
  }
}
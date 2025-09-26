import 'package:cleanmypool/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedServiceProvider = StateProvider<String?>((ref) => null);
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final bookingPriceProvider = StateProvider<double>((ref) => 0.0); // Price in USD; convert to kobo for Paystack

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  String? _userEmail = 'customer@example.com';  // Fetch from auth state in prod
  String? _reference;

  @override
  void initState() {
    super.initState();
    PaymentService.initialize(); // Initialize Paystack
  }

  @override
  Widget build(BuildContext context) {
    final selectedService = ref.watch(selectedServiceProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final price = ref.watch(bookingPriceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book a Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              hint: const Text('Choose a service'),
              value: selectedService,
              items: const [
                DropdownMenuItem(value: 'Basic Clean', child: Text('Basic Clean')),
                DropdownMenuItem(value: 'Deep Clean', child: Text('Deep Clean')),
                DropdownMenuItem(value: 'Chemical', child: Text('Chemical')),
                DropdownMenuItem(value: 'Repairs', child: Text('Repairs')),
              ],
              onChanged: (value) {
                ref.read(selectedServiceProvider.notifier).state = value;
                ref.read(bookingPriceProvider.notifier).state = _getPrice(value);
              },
            ),
            const SizedBox(height: 16),
            const Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026),
                );
                if (date != null) ref.read(selectedDateProvider.notifier).state = date;
              },
              child: const Text('Pick Date'),
            ),
            Text(selectedDate?.toString() ?? 'No date selected'),
            const SizedBox(height: 16),
            Text('Price: \$${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: selectedService == null || selectedDate == null
                  ? null
                  : () async {
                      _reference = PaymentService.generateReference();
                      final amountInKobo = (price * 100 * 1000).toInt();  // Convert USD to kobo (assuming 1 USD = 1000 NGN; adjust rate)
                      final success = await PaymentService.openCheckout(
                        context: context,
                        amount: amountInKobo,
                        email: _userEmail!,
                        reference: _reference!,
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment successful! Booking confirmed.')),
                        );
                        Navigator.pop(context); // Return to home
                        // Optionally, save booking to Supabase here
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment failed. Please try again.')),
                        );
                      }
                    },
              child: const Text('Pay and Book with Paystack'),
            ),
          ],
        ),
      ),
    );
  }

  double _getPrice(String? service) {
    switch (service) {
      case 'Basic Clean':
        return 30.0;
      case 'Deep Clean':
        return 50.0;
      case 'Chemical':
        return 40.0;
      case 'Repairs':
        return 70.0;
      default:
        return 0.0;
    }
  }
}
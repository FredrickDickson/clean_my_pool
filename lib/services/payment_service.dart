import 'package:paystack_flutter_sdk/paystack_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  static const String _publicKey = 'pk_test_your_public_key';  // Replace with your Paystack public key (test/live)
  static const String _secretKey = 'sk_test_your_secret_key';  // Replace with your secret key (server-side only)
  static const String _baseUrl = 'https://api.paystack.co';  // Paystack API base URL

  // Initialize Paystack SDK
  static void initialize() {
    PaystackPlugin.initialize(publicKey: _publicKey);
  }

  // Open Paystack checkout for payment
  static Future<bool> openCheckout({
    required BuildContext context,
    required int amount,  // Amount in kobo (e.g., 10000 for ₦100)
    required String email,
    required String reference,  // Unique transaction reference (generate on your backend)
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    try {
      final charge = Charge(
        amount: amount,
        email: email,
        ref: reference,
        firstname: firstName,
        lastname: lastName,
        channels: [Channel.card],  // Add more channels like [Channel.card, Channel.bank_transfer] if needed
      );

      final result = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.selectable,
        charge: charge,
        logo: Image.asset('assets/logo.png'),  // Optional: Add your app logo
      );

      if (result.status == true) {
        // Payment successful on client-side; verify on server
        final verified = await _verifyTransaction(reference);
        return verified;
      }
      return false;
    } catch (e) {
      debugPrint('Paystack error: $e');
      return false;
    }
  }

  // Server-side verification (call your backend endpoint that uses secret key)
  static Future<bool> _verifyTransaction(String reference) async {
    // In production, call your backend API (e.g., Supabase function) with the reference
    // For demo: Simulate a direct API call (not secure for prod; use secret key only server-side)
    final response = await http.get(
      Uri.parse('$_baseUrl/transaction/verify/$reference'),
      headers: {
        'Authorization': 'Bearer $_secretKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['status'] == 'success';
    }
    return false;
  }
}

// Helper to generate unique reference (use UUID or backend-generated in prod)
String generateReference() {
  return 'txn_${DateTime.now().millisecondsSinceEpoch}';
}
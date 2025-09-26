import 'package:cleanmypool/services/supabase_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late MockSupabaseClient mockSupabase;
  late SupabaseService supabaseService;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    supabaseService = SupabaseService();
  });

  group('SupabaseService Tests', () {
    test('signIn should return user on success', () async {
      when(mockSupabase.auth.signInWithPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => AuthResponse(data: User(id: '1', email: 'test@example.com', appMetadata: {})));

      final user = await supabaseService.signIn(email: 'test@example.com', password: 'password');
      expect(user?.id, '1');
    });

    test('signIn should return null on failure', () async {
      when(mockSupabase.auth.signInWithPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Exception('Login failed'));

      final user = await supabaseService.signIn(email: 'test@example.com', password: 'password');
      expect(user, isNull);
    });
  });
}
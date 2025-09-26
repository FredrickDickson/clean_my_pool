import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CleanMyPool')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Find pool cleaners near you',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Service Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _CategoryCard(title: 'Basic Clean', icon: Icons.cleaning_services),
                _CategoryCard(title: 'Deep Clean', icon: Icons.bathtub),
                _CategoryCard(title: 'Chemical', icon: Icons.science),
                _CategoryCard(title: 'Repairs', icon: Icons.build),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Featured Cleaners', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(child: _CleanerList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const _CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [Icon(icon), Text(title)]),
      ),
    );
  }
}

class _CleanerList extends StatelessWidget {
  const _CleanerList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _CleanerCard(name: 'John Doe', rating: 4.7, price: 25),
        _CleanerCard(name: 'Jane Smith', rating: 4.5, price: 20),
      ],
    );
  }
}

class _CleanerCard extends StatelessWidget {
  final String name;
  final double rating;
  final int price;
  const _CleanerCard({required this.name, required this.rating, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Colors.grey),
        title: Text(name),
        subtitle: Text('★ $rating • \$$price/hr'),
        trailing: ElevatedButton(onPressed: () {}, child: const Text('Book')),
      ),
    );
  }
}
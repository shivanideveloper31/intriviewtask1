import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:interview_task1/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'items_screen.dart';

class UserDetails {
  final String email;
  final String phone;

  UserDetails({required this.email, required this.phone});
}

class ProductScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu), // 3-line menu icon
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.greenAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Salad and soup'),
              Tab(text: 'From The Barnyard'),
              Tab(text: 'From The'),

            ],
          ),
        ),
        drawer: Drawer(
          child: FutureBuilder<UserDetails>(
            future: _getUserDetails(), // Fetch user details
            builder: (context, snapshot) {
              // Handle loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Handle error state
              if (snapshot.hasError) {
                return Center(child: Text('Error loading user data'));
              }

              final userDetails = snapshot.data;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration:
                    BoxDecoration(color: Colors.greenAccent.shade700),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOqesHqgoCzXaECbUzpPCekyXMHb5aoRJi2zDX7-KPYTE3cHhAkzF3zuhkRtn9Z3pUg4Y&usqp=CAU',
                      ),
                    ),
                    accountEmail:
                    Text(userDetails?.email ?? 'Email not available'),
                    accountName:
                    Text(userDetails?.phone ?? 'User name not available'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      await _logout(); // Log out
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: const TabBarView(
          children: [
            Items(), // First tab content (your Items widget)
            Center(child: Text('Tab 2 Content')), // Second tab content
            Center(child: Text('Tab 3 Content')), // Second tab content
          ],
        ),
      ),
    );
  }

  Future<UserDetails> _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    String? phone = prefs.getString('userName');

    return UserDetails(
      email: email ?? 'Email not available',
      phone: phone ?? 'Phone not available',
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user data
    Get.offAll(() => const LoginScreen()); // Navigate to login screen using GetX
  }
}
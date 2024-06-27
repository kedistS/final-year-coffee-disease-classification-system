import 'package:bunnaapp/components/about/about.dart';
import 'package:bunnaapp/components/account/user_profile.dart';
import 'package:bunnaapp/components/faq/faq.dart';
import 'package:bunnaapp/components/history/history.dart';
import 'package:bunnaapp/components/home/home.dart';
import 'package:bunnaapp/providers/history_provider.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:bunnaapp/services/history_service.dart';
import 'package:bunnaapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xE4E9FFE9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Color.fromARGB(131, 40, 124, 61),
          //   ),
          //   child: Text(
          //     'Coffee Disease Classifier Application (CODICAP)',
          //   ),
          // ),
          Container(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Color.fromARGB(100, 112, 212, 124),
            ),
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(228, 73, 161, 95),
              ),
              accountName:
                  Text(context.read<UserProvider>().username ?? "User"),
              accountEmail: Text(
                context.read<UserProvider>().role ?? "User",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade100),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 35.0,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              size: 35.0,
            ),
            title: const Text('History'),
            onTap: () async {
              final history = context.read<HistoryProvider>().history;
              if (history.isEmpty) {
                await fetchHistoryData(context);
              }
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const History()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 35.0,
            ),
            title: const Text('Account'),
            onTap: () async {
              final user = await getUser(context);
              if (user != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(user: user)),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 35.0,
            ),
            title: const Text('About Us'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.question_mark_rounded,
              size: 35.0,
            ),
            title: const Text('FAQ'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FAQPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 35.0,
            ),
            title: const Text('Log Out'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

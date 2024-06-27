import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/models/models.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:bunnaapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool openModal = false;
  void _showUpdateProfileDialog() {
    Future<void> showUpdateProfileDialogAsync() async {
      final user = await getUser(context);
      if (user != null) {
        final TextEditingController firstNameController =
            TextEditingController(text: user.firstName ?? '');
        final TextEditingController lastNameController =
            TextEditingController(text: user.lastName ?? '');
        final TextEditingController emailController =
            TextEditingController(text: user.email ?? '');
        final TextEditingController phoneNumberController =
            TextEditingController(text: user.phoneNumber ?? '');
        final TextEditingController regionController =
            TextEditingController(text: user.region ?? '');
        final TextEditingController zoneController =
            TextEditingController(text: user.zone ?? '');
        final TextEditingController occupationController =
            TextEditingController(text: user.occupationType ?? '');

        // Show the dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Update Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: phoneNumberController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                    TextField(
                      controller: regionController,
                      decoration: const InputDecoration(labelText: 'Region'),
                    ),
                    TextField(
                      controller: zoneController,
                      decoration: const InputDecoration(labelText: 'Zone'),
                    ),
                    TextField(
                      controller: occupationController,
                      decoration:
                          const InputDecoration(labelText: 'Occupation'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    User newUser = User(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                      region: regionController.text,
                      zone: zoneController.text,
                      occupationType: occupationController.text,
                    );
                    final updated = await updateUser(newUser, context);
                    if (updated == true) {
                      Navigator.of(context).pop();
                    } else {
                      const snackBar =
                          SnackBar(content: Text('Missing or Invalid input'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      }
    }

    // Call the helper function
    showUpdateProfileDialogAsync();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement the delete user logic
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const Divider(),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Name:", style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Text('${userProvider.username}',
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Role:",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(width: 8),
                        Text(
                          '${userProvider.role}',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Update User information",
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _showUpdateProfileDialog,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )),
                      child: const Text("Update profile"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delete User",
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(217, 255, 53, 53)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                      onPressed: _showDeleteConfirmationDialog,
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

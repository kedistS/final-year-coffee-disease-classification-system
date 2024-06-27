import 'package:bunnaapp/components/forgetPassword/resetPage.dart';
import 'package:flutter/material.dart';
import "../../services/user_service.dart";

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  void _resetPassword() async {
    final email = _emailController.text.trim();
    bool validEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!validEmail) {
      const snackBar = SnackBar(
        content: Text('Invalid email'),
        backgroundColor: Color.fromRGBO(255, 14, 22, 0.671),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final codeSent = await forgotPassword(email);
      if (codeSent == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 36),
        child: Column(
          children: [
            const Text(
                'Add your email and click the reset password, you will recieve a code to reset your password in your email',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

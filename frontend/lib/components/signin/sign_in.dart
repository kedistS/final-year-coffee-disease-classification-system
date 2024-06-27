import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bunnaapp/components/forgetPassword/forgetPassword.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:provider/provider.dart';
import 'package:bunnaapp/components/researcher/dashboard.dart';
import 'package:flutter/material.dart';
import '/components/auth/auth.dart';
import '../home/home.dart';
import '/components/signup/page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false; // Add loading state

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Sign In",
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "abebe@example.com"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(" "),
                    GestureDetector(
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF00B115)),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()),
                          (route) => false,
                        );
                      },
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            _login(context);
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return _isLoading
                              ? Colors.grey
                              : const Color(0XFFcfe2ce);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Log In")),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xFFD3D1D1),
                    thickness: 0.7,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet? "),
                    GestureDetector(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color(0xFF00B115)),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                          (route) => false,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool validEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (email == "" || password == "" || !validEmail) {
      log("invalid email or password");
      const snackBar = SnackBar(
        content: Text('Invalid email or password'),
        backgroundColor: Color.fromRGBO(255, 14, 22, 0.671),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Start a timer for timeout
    const timeoutDuration = Duration(seconds: 10);
    bool timedOut = false;
    Timer? timeoutTimer;

    timeoutTimer = Timer(timeoutDuration, () {
      timedOut = true;
      setState(() {
        _isLoading = false;
      });
    });

    final loggedIn =
        await login(email: email, password: password, context: context);

    // Clear the timeout timer regardless of the login result
    timeoutTimer.cancel();

    if (loggedIn == true) {
      goToHome(context, context.read<UserProvider>().role ?? "user");
    } else {
      const snackBar = SnackBar(content: Text('Logging failed, Try again!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void goToHome(BuildContext context, String role) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
    );
  }
}

import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:bunnaapp/models/user.dart';
import "page2.dart";

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "CODICAP",
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ),
      body: const Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 350,
              height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("Sign Up",
                          style: Theme.of(context).textTheme.displayLarge)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "First Name",
                          hintText: "John"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Last Name",
                          hintText: "Doe"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "John@example.com"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_emailController.text == "" ||
                            _firstNameController.text == "" ||
                            _lastNameController.text == "" ||
                            _passwordController.text == "") {
                          const snackBar =
                              SnackBar(content: Text('Fill all the fields'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        User newUser = User(
                          email: _emailController.text.trim(),
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUp2(user: newUser)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Next"),
                            Icon(Icons.arrow_forward, size: 24),
                          ],
                        ),
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
                      const Text("Already have an account? "),
                      GestureDetector(
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xFF00B115)),
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                            (route) => false,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

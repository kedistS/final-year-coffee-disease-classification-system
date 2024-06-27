import 'dart:developer';
import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:bunnaapp/services/user_service.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';
import '../../models/user.dart';
import "page1.dart";
import '../../data/regions.dart';

class SignUp2 extends StatelessWidget {
  final User user;

  const SignUp2({Key? key, required this.user}) : super(key: key);

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
      body: Page2(user: user),
    );
  }
}

class Page2 extends StatefulWidget {
  final User user;

  Page2({Key? key, required this.user}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String? regionValue;
  String? zoneValue;
  String? occupationValue;
  final Map<String, List<String>> regionZones = Region_Zones;
  List<String> _zones = [];
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _goToHome() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignIn()));
    }

    signup(user) async {
      setState(() {
        _isLoading = true;
      });
      if (user.isValid()) {
        final registered = await register(user);
        if (registered == true) {
          log("User created successfully");
          _goToHome();
        } else {
          const snackBar = SnackBar(content: Text('Registration failed'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        const snackBar = SnackBar(content: Text('Missing or Invalid input'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Center(
          child: SizedBox(
            width: 350,
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, size: 24),
                            Text("Back"),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Phone Number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CountryFlag.fromCountryCode(
                            'et',
                            height: 30,
                            width: 30,
                            borderRadius: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: DropdownButtonFormField<String>(
                      value: regionValue,
                      decoration: InputDecoration(labelText: 'Region'),
                      items: regionZones.keys.map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          regionValue = value;
                          _zones = regionZones[value] ?? [];
                          zoneValue = null; // Reset zone value
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your region';
                        }
                        return null;
                      },
                      onSaved: (value) => regionValue = value,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: DropdownButtonFormField<String>(
                      value: zoneValue,
                      decoration: InputDecoration(labelText: 'Zone'),
                      items: _zones.map((String zone) {
                        return DropdownMenuItem<String>(
                          value: zone,
                          child: Text(zone),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          zoneValue = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your zone';
                        }
                        return null;
                      },
                      onSaved: (value) => zoneValue = value,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: DropdownMenu<String>(
                      hintText: "Occupation",
                      onSelected: (String? newValue) {
                        setState(() {
                          occupationValue = newValue;
                        });
                      },
                      dropdownMenuEntries: <String>['Farmer', 'Researcher']
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
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
                      onPressed: _isLoading
                          ? null
                          : () {
                              widget.user.phoneNumber =
                                  "+251${phoneController.text.substring(1)}";
                              widget.user.region = regionValue;
                              widget.user.zone = zoneValue;
                              widget.user.occupationType = occupationValue;

                              signup(widget.user);
                            },
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text("Register")),
                            ),
                    ),
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
    phoneController.dispose();
    super.dispose();
  }
}

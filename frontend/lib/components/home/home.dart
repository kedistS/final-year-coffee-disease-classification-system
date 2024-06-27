import 'dart:io';
import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/components/home/notification.dart';
import 'package:bunnaapp/components/information/informations.dart';
import 'package:bunnaapp/components/researcher/dashboard.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:bunnaapp/services/analytics_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import "package:flutter/material.dart";
import '../imageProcessing/image_processing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? pickedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(returnedImage.path);
    });

    _gotoProcessing();
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(returnedImage.path);
    });

    _gotoProcessing();
  }

  _gotoProcessing() {
    if (pickedImage != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ImageProcessing(imageFile: pickedImage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = context.watch<UserProvider>().role;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      drawer: UserDrawer(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NotificationChip(),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (userRole?.toLowerCase() ==
                    'researcher') // Conditionally render the Dashboard button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: TextButton(
                        onPressed: () async {
                          final analytics =
                              context.read<AnalyticsProvider>().analytics;
                          if (analytics == null) {
                            await fetchAnalyticsData(context);
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.dashboard, size: 24),
                            Text(
                              "Dashboard",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        _pickImageFromCamera();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera_alt, size: 24),
                          Text(
                            "Direct Scan",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.image, size: 24),
                          Text(
                            "Upload Image",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Informations()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.info, size: 24),
                          Text(
                            "Informations",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/epidemic_provider.dart';

class Informations extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<Informations> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlert(context);
    });
  }

  void _showAlert(BuildContext context) {
    final diseases =
        Provider.of<EpidemicProvider>(context, listen: false).diseases;
    if (diseases != null && diseases.isNotEmpty) {
      final diseaseCount = diseases.length;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Epidemic Alert'),
          content:
              Text('There are $diseaseCount epidemic diseases in your region.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final diseases = Provider.of<EpidemicProvider>(context).diseases;

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Epidemic Diseases",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const Divider(
              endIndent: 64,
            ),
            Expanded(
              child: diseases == null || diseases.isEmpty
                  ? const Center(child: Text('No epidemic diseases reported.'))
                  : ListView.builder(
                      itemCount: diseases.length,
                      itemBuilder: (context, index) {
                        final disease = diseases[index];
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: ListTile(
                            title: Text(disease.diseaseName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle:
                                Text('Reported cases: ${disease.reported}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

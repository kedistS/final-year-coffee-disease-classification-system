import 'package:bunnaapp/providers/epidemic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationChip extends StatefulWidget {
  @override
  NotificationChipState createState() => NotificationChipState();
}

class NotificationChipState extends State<NotificationChip> {
  bool _isChipVisible = true;

  void _removeChip() {
    setState(() {
      _isChipVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final diseases =
        Provider.of<EpidemicProvider>(context, listen: false).diseases ?? [];

    return Center(
      child: _isChipVisible && diseases.isNotEmpty
          ? Chip(
              label: Text(
                'There are ${diseases.length} diseases with high prevalence in your region. Check out the information section for more details.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              onDeleted: _removeChip,
            )
          : SizedBox.shrink(),
    );
  }
}

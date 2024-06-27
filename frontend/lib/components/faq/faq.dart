import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Accordion(
        headerBorderColor: Colors.green.shade200,
        headerBorderColorOpened: Colors.grey.shade200,
        headerBackgroundColorOpened: const Color(0xEBD6FFE0),
        contentBackgroundColor: Colors.white,
        contentBorderColor: Colors.grey.shade200,
        contentBorderWidth: 3,
        contentHorizontalPadding: 20,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.question_answer, color: Colors.white),
            header: const Text('What is Codicap?', style: headerStyle),
            content: const Text(
              'Codicap is a coffee disease classifier application. Users can send a picture of a coffee leaf to identify a coffee disease, and our system powered by AI will return the result with recommended actions.',
              style: contentStyle,
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.question_answer, color: Colors.white),
            header: const Text('How can I use it?', style: headerStyle),
            content: const Text(
              'Just click the direct scan and capture image or take an already taken image from the gallery and click process image. The result will be shown right away.',
              style: contentStyle,
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.question_answer, color: Colors.white),
            header: const Text('What can researchers get from the app?',
                style: headerStyle),
            content: const Text(
              'Besides image classification, researchers can get analytical data about total reports and distribution of disease per region and other data.',
              style: contentStyle,
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.question_answer, color: Colors.white),
            header: const Text('Why is the accuracy low?', style: headerStyle),
            content: const Text(
              'Images with low quality might result in low accuracy or even wrong classification. Make sure the image is clear and high quality.',
              style: contentStyle,
            ),
          ),
        ],
      ),
    );
  }
}

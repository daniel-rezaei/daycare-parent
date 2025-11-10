import 'package:flutter/material.dart';

import '../widgets/card_document_widgets.dart';


class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  // نمونه داده
  final List<Map<String, String>> documents = [
    {'title': 'Document', 'subtitle': 'Description of document'},
    {'title': 'Form', 'subtitle': 'Form description'},
    {'title': 'Shared Media', 'subtitle': 'Media description'},
    // میتونی هر تعداد سند اضافه کنی
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFDDC8FF), Color(0xFFF1E8FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Document',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return CardDocumentWidgets(
                          title: doc['title'] ?? '',
                          subtitle: doc['subtitle'] ?? '',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

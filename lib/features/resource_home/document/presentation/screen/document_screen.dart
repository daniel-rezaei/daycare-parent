import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/local_storage.dart';
import '../../../../home_page/presentation/widgets/child_info_widget.dart';
import '../bloc/document_bloc.dart';
import '../bloc/document_event.dart';
import '../bloc/document_state.dart';
import '../widgets/card_document_widgets.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user = await LocalStorage.getUser();
      final parentId = user?.guardianId ?? user?.id;

      ChildInfoWidget(
        onLoaded: (childId) {
          if (parentId != null) {
            context.read<DocumentBloc>().add(
              LoadDocumentsEvent(
              ),
            );
          }
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // پس‌زمینه گرادینت
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
                    child: BlocBuilder<DocumentBloc, DocumentState>(
                      builder: (context, state) {
                        if (state is DocumentLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is DocumentLoaded) {
                          final documents = state.documents;
                          if (documents.isEmpty) {
                            return const Center(
                              child: Text('هیچ سندی موجود نیست.'),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final doc = documents[index];
                              return CardDocumentWidgets(
                                title: doc.title ?? 'بدون عنوان',
                                subtitle: doc.description ?? '',
                              );
                            },
                          );
                        } else if (state is DocumentError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox();
                        }
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

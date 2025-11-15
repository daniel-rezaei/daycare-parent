import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home_page/presentation/bloc/child_bloc.dart';
import '../../../../home_page/presentation/bloc/child_state.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart' as form_state;
import '../widgets/card_form_widgets.dart';

class FormScreen extends StatefulWidget {
  final String childId;
  const FormScreen({super.key, required this.childId});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();
    // Load the form assignments for the given child
    final childState = context.read<ChildBloc>().state;
    if (childState is ChildListLoaded) {
      context.read<FormBloc>().add(
        LoadFormEvent(
          childId: childState.selectedChild.id,
          childState: childState, // ⚡ پاس کردن ChildListLoaded
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFDBCDB), Color(0xFFFEE6F2)],
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
            title: const Text('Form', style: TextStyle(color: Colors.black)),
          ),
          body: SizedBox(
            height: screenHeight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: BlocBuilder<FormBloc, form_state.FormState>(
                builder: (context, state) {
                  if (state is form_state.FormLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is form_state.FormLoaded) {
                    final assignments = state.assignments;
                    if (assignments.isEmpty) {
                      return const Center(
                          child: Text('No form available.'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = assignments[index];
                        return CardFormWidgets(
                          title: assignment.title,
                          subtitle: assignment.description ?? '',
                          status: assignment.status ?? '',
                        );
                      },
                    );
                  } else if (state is form_state.FormError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

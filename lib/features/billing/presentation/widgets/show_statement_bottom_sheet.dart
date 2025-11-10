
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resorces/pallete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/billing_doc_bloc.dart';
import '../bloc/billing_doc_event.dart';
import '../bloc/billing_doc_state.dart';

void showStatementBottomSheet(BuildContext context, String guardianId) {
  final bloc = BlocProvider.of<BillingDocBloc>(context);
  bloc.add(LoadLatestStatement(guardianId));

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BlocBuilder<BillingDocBloc, BillingDocState>(
          builder: (context, state) {
            Widget body;

            if (state is BillingDocLoading) {
              body = const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is BillingDocError) {
              body = Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (state is LatestStatementLoaded) {
              final doc = state.document;
              if (doc == null) {
                body = const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      "Not available yet. Please contact the center.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                body = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset('assets/images/ic_pdf_large.svg'),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Download PDF File",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Palette.textForeground,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Download or view your latest statement",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Palette.textForeground,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: handle download by doc.documentId
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.txtTagForeground3,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Download",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Palette.textPrimaryForeground,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              body = const SizedBox();
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/ic_statement.svg'),
                        const SizedBox(width: 6),
                        Text(
                          "Billing Statement",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset('assets/images/ic_cancel.svg'),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Divider(height: 1, color: Palette.bgBorder),
                const SizedBox(height: 12),
                body,
                const SizedBox(height: 12),
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Palette.textSecondaryForeground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            );
          },
        ),
      );
    },
  );
}


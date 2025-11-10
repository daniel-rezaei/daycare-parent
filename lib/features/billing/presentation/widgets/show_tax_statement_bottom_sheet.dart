
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resorces/pallete.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/billing_doc_bloc.dart';
import '../bloc/billing_doc_event.dart';
import '../bloc/billing_doc_state.dart';

void showTaxStatementBottomSheet(BuildContext context, String guardianId) {
  final bloc = BlocProvider.of<BillingDocBloc>(context);
  bloc.add(LoadTaxYears(guardianId));

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
            Widget content;

            if (state is BillingDocLoading) {
              content = const Center(child: CircularProgressIndicator());
            } else if (state is BillingDocError) {
              content = Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is TaxYearsLoaded) {
              final years = state.years;
              if (years.isEmpty) {
                content = const Center(
                  child: Text("Not available yet. Please contact the center."),
                );
              } else {
                content = Column(
                  children: [
                    for (var year in years)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              bloc.add(LoadTaxStatementByYear(guardianId, year));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.txtTagForeground3,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "$year",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Palette.textPrimaryForeground,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
            } else if (state is TaxStatementLoaded) {
              final doc = state.document;
              if (doc == null) {
                content = const Text("Not available for this year yet.");
              } else {
                content = Column(
                  children: [
                    SvgPicture.asset('assets/images/ic_pdf_large.svg'),
                    const SizedBox(height: 12),
                    Text(
                      "Tax statement for ${doc.periodEnd?.year}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Palette.textForeground,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: handle doc.documentId download
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.txtTagForeground3,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Download PDF",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Palette.textPrimaryForeground,
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              content = const SizedBox();
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
                          "Tax Statement",
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
                const Text(
                  "Tax Statement",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Palette.textForeground,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Select a year to view the tax statement",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Palette.textForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                content,
                const SizedBox(height: 20),
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


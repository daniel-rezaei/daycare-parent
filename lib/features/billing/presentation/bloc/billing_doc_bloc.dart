import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_latest_statement_usecase.dart';
import '../../domain/usecase/get_tax_statement_by_year.dart';
import '../../domain/usecase/get_tax_statement_years.dart';
import 'billing_doc_event.dart';
import 'billing_doc_state.dart';

class BillingDocBloc extends Bloc<BillingDocEvent, BillingDocState> {
  final GetLatestStatement getLatestStatement;
  final GetTaxStatementYears getTaxStatementYears;
  final GetTaxStatementByYear getTaxStatementByYear;

  BillingDocBloc({
    required this.getLatestStatement,
    required this.getTaxStatementYears,
    required this.getTaxStatementByYear,
  }) : super(BillingDocInitial()) {
    on<LoadLatestStatement>((event, emit) async {
      emit(BillingDocLoading());
      try {
        final doc = await getLatestStatement(event.guardianId);
        emit(LatestStatementLoaded(doc));
      } catch (e) {
        emit(BillingDocError(e.toString()));
      }
    });

    on<LoadTaxYears>((event, emit) async {
      emit(BillingDocLoading());
      try {
        final years = await getTaxStatementYears(event.guardianId);
        emit(TaxYearsLoaded(years));
      } catch (e) {
        emit(BillingDocError(e.toString()));
      }
    });

    on<LoadTaxStatementByYear>((event, emit) async {
      emit(BillingDocLoading());
      try {
        final doc =
        await getTaxStatementByYear(event.guardianId, event.year);
        emit(TaxStatementLoaded(doc));
      } catch (e) {
        emit(BillingDocError(e.toString()));
      }
    });
  }
}

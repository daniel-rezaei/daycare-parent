import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_document_usecase.dart';
import 'document_event.dart';
import 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetDocumentsUseCase getDocumentsUseCase;

  DocumentBloc(this.getDocumentsUseCase) : super(DocumentInitial()) {
    on<LoadDocumentsEvent>((event, emit) async {
      emit(DocumentLoading());
      try {

        final docs = await getDocumentsUseCase();

        emit(DocumentLoaded(
          documents: docs,
        ));
      } catch (e, st) {
        print('❌ Error loading documents: $e\n$st');
        emit(DocumentError(e.toString()));
      }
    });
  }
}

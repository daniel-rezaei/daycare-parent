import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/usecase/get_health_usecase.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final GetAllergyDataUseCase allergyUseCase;
  final GetDietaryDataUseCase dietaryUseCase;
  final GetMedicationDataUseCase medicationUseCase;
  final GetImmunizationDataUseCase immunizationUseCase;
  final GetPhysicalReqDataUseCase physicalUseCase;
  final GetReportableDiseaseDataUseCase diseaseUseCase;

  HealthBloc({
    required this.allergyUseCase,
    required this.dietaryUseCase,
    required this.medicationUseCase,
    required this.immunizationUseCase,
    required this.physicalUseCase,
    required this.diseaseUseCase,
  }) : super(HealthInitial()) {
    // ---------------- Load Counts ----------------
    on<LoadHealthCounts>((event, emit) async {
      emit(HealthLoading());
      try {
        final counts = {
          "allergies": await allergyUseCase.getCount(event.childId),
          "dietary": await dietaryUseCase.getCount(event.childId),
          "medication": await medicationUseCase.getCount(event.childId),
          "immunization": await immunizationUseCase.getCount(event.childId),
          "physical": await physicalUseCase.getCount(event.childId),
          "diseases": await diseaseUseCase.getCount(event.childId),
        };
        print("Fetching health counts for ${event.childId}");
        emit(HealthLoaded(counts, {}));
      } catch (e) {
        emit(HealthError(e.toString()));
      }
    });

    // ---------------- Load List ----------------
    on<LoadHealthList>((event, emit) async {
      if (state is! HealthLoaded) return;
      final current = state as HealthLoaded;

      try {
        List<dynamic> list = [];
        switch (event.key) {
          case "allergies":
            list = await allergyUseCase.getList(event.childId);
            break;
          case "dietary":
            list = await dietaryUseCase.getList(event.childId);
            break;
          case "medication":
            list = await medicationUseCase.getList(event.childId);
            break;
          case "immunization":
            list = await immunizationUseCase.getList(event.childId);
            break;
          case "physical":
            list = await physicalUseCase.getList(event.childId);
            break;
          case "diseases":
            list = await diseaseUseCase.getList(event.childId);
            break;
        }

        final newLists = Map<String, List<dynamic>>.from(current.lists);
        newLists[event.key] = list;

        emit(HealthLoaded(current.counts, newLists));
      } catch (e) {
        emit(HealthError(e.toString()));
      }
    });
  }
}

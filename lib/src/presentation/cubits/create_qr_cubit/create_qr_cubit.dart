import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/requests/generate_qr_request.dart';
import '../../../domain/models/responses/generate_qr_response.dart';
import '../../../domain/models/responses/get_categories_response.dart';
import '../../../domain/models/responses/get_rayons_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../base/base_cubit.dart';
import '../../../utils/resources/data_state.dart';

part 'create_qr_states.dart';

@injectable
class CreateQrCubit extends BaseCubit<CreateQrState, CreateQrViewData> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;
  CreateQrCubit(this._apiRepository, this._databaseRepository)
      : super(const CreateQrCreate(), CreateQrViewData());

  UserData get userData => _databaseRepository.user!;
  List<Category>? get categories => _databaseRepository.getCategories();
  List<Rayon>? get rayons => _databaseRepository.getRayons();

  Category? _selectedCategory;
  Category? get selectedCategory => _selectedCategory;
  void setselectedCategory(Category? selectedCategory) {
    emit(const CreateQrLoading());
    _selectedCategory = selectedCategory;
    emit(const CreateQrCreate());
  }

  Rayon? _selectedRayon;
  Rayon? get selectedRayon => _selectedRayon;
  void setselectedRayon(Rayon? selectedRayon) {
    emit(const CreateQrLoading());
    _selectedRayon = selectedRayon;
    emit(const CreateQrCreate());
  }

  //Selectable rayons which categoryid's are equal to _selectedCategory.categoryid
  List<Rayon>? get selectableRayons {
    if (_selectedCategory == null) {
      return [
        const Rayon(
          categoryid: -1,
          rayonid: -1,
          rayonname: "Lütfen Kategori Seçiniz",
        )
      ];
    }
    final rayonList = rayons
        ?.where(
            (element) => element.categoryid == _selectedCategory?.categoryid)
        .toList();
    if (rayonList == null || rayonList.isEmpty) {
      return [
        const Rayon(
          categoryid: -1,
          rayonid: -1,
          rayonname: "Bu kategoride reyon eklemediniz ",
        )
      ];
    }

    return rayonList;
  }

  int currentStep = 0;
  void setCurrentStep(int step) {
    currentStep = step;
    emit(const CreateQrCreate());
  }

  void resetState() {
    emit(const CreateQrCreate());
  }

  Future<void> generateQrCode(
      {required String rayon,
      required String category,
      required String productId}) async {
    if (isBusy) return;

    await run(
      () async {
        emit(const CreateQrLoading());
        final response = await _apiRepository.generateQrCode(
          request: GenerateQrRequest(
            reyon: rayon,
            category: category,
            productId: productId,
            company: userData.company,
          ),
        );

        if (response is DataSuccess) {
          emit(CreateQrSuccess(
              createQrViewData: CreateQrViewData(qrResponse: response.data)));
        } else if (response is DataFailed) {
          emit(CreateQrFailed(error: response.error));
        }
      },
    );
  }
}

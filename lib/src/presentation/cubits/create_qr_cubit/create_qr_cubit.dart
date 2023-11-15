import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/requests/generate_qr_request.dart';
import '../../../domain/models/responses/generate_qr_response.dart';
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

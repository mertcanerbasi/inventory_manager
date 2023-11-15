import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/requests/generate_qr_request.dart';
import '../../../domain/models/responses/generate_qr_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../base/base_cubit.dart';
import '../../../utils/resources/data_state.dart';

part 'home_states.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState, HomeViewData> {
  final ApiRepository _apiRepository;

  HomeCubit(this._apiRepository) : super(const HomeCreate(), HomeViewData());

  Future<void> generateQrCode() async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response = await _apiRepository.generateQrCode(
          request: GenerateQrRequest(
            reyon: "1",
            category: "4",
            productId: "10123123",
            company: "Koctas",
          ),
        );

        if (response is DataSuccess) {
          emit(HomeSuccess(
              homeViewData: HomeViewData(qrResponse: response.data)));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }
}

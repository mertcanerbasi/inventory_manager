part of 'create_qr_cubit.dart';

class CreateQrViewData {
  final GenerateQrResponse? qrResponse;
  final DioException? error;

  CreateQrViewData({
    this.qrResponse,
    this.error,
  });
}

abstract class CreateQrState extends Equatable {
  final CreateQrViewData? createQrViewData;
  final DioException? error;
  const CreateQrState({
    this.createQrViewData,
    this.error,
  });

  @override
  List<Object?> get props => [createQrViewData, error];
}

final class CreateQrLoading extends CreateQrState {
  const CreateQrLoading();
}

final class CreateQrSuccess extends CreateQrState {
  const CreateQrSuccess({super.createQrViewData});
}

final class CreateQrFailed extends CreateQrState {
  const CreateQrFailed({super.error});
}

final class CreateQrCreate extends CreateQrState {
  const CreateQrCreate();
}

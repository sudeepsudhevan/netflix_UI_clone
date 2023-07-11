part of 'downloads_bloc.dart';

@freezed
class DownloadsState with _$DownloadsState {
  const factory DownloadsState({
    required bool isLoading,
    List<Downloads>? downloads,
  }) = _DownloadsState;

  factory DownloadsState.initial() {
    return DownloadsState(
      isLoading: false,
    );
  }
}

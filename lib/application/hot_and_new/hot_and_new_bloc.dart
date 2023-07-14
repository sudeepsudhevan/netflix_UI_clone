import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/new_and_hot/hot_and_new_service.dart';
import 'package:netflix_clone/domain/new_and_hot/model/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    //get hot and new movie data
    on<LoadDataInComingSoon>(
      (event, emit) async {
        // loading
        emit(
          const HotAndNewState(
            isLoading: true,
            hasError: false,
            comingSoonList: [],
            everyOneIsWatchingList: [],
          ),
        );
        final _result = await _hotAndNewService.getHotAndNewMovieData();
        final newState = _result.fold(
          (MainFailure Failure) {
            return const HotAndNewState(
              isLoading: false,
              hasError: true,
              comingSoonList: [],
              everyOneIsWatchingList: [],
            );
          },
          (HotAndNewResp resp) {
            return HotAndNewState(
              isLoading: false,
              hasError: false,
              comingSoonList: resp.results!,
              everyOneIsWatchingList: state.everyOneIsWatchingList,
            );
          },
        );
        emit(newState);
      },
    );

    //get hot and new tv data
    on<LoadDataInEveryoneIsWatching>((event, emit) {});
  }
}

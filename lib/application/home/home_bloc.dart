import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/new_and_hot/hot_and_new_service.dart';
import 'package:netflix_clone/domain/new_and_hot/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.initial()) {
    // on event home screen data
    on<GetHomeScreenData>(
      (event, emit) async {
        // send loading to ui
        emit(
          state.copyWith(isLoading: true, hasError: false),
        );

        // get data
        final _movieresult = await _homeService.getHotAndNewMovieData();
        final _tvresult = await _homeService.getHotAndNewTvData();

        // transform data
        final _movieList = _movieresult.fold(
          (MainFailure failure) {
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaMovieList: [],
              southAsianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResp resp) {
            final pastYear = resp.results;
            final trending = resp.results;
            final tenseDrama = resp.results;
            final southAsian = resp.results;
            pastYear!.shuffle();
            trending!.shuffle();
            tenseDrama!.shuffle();
            southAsian!.shuffle();

            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: pastYear,
              trendingMovieList: trending,
              tenseDramaMovieList: tenseDrama,
              southAsianMovieList: southAsian,
              trendingTvList: state.trendingTvList,
              isLoading: false,
              hasError: false,
            );
          },
        );

        emit(_movieList);

        final _tvList = _tvresult.fold(
          (MainFailure failure) {
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaMovieList: [],
              southAsianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResp resp) {
            final top10 = resp.results;
            top10!.shuffle();

            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tenseDramaMovieList: state.tenseDramaMovieList,
              southAsianMovieList: state.southAsianMovieList,
              trendingTvList: top10,
              isLoading: false,
              hasError: false,
            );
          },
        );

        // send data to ui
        emit(_tvList);
      },
    );
  }
}

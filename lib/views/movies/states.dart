part of 'cubit.dart';

class MoviesStates {}

class GetMoviesInitialState extends MoviesStates {}

class GetMoviesLoadingState extends MoviesStates {}

class GetMoviesSuccessState extends MoviesStates {
  final List<MovieModel> list;

  GetMoviesSuccessState({required this.list});
}

class GetMoviesFailedState extends MoviesStates {
  final String msg;

  GetMoviesFailedState({required this.msg});
}

class GetMoviesFromPaginationLoadingState extends MoviesStates {}

class GetMoviesFromPaginationFailedState extends MoviesStates {
  final String msg;

  GetMoviesFromPaginationFailedState({required this.msg});
}

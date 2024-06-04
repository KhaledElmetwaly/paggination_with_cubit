import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

part 'states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesStates());

  final List<MovieModel> _list = [];

  int pageNumber = 1;
  


  void getData({bool fromLoading = false}) async {
    if (fromLoading) {
      emit(GetMoviesFromPaginationLoadingState());
    } else {
      emit(GetMoviesLoadingState());
    }
    try {
      var response = await Dio().get(
          "https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber");
      var model = MoviesData.fromJson(response.data);
      //الشرط دا بيقولك ان كل مرة بتروح تجيب فيها بيانات يروح يزود البيدج نامبر ١
      // في حالة ان الليست لسه فيها داتا غير كده ميعملش حاجة
      if (model.list.isNotEmpty) {
        pageNumber++;
        _list.addAll(model.list);
      }

      emit(GetMoviesSuccessState(list: _list));
    } on DioException catch (ex) {
      if (fromLoading) {
        emit(GetMoviesFromPaginationFailedState(
            msg: ex.response!.data["status_message"]));
        await Future.delayed(const Duration(seconds: 1));
        emit(GetMoviesInitialState());
      } else {
        emit(GetMoviesFailedState(msg: ex.toString()));
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paggination_youtube/views/movies/cubit.dart';
import 'package:paggination_youtube/views/movies/model.dart';

part 'item.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesCubit cubit = BlocProvider.of(context);
    cubit.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: BlocBuilder(
        bloc: cubit,
        buildWhen: (previous, current) =>
//هنا بنقوله يعمل يجيب الداتا لو هو مش في ولا ستيت من الستيتس دي 
//لو خدت بالك هنا احنا بنقوله ميعملش فيتش في حالة اللودينج عشان ميعملش ريبلد للصفحة من الاول 
//بالنسبة للفيلد بقى دي بتحصل لما يكون وصل لاخر صفحة فا ساعتها المفروض ميعملش بيلد 
//عشان ميظهرش ان في مشكلة لان احنا تجاوزنا عدد الصفحات

            current is! GetMoviesFromPaginationLoadingState &&
            current is! GetMoviesFromPaginationFailedState &&
            current is! GetMoviesInitialState,
        builder: (context, state) {
          print(state);
          if (state is GetMoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMoviesFailedState) {
            return Center(
              child: Text(state.msg),
            );
          } else if (state is GetMoviesSuccessState) {
            //notification listener for pagination بقوله اقعد اسمع عشان يعمل تحديث
            //بعد كل صفحة
            //بيعرف ازاي ؟ عن طريق الscroll controller

            return NotificationListener<ScrollNotification>(
              //بتاخد حاجة اسمها onNotification
              //بياخد قيمة true or false

              onNotification: (notification) {
                if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    notification is ScrollUpdateNotification) {
                  print("loading");
                  MoviesCubit cubit = BlocProvider.of(context);
                  cubit.getData(fromLoading: true);
                }
                return true;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) =>
                    _Item(model: state.list[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: state.list.length,
              ),
            );
          } else {
            return const Text("Un Handled State");
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60,
          child: BlocBuilder<MoviesCubit, MoviesStates>(
            buildWhen: (previous, current) =>
  //هنا بنقوله يبني البروجرس انديكيتور لو في حالة من الحالات الجاية دي 
  //لو لاحظنا هنا ال  
  //الbuildWhen 
  //عكس الbuildWhen
  //الي موجوده فوق على الليسته 
                current is GetMoviesFromPaginationLoadingState ||
                current is GetMoviesInitialState ||
                current is GetMoviesSuccessState ||
                current is GetMoviesFromPaginationFailedState,
            builder: (context, state) {
              if (state is GetMoviesFromPaginationLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetMoviesFromPaginationFailedState) {
                return Center(
                  child: Text(state.msg),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/controller/cubit.dart';
import 'package:news_app_api/controller/states.dart';
import 'package:news_app_api/shared/componants/components.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).science;

        return articleBuilder(list ,context);
      },
    );
  }
}
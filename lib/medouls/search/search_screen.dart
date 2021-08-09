import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/controller/cubit.dart';
import 'package:news_app_api/controller/states.dart';
import 'package:news_app_api/shared/componants/components.dart';

class SearchScreen extends StatelessWidget {
 var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onchange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context , isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}

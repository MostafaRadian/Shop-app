import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';

import '../../Shared/styles/themes.dart';
import '../../logic/Cubits/search/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      searchController,
                      TextInputType.text,
                      (value) => value!.isEmpty ? 'Enter Text to' : null,
                      'Search here...',
                      defaultColor,
                      const Icon(Icons.search),
                      submit: (String text) {
                        SearchCubit.get(context).searchProduct(name: text);
                      },
                    ),
                    const SizedBox(height: 10),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: favoriteBuilder(
                          SearchCubit.get(context).searchModel.data.data,
                          context,
                          isOldPrice: false,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

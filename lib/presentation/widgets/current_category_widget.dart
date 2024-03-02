import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/models/categories_model/category_model.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/utilis/all_text.dart';

class CurrentCategoryWidget extends StatelessWidget {
  final String id;

  const CurrentCategoryWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Future _refresh() async {
      print('refresh working');
      context.read<ItemBloc>().add(TakeCurrentCategoryEvent(id: id));
    }
    return PopScope(
      canPop: true,
      onPopInvoked: (bool isTrue) {
        print(isTrue.toString());
        if (isTrue) {
          context.read<ItemBloc>().add(TakeCategoryEvent());
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Selected Category',
              style: customStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.blue.shade200,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<ItemBloc, ItemState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is ItemLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is CurrentCategoryState) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.categoryModel.name),
                          Text(state.categoryModel.id.toString()),
                        ],
                      ));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

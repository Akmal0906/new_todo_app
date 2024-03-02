import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/presentation/widgets/current_category_widget.dart';

import '../widgets/top_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Future<void> _refresh() async {
    context.read<ItemBloc>().add(TakeCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        children: [
          const TopWidget(),
          BlocConsumer<ItemBloc, ItemState>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              if (state is ItemLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ItemError) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is CategorySate) {
                print(state.categoryModelList.length);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: GridView.builder(
                      itemCount: state.categoryModelList.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 24,
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {

                        return GestureDetector(
                          onTap: () {

                            context.read<ItemBloc>().add(
                                TakeCurrentCategoryEvent(
                                    id: state.categoryModelList[index].id
                                        .toString()));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CurrentCategoryWidget(
                                      id: state.categoryModelList[index].id
                                          .toString(),
                                    )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 11,
                                      offset: Offset(0, 7),
                                      color:
                                          Color.fromRGBO(187, 187, 187, 0.35))
                                ]),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      state.categoryModelList[index].image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black12, width: 2),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/images/default.jpg',
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(state.categoryModelList[index].name),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(state.categoryModelList[index].id
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

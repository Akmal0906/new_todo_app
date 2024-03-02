import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/domain/models/items_model/item_model.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/presentation/view/update_task_screen.dart';
import 'package:todo_app/presentation/widgets/item_widget.dart';
import 'package:todo_app/presentation/widgets/toast_message_wudget.dart';
import 'package:todo_app/presentation/widgets/top_widget.dart';
import 'package:todo_app/utilis/all_text.dart';
import 'package:todo_app/utilis/local_notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refresh() async {
    context.read<ItemBloc>().add(TakeItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            const TopWidget(),
            BlocConsumer<ItemBloc, ItemState>(
              listener: (BuildContext context, Object? state) {
                if (state is ItemSuccfullyDeletedState) {
                  toastFunc(context, state.success, 'assets/icons/correct.svg');
                }
              },
              builder: (BuildContext context, state) {
                if (state is ItemLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ItemLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.itemModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime nowTime = DateTime.now();
                        final DateFormat format = DateFormat('yyyy-MM-dd');
                        final DateFormat format1 =
                            DateFormat('yyyy-MM-dd HH:mm:ss');
                        final alertTime = format1.parse(
                            '${nowTime.year}-${nowTime.month}-${nowTime.day} ${state.itemModelList[index].alert!}');

                        DateTime startTime =
                            format.parse(state.itemModelList[index].endDate!);
                        DateTime endTime =
                            format.parse(state.itemModelList[index].startDate!);
                        if (nowTime.isBefore(endTime) &&
                            nowTime.isAfter(startTime)) {

                          if (nowTime.isBefore(alertTime)) {


                            LocalNotificationService().showScheduledTime(
                                alertTime, state.itemModelList[index]);
                          } else {


                            LocalNotificationService().showScheduledTime(
                                DateTime(nowTime.year,nowTime.month,nowTime.day,nowTime.hour,nowTime.minute+3), state.itemModelList[index]);
                          }
                        } else if (nowTime.isBefore(startTime)) {


                          if (nowTime.isBefore(alertTime)) {


                            LocalNotificationService().showScheduledTime(
                                alertTime, state.itemModelList[index]);
                          } else {


                            LocalNotificationService().showScheduledTime(
                                DateTime(nowTime.year,nowTime.month,nowTime.day,nowTime.hour,nowTime.minute+3), state.itemModelList[index]);
                          }




                        }

                        return Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.3,
                              //This is a percentage of the width
                              children: [
                                Builder(
                                  builder: (context) {
                                    return SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          //Slidable.of(context)!.close();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateScreen(
                                                          itemModel: state
                                                                  .itemModelList[
                                                              index])));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          backgroundColor:
                                              Color.fromRGBO(196, 206, 245, 1),
                                          padding: const EdgeInsets.all(7),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Builder(
                                  builder: (context) {
                                    return SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Slidable.of(context)!.close();
                                          print(
                                              'Tapped index ${state.itemModelList[index].id}');
                                          context.read<ItemBloc>().add(
                                              DeleteIdItemEvent(
                                                  id: state.itemModelList[index]
                                                      .id));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          backgroundColor:
                                              Color.fromRGBO(255, 207, 207, 1),
                                          padding: EdgeInsets.all(7),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                          child: ItemWidget(
                            itemModel: state.itemModelList[index],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ItemInitial || state is ItemEmpty) {
                  return Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/noTask.svg'),
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        AllText.noTask,
                        style: customStyle.copyWith(
                            color: const Color.fromRGBO(85, 78, 143, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      )
                    ],
                  ));
                } else if (state is ItemError) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

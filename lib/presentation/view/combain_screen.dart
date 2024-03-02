import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/presentation/blocs/tasks/task_bloc.dart';
import 'package:todo_app/presentation/view/home_screen.dart';
import 'package:todo_app/presentation/view/task_screen.dart';
import 'package:todo_app/presentation/widgets/toast_message_wudget.dart';
import 'package:todo_app/utilis/all_text.dart';
import '../../data/network/api.dart';

class CombainScreen extends StatefulWidget {
  const CombainScreen({super.key});

  @override
  State<CombainScreen> createState() => _CombainScreenState();
}

class _CombainScreenState extends State<CombainScreen> {
  List<Widget> list = [const HomeScreen(), const TaskScreen()];
  int currentIndex = 0;
  final key = GlobalKey<ScaffoldState>();
  int? tapIndex;
  DateTime dateTime = DateTime.now();
  TextEditingController textEditingController = TextEditingController();

  List<String> timeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: list[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue.shade400,
          unselectedItemColor: Colors.grey.shade600,
          onTap: (index) async {
            if (index == 0) {
              context.read<ItemBloc>().add(TakeItemsEvent());
            } else {
              context.read<ItemBloc>().add(TakeCategoryEvent());
            }
            setState(() {
              currentIndex = index;
            });


          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined), label: 'Task'),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () async {
          context.read<TaskBloc>().add(TaskInitialEvent());
          key.currentState!.showBottomSheet(
            backgroundColor: Colors.grey.shade50,
           elevation: 0,
            shape:
                 RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))),
            (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return ClipPath(
                clipper: MyClipperr(),
                child: Container(
                  height: 400,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.grey.shade50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 44.0),
                        child: Text(
                          AllText.addTaskTitle,
                          style: customStyle.copyWith(
                              color: const Color.fromRGBO(64, 64, 64, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              letterSpacing: 0.36),
                        ),
                      ),
                      TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            hintText: 'Write task',
                            hintStyle:
                                customStyle.copyWith(color: Colors.black)),
                      ),
                      Column(
                        children: [
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            color: Color.fromRGBO(207, 207, 207, 1),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 32,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: groupList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tapIndex = index;
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: tapIndex == index
                                        ? Container(
                                            height: 36,
                                            width: 80,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    30, 209, 2, 1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 6,
                                                    offset: Offset(0, 3),
                                                    color: Color.fromRGBO(
                                                        30, 209, 2, 0.33),
                                                  )
                                                ]),
                                            child: Text(
                                              groupList[index],
                                              style: customStyle.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor: Color(Random()
                                                        .nextInt(0xffffffff))
                                                    .withOpacity(0.9),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                groupList[index],
                                                style: customStyle.copyWith(
                                                    color: const Color.fromRGBO(
                                                        142, 142, 142, 1),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    letterSpacing: 0.46),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            color: Color.fromRGBO(207, 207, 207, 1),
                            thickness: 1,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025))
                                .then((value1) {


                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value2) {
                                setState(() {

                                  timeList.addAll([
                                    '${value1!.year}-${value1.month}-${value1.day}',
                                    ' ${value2!.hour}:${value2.minute}'
                                  ]);
                                });
                              });
                            });
                          },
                          child: Text(
                            timeList.isEmpty
                                ? 'Choose Date'
                                : timeList[0] + timeList[1],
                            style: customStyle.copyWith(
                                color: const Color.fromRGBO(64, 64, 64, 1)),
                          )),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GestureDetector(
                              onTap: () {
                                final DateTime dateTimer = DateTime.now();
                                final DateFormat format =
                                    DateFormat("yyyy-M-d HH:mm:ss");
                                final DateTime time = format.parse(
                                    '${timeList[0]}${timeList[1]}:00'.trim());

                                if (time.isAfter(dateTimer)) {
                                  context.read<TaskBloc>().add(AddTaskEvent(
                                      startTime: timeList[0].trim(),
                                      endTime: '',
                                      clockTime: '${timeList[1].trim()}:00',
                                      task: textEditingController.text));

                                } else {
                                  toastFunc(context, 'Please enter valid date',
                                      'assets/icons/error.svg');

                                }

                                textEditingController.clear();
                                tapIndex = null;
                                timeList.clear();

                              },
                              child: Container(
                                height: 53,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 26),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                          color:
                                              Color.fromRGBO(104, 148, 238, 1))
                                    ],
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromRGBO(126, 182, 255, 1),
                                          Color.fromRGBO(95, 135, 231, 1),
                                        ])),
                                child: Text(
                                  'Add Task',
                                  style: customStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1)),
                                ),
                              ),
                            ),
                            BlocConsumer<TaskBloc, TaskState>(
                              listener:
                                  (BuildContext context, Object? state) {},
                              builder: (BuildContext context, state) {
                                if (state is TaskLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is ErrorTaskState) {
                                  return Center(
                                    child: Text(state.error),
                                  );
                                } else if (state is AddedSuccessTaskState) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.of(context).pop();
                                    toastFunc(context, state.success,
                                        'assets/icons/correct.svg');
                                    context.read<ItemBloc>().add(TakeItemsEvent());
                                  });
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
        child: Container(
          height: 53,
          width: 53,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color.fromRGBO(248, 87, 195, 1),
                Color.fromRGBO(224, 19, 156, 1),
              ]),
              boxShadow: [
                BoxShadow(
                  blurRadius: 9,
                  offset: Offset(0, 9),
                  color: Color.fromRGBO(244, 86, 195, 0.47),
                )
              ]),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class MyClipperr extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 40);
    path.quadraticBezierTo(size.width / 2, -40, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

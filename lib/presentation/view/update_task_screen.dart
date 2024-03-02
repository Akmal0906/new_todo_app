import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/models/items_model/item_model.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/presentation/widgets/toast_message_wudget.dart';
import 'package:todo_app/utilis/all_text.dart';

class UpdateScreen extends StatefulWidget {
  final ItemModel itemModel;

  const UpdateScreen({super.key, required this.itemModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController alertController = TextEditingController();
  List list = [];
  final List<String> testList = ['Task', 'alert', 'start time', 'end time'];

  @override
  void initState() {
    super.initState();
    startController.text = widget.itemModel.startDate ?? '';
    endController.text = widget.itemModel.endDate ?? '';
    taskController.text = widget.itemModel.context;
    alertController.text = widget.itemModel.alert ?? '';
    list.addAll(
        [taskController, alertController, startController, endController]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon:const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Current Update',
            style: customStyle.copyWith(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
                fontSize: 17),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'dsgfsdfkl';
                        }
                        return null;
                      },
                      controller: list[index],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          labelText: testList[index],
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1,
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.yellow, width: 1)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.cyan, width: 1))),
                    ),
                  );
                },
              ),
            ),
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomCenter,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      minimumSize: Size(100, 56),
                      maximumSize: Size(200, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      backgroundColor: Colors.blue,
                      fixedSize: Size(double.infinity, 68)),
                  child: Center(
                    child: Text(
                      'Save',
                      style: customStyle.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1),
                    ),
                  ),
                  onPressed: () {
                    context.read<ItemBloc>().add(UdateItemEvent(
                        itemModel: ItemModel(
                            widget.itemModel.id,
                            taskController.text,
                            startController.text.trim(),
                            endController.text.trim(),
                            widget.itemModel.createdAt,
                            widget.itemModel.category,
                            alertController.text.trim())));
                  },
                ),
                BlocConsumer<ItemBloc, ItemState>(
                  listener: (BuildContext context, Object? state) {
                    if (state is UpdateItemSuccessState) {
                      toastFunc(
                          context, state.success, 'assets/icons/correct.svg');
                      Navigator.of(context).pop();
                    } else if (state is ItemError) {
                      toastFunc(context, state.error, 'assets/icons/error.svg');
                    }
                  },
                  builder: (BuildContext context, state) {
                    if (state is ItemLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UpdateItemSuccessState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pop();
                        toastFunc(
                            context, state.success, 'assets/icons/correct.svg');
                      });
                    } else if (state is ItemError) {}
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}

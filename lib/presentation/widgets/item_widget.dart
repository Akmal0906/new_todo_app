import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/domain/models/items_model/item_model.dart';
import 'package:todo_app/utilis/all_text.dart';
import 'package:todo_app/utilis/local_notification.dart';

class ItemWidget extends StatelessWidget {

  final ItemModel itemModel;

  const ItemWidget({super.key,required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 9,
              offset: Offset(0, 4),
              color: Color.fromRGBO(0, 0, 0, 0.05),
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                width: 4,
                height: 56,
                color: Color(Random().nextInt(0xffffffff)).withOpacity(0.9),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.circle_outlined,
                    color: Color.fromRGBO(181, 181, 181, 1),
                  )),
              Text(
                itemModel.alert.toString(),
                style: customStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: const Color.fromRGBO(198, 198, 200, 1)),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                itemModel.context,
                style: customStyle.copyWith(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    fontWeight: FontWeight.w400),
                overflow: TextOverflow.fade,
              ),
            ],
          )),
          IconButton(
              onPressed: () async{
                LocalNotificationService().cancelIdNotific(itemModel.id);

                print('Pressed button');
              },
              icon: const Icon(
                Icons.notifications,
                color: Color.fromRGBO(217, 217, 217, 1),
              )),
        ],
      ),
    );
  }
}

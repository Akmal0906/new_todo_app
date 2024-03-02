import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilis/all_text.dart';
import '../view/home_screen.dart';
class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.3,
      width: size.width,
      padding: const EdgeInsets.only(bottom: 13),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(129, 199, 245, 1),
            Color.fromRGBO(56, 103, 213, 1),
          ])),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 12,
                  top: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello brenda',
                        style: customStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Today you have 9 tasks',
                        style: customStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 16,
                  top: 55,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/din.jpg',
                    ),
                    radius: 22,
                  ),
                ),
                Positioned(
                  left: -70,
                  top: -(size.height * 0.3)*0.42,
                  child: Container(
                    height: 211,
                    width: 211,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white38,
                    ),
                  ),
                ),
                Positioned(
                  top: -25,
                  right: -25,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white38,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 16, top: 9, right: 11),
            alignment: Alignment.bottomCenter,
            width: size.width,
            margin: const EdgeInsets.only(left: 18, right: 18),
            decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today Reminder',
                      style: customStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Meeting with client',
                      style: customStyle.copyWith(
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '13.00 PM',
                      style: customStyle.copyWith(
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    SvgPicture.asset(
                      'assets/icons/ring.svg',
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

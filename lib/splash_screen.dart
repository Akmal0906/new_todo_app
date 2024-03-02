import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data/network/api.dart';
import 'package:todo_app/presentation/view/combain_screen.dart';
import 'package:todo_app/presentation/widgets/toast_message_wudget.dart';
import 'package:todo_app/utilis/all_colors.dart';
import 'package:todo_app/utilis/all_text.dart';
import 'package:todo_app/utilis/local_notification.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();

    DateTime time=DateTime.now();
print(time.toString());
    return SafeArea(
      child: Scaffold(
        key: key,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/images/splash.svg',
                      fit: BoxFit.cover,
                    ),
                    Text(
                      AllText.splashText1,
                      style: customStyle.copyWith(
                          color: const Color.fromRGBO(85, 78, 143, 1),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => const CombainScreen()), (
                    route) => false);
             // await FetchData().postToDo('2024:2:29', '2027-09-04', '06:00:00', 'learn flutter');
               //toastFunc(context);



              },
              child: Container(
                margin: const EdgeInsets.only(left: 62, right: 52),
                height: 56,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 30,
                          offset: Offset(0, 5),
                          color: Color.fromRGBO(102, 200, 28, 0.53))
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AllColors.splashColor1,
                          AllColors.splashColor2,
                        ])),
                child: Text(
                  AllText.splashText2,
                  style: customStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 92,
            ),
          ],
        ),
      ),
    );
  }
}

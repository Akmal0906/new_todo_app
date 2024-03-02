import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utilis/all_text.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Press me'),
          onPressed: () {

          },
        ),
      ),
    );
  }
}

void toastFunc(context,String text,String url){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
    clipBehavior: Clip.none,
    dismissDirection: DismissDirection.up,
    duration: const Duration(seconds: 1),
    //margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height-200),
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oh snap',
                      style: customStyle.copyWith(
                          color: Colors.white, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      text,
                      style: customStyle.copyWith(
                          color: Colors.white, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -20,
            child: SvgPicture.asset(url,height: 64,width: 48,color: Colors.yellow,))
      ],
    ),



  ));
}

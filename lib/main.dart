import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/network/api.dart';
import 'package:todo_app/presentation/blocs/items/item_bloc.dart';
import 'package:todo_app/presentation/blocs/tasks/task_bloc.dart';
import 'package:todo_app/presentation/view/update_task_screen.dart';
import 'package:todo_app/presentation/widgets/toast_message_wudget.dart';
import 'package:todo_app/splash_screen.dart';
import 'package:todo_app/utilis/local_notification.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await LocalNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ItemBloc(fetchData: FetchData())..add(TakeItemsEvent())),
        BlocProvider(create: (context)=>TaskBloc(fetchData: FetchData()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

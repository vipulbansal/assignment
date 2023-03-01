import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vipul_assignment/home/home_bloc/home_bloc.dart';
import 'package:vipul_assignment/home/home_bloc/home_events.dart';
import 'package:vipul_assignment/home/home_bloc/home_states.dart';
import 'package:vipul_assignment/home/home_view/home_view.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vipul Bansal Assignment',
      scaffoldMessengerKey: messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(Loading())..add(GetUsersEvent(context)),
        child: HomeView(),
      ),
    );
  }
}

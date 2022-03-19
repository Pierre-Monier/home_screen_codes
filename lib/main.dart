import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/core/color/app_color.dart';
import 'package:home_screen_codes/page/home/home_view.dart';
import 'package:home_screen_codes/service_locator.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        Provider<CodesBloc>(create: (_) => CodesBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: AppColor.baseColor,
        brightness: Brightness.dark,
      ),
      home: const HomeView(),
    );
  }
}

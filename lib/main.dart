import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/core/color/app_color.dart';
import 'package:home_screen_codes/page/home/home_view.dart';
import 'package:home_screen_codes/page/loading/loading_view.dart';
import 'package:home_screen_codes/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: [
        CodesBloc(),
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
      initialRoute: HomeView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const HomeView(),
      );
    case LoadingView.routeName:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const LoadingView(),
      );
    default:
      return null;
  }
}

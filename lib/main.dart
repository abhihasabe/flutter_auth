import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs_diamond/core/manager/route_manager.dart';
import 'package:gs_diamond/core/theme/app_theme.dart';
import 'package:gs_diamond/features/authentication/presentation/screen/login_screen.dart';
import 'package:gs_diamond/di/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'features/authentication/presentation/bloc_cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init().whenComplete(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GS Diamond',
      theme: AppThemes.lightTheme,
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => di.locator<LoginCubit>())
      ],child: MaterialApp.router(
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routeInformationParser: VxInformationParser(),
        routerDelegate: Routes.routerDelegate,
      )),
    );
  }
}

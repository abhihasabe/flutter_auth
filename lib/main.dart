import 'features/authentication/presentation/bloc_cubit/authentication_cubit.dart';
import 'package:gs_diamond/core/manager/route_manager.dart';
import 'package:gs_diamond/core/theme/app_theme.dart';
import 'package:gs_diamond/di/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.locator<AuthenticationCubit>())
        ],
        child: MaterialApp.router(
          title: 'GS Diamond',
          theme: AppThemes.lightTheme,
          debugShowCheckedModeBanner: false,
          routeInformationParser: VxInformationParser(),
          routerDelegate: Routes.routerDelegate,
        ));
  }
}

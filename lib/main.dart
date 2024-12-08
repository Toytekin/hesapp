import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/constant/route.dart';
import 'package:hesapp/constant/theme.dart';
import 'package:hesapp/cubit/borc_cubit.dart';
import 'package:hesapp/cubit/date_picker_cubit.dart';
import 'package:hesapp/cubit/theme.dart';
import 'package:hesapp/cubit/user_add_cubit.dart';
import 'package:hesapp/service/hive_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive'i başlat
  await HiveSetup.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => BorcCubit()),
        BlocProvider(create: (context) => UserAddCubit()),
        BlocProvider(
          create: (context) => CubitDatePicker(),
        )
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state ? AppTheme.lightTheme : AppTheme.darkTheme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}

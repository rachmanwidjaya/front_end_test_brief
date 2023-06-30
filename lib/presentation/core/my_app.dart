import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/resources/app_theme.dart';
import '../../data/repository_impl/local_config.dart';
import '../../data/repository_impl/remote_config/dummy_remote_config_repository_impl.dart';
import '../bloc/core_bloc.dart';
import '../bloc/wss_bloc.dart';
import '../modules/menu/presentation/main_menu_page.dart';
import 'app_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoreBloc>(
          create: (_) => CoreBloc(
            remoteConfig: DumyRemoteConfigRepositoryImpl.instance,
          )..init(),
        ),
        BlocProvider<WssBloc>(
          create: (_) => WssBloc()..load(),
        ),
      ],
      child: BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Front End Test Brief',
            home: const MainMenu(),
            theme: LocalConfig.instance.darkTheme
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            builder: (context, child) => AppView(
              state: state,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

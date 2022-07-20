import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/todo_layout.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(
    isDark: isDark,
  ));
}


class MyApp extends StatelessWidget {
  final bool ?isDark;
const MyApp({
    Key? key, this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              ),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark!
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: HomeLayout(),
            );
          },
        ));
  }
}
import 'package:devti_agro/core/config/theme/theme.dart';
import 'package:devti_agro/core/router/router.dart';
import 'package:devti_agro/features/Checklist/presontation/bloc/check_list_bloc.dart';
import 'package:devti_agro/features/Etiquetage/presontation/bloc/etiquetage_bloc.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/bloc/tracabilte_bloc.dart';
import 'package:devti_agro/features/overview/presontaion/bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/chambre/presontaion/bloc/chambres_bloc.dart';
import 'injection_conatiner.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> di.sl<ChambresBloc>()..add(GetAllChambresEvent())),
        BlocProvider(create: (_)=> di.sl<TasksBloc>()..add(GetAllTasksEvent())),
        BlocProvider(create: (_)=> di.sl<EtiquetageBloc>()..add(GetAllEtiquetageEvent())),
        BlocProvider(create: (_)=> di.sl<TracabilteBloc>()..add(GetAllTracabiliteEvent())),
        BlocProvider(create: (_)=> di.sl<CheckListBloc>()..add(GetAllCheckListEvent())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // Adjust this to your design's dimensions
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: AppTheme.light,
          );
        },
      ),
    );
  }
}

import 'package:devti_agro/features/Checklist/application/datasource/checkList_remote_data_source.dart';
import 'package:devti_agro/features/Checklist/application/repositories/check_list_repositories_implement.dart';
import 'package:devti_agro/features/Checklist/domain/repositories/check_list_repositories.dart';
import 'package:devti_agro/features/Checklist/domain/use_cases/get_all_check_list_use_case.dart';
import 'package:devti_agro/features/Checklist/domain/use_cases/get_check_list_by_date_use_case.dart';
import 'package:devti_agro/features/Checklist/presontation/bloc/check_list_bloc.dart';
import 'package:devti_agro/features/Etiquetage/aplication/datasource/etiquetage_remote_data_source.dart';
import 'package:devti_agro/features/Etiquetage/aplication/repositories/etiquetage_ropsitories_implement.dart';
import 'package:devti_agro/features/Etiquetage/domain/repositories/etiquetage_repositories.dart';
import 'package:devti_agro/features/Etiquetage/domain/useCase/get_all_etiquetage_use_case.dart';
import 'package:devti_agro/features/Etiquetage/domain/useCase/get_etiquetage_use_case.dart';
import 'package:devti_agro/features/Etiquetage/presontation/bloc/etiquetage_bloc.dart';
import 'package:devti_agro/features/Tracbalite/application/datasource/tracabilite_remote_data_source.dart';
import 'package:devti_agro/features/Tracbalite/application/repositories/Tracabilte_repositories_implement.dart';
import 'package:devti_agro/features/Tracbalite/domain/repositories/tracabilite_repositories.dart';
import 'package:devti_agro/features/Tracbalite/domain/useCase/get_all_tracabilte_use_case.dart';
import 'package:devti_agro/features/Tracbalite/domain/useCase/get_tracabilte_by_date.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/bloc/tracabilte_bloc.dart';
import 'package:devti_agro/features/chambre/application/datasource/chambre_remote_data_source.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/chambre/application/repositories/chambre_repository_implement.dart';
import 'package:devti_agro/features/chambre/domain/repositories/chambre_repositories.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/GetChambresByDateRangeUseCase.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/get_all_chambre.dart';
import 'package:devti_agro/features/overview/aplication/datasource/tasks_remote_data_source.dart';
import 'package:devti_agro/features/overview/aplication/repositories/tasks_repository_implement.dart';
import 'package:devti_agro/features/overview/domain/repositories/tasks_repositories.dart';
import 'package:devti_agro/features/overview/domain/use_case/get_all_tasks.dart';
import 'package:devti_agro/features/overview/presontaion/bloc/tasks_bloc.dart';
import 'package:get_it/get_it.dart';
import 'Package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/chambre/presontaion/bloc/chambres_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {


  // Bloc _________________________________________________________________________________

  sl.registerFactory(() => ChambresBloc(getAllChambres: sl(),getChambresByDateRange: sl(),));
  sl.registerFactory(() => TasksBloc(getAllTasks: sl()));
  sl.registerFactory(()=> EtiquetageBloc(getAllEtiquetageUseCase: sl() ,getEtiquetageByDateUseCase: sl()));
  sl.registerFactory(()=> TracabilteBloc(getAllTracabilteUseCase: sl() , getTracabiliteByDateUseCase: sl()));
  sl.registerFactory(()=> CheckListBloc(getAllCheckListUseCase: sl() , getCheckListByDateUseCase: sl()));

  // Use Cases ____________________________________________________________________________


            /* chambre */

  sl.registerLazySingleton(() => GetAllChambresUseCase(sl()));
  sl.registerLazySingleton(() => GetChambresByDateRangeUseCase(sl()));


            /* tasks */

  sl.registerLazySingleton(()=> GetAllTasksUseCase(tasksRepositories: sl()));

            /* Etiquetage */

  sl.registerLazySingleton(() => GetAllEtiquetageUseCase(etiquetageRepositories: sl()));
  sl.registerLazySingleton(() => GetEtiquetageByDateUseCase(repositories: sl()));

            /* Tracabilte */

  sl.registerLazySingleton(() => GetAllTracabilteUseCase(tracabiliteRepositories: sl()));
  sl.registerLazySingleton(() => GetTracabiliteByDateUseCase(repositories: sl()));

            /* checkList */

  sl.registerLazySingleton(() => GetAllCheckListUseCase(checkListRepositories: sl()));
  sl.registerLazySingleton(() => GetCheckListByDateUseCase(repositories: sl()));



  // Repository ____________________________________________________________________________________________________

  sl.registerLazySingleton<ChambresRepository>(() => ChambreRepositoryImplement(chambreRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TasksRepositories>( () => TasksRepositoryImplement(tasksRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<EtiquetageRepositories>(()=> EtiquetageRopsitoriesImplement(etiquetageRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TracabiliteRepositories>(()=> TracabilteRepositoriesImplement(tracabiliteRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CheckListRepositories>(()=> CheckListRepositoriesImplement(checklistRemoteDataSource: sl(), networkInfo: sl()));

  // Data Sources ___________________________________________________________________________________________________________

  sl.registerLazySingleton<ChambreRemoteDataSource>(
      () => ChambreRemoteDataSourceImplement(client: sl()));

  sl.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImplement(client: sl())
  );

  sl.registerLazySingleton<EtiquetageRemoteDataSource>(
      () => EtiquetageRemoteDataSourceImplement(client: sl())
  );

  sl.registerLazySingleton<TracabiliteRemoteDataSource>(
          () => TracabiliteRemoteDataSourceImplements(client: sl())
  );

  sl.registerLazySingleton<ChecklistRemoteDataSource>(
          () => ChecklistRemoteDataSourceImplement(client: sl())
  );

  //! Core ____________________________________________________________________________________________________________

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  //! External
  // Register any external dependencies such as HttpClient, SharedPreferences, etc.

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

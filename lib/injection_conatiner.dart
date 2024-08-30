import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/router/bloc/auth_bloc.dart';
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
import 'package:devti_agro/features/auth/login/infrastructure/dataSource/login_remote_data_source.dart';
import 'package:devti_agro/features/auth/login/infrastructure/repositories/login_repo_implement.dart';
import 'package:devti_agro/features/auth/login/domain/repositories/login_repo.dart';
import 'package:devti_agro/features/auth/login/aplication/useCase/login_usse_case.dart';
import 'package:devti_agro/features/auth/login/aplication/bloc/login_bloc.dart';
import 'package:devti_agro/features/auth/register/application/datasource/register_remote_data_source.dart';
import 'package:devti_agro/features/auth/register/application/repositories/register_repo_impl.dart';
import 'package:devti_agro/features/auth/register/domain/repositories/register_repo.dart';
import 'package:devti_agro/features/auth/register/domain/usecase/register_use_case.dart';
import 'package:devti_agro/features/auth/register/presontaion/bloc/register_bloc.dart';
import 'package:devti_agro/features/chambre/application/datasource/chambre_remote_data_source.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/chambre/application/repositories/chambre_repository_implement.dart';
import 'package:devti_agro/features/chambre/domain/repositories/chambre_repositories.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/GetChambresByDateRangeUseCase.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/add_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/get_all_chambre.dart';
import 'package:devti_agro/features/chambre/presontaion/bloc/create_chambre_bloc/add_chambre_bloc.dart';
import 'package:devti_agro/features/nutrition/application/datasource/nutrition_remote_data_source.dart';
import 'package:devti_agro/features/nutrition/application/repositories/nutrition_repositories_implement.dart';
import 'package:devti_agro/features/nutrition/domain/repositories/nutiration_repositories.dart';
import 'package:devti_agro/features/nutrition/domain/useCase/get_all_nutiration_use_case.dart';
import 'package:devti_agro/features/nutrition/presentaion/bloc/nutrition_bloc.dart';
import 'package:devti_agro/features/overview/aplication/datasource/tasks_remote_data_source.dart';
import 'package:devti_agro/features/overview/aplication/repositories/tasks_repository_implement.dart';
import 'package:devti_agro/features/overview/domain/repositories/tasks_repositories.dart';
import 'package:devti_agro/features/overview/domain/use_case/get_all_tasks.dart';
import 'package:devti_agro/features/overview/presontaion/bloc/tasks_bloc.dart';
import 'package:devti_agro/features/role/aplication/bloc/add_role_bloc/bloc/role_bloc.dart';
import 'package:devti_agro/features/role/aplication/usecase/role_use_case.dart';
import 'package:devti_agro/features/role/domain/repositories/role_repo.dart';
import 'package:devti_agro/features/role/infrastructure/data/role_remote_data_source.dart';
import 'package:devti_agro/features/role/infrastructure/ropositories/role_repo_implement.dart';
import 'package:devti_agro/features/zone/aplication/bloc/zone/bloc/zone_bloc.dart';
import 'package:devti_agro/features/zone/aplication/usecase/zone_use_case.dart';
import 'package:devti_agro/features/zone/domain/repositories/zone_repo.dart';
import 'package:devti_agro/features/zone/infrastructure/data/zone_remote_data_source.dart';
import 'package:devti_agro/features/zone/infrastructure/ropositories/zone_repo_implement.dart';
import 'package:get_it/get_it.dart';
import 'Package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chambre/presontaion/bloc/get_chambres_bloc/chambres_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? false;
  // Bloc _________________________________________________________________________________

  sl.registerFactory(() => ChambresBloc(
        getAllChambres: sl(),
        getChambresByDateRange: sl(),
      ));
  sl.registerFactory(() => TasksBloc(getAllTasks: sl()));
  sl.registerFactory(() => EtiquetageBloc(getAllEtiquetageUseCase: sl(), getEtiquetageByDateUseCase: sl()));
  sl.registerFactory(() => TracabilteBloc(getAllTracabilteUseCase: sl(), getTracabiliteByDateUseCase: sl()));
  sl.registerFactory(() => NutritionBloc(getAllNutirationUseCase: sl()));
  sl.registerFactory(() => CheckListBloc(getAllCheckListUseCase: sl(), getCheckListByDateUseCase: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
  sl.registerFactory(() => AddChambreBloc(addChambreUseCase: sl()));
  sl.registerFactory(() => ZoneBloc(zoneUseCase: sl()));
  sl.registerFactory(() => RoleBloc(roleUseCase: sl()));

  // Add the ThemeBloc registration
  sl.registerFactory(() => ThemeBloc(isDark));
  sl.registerFactory(() => AuthBloc());

  // Use Cases ____________________________________________________________________________

  /* chambre */

  sl.registerLazySingleton(() => GetAllChambresUseCase(sl()));
  sl.registerLazySingleton(() => GetChambresByDateRangeUseCase(sl()));
  sl.registerLazySingleton(() => AddChambreUseCase(chambresRepository: sl()));

  /* tasks */

  sl.registerLazySingleton(() => GetAllTasksUseCase(tasksRepositories: sl()));

  /* Etiquetage */

  sl.registerLazySingleton(() => GetAllEtiquetageUseCase(etiquetageRepositories: sl()));
  sl.registerLazySingleton(() => GetEtiquetageByDateUseCase(repositories: sl()));

  /* Tracabilte */

  sl.registerLazySingleton(() => GetAllTracabilteUseCase(tracabiliteRepositories: sl()));
  sl.registerLazySingleton(() => GetTracabiliteByDateUseCase(repositories: sl()));

  /* Nutrition */
  sl.registerLazySingleton(() => GetAllNutirationUseCase(nutirationRepositories: sl()));

  /* checkList */

  sl.registerLazySingleton(() => GetAllCheckListUseCase(checkListRepositories: sl()));
  sl.registerLazySingleton(() => GetCheckListByDateUseCase(repositories: sl()));
  /* AUTH */

  sl.registerLazySingleton(() => LoginUseCase(loginRepo: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(registerRepo: sl()));

  /* ZONE */

  sl.registerLazySingleton(() => GetZonesByEntrepriseUseCase(zoneRepo: sl()));

  /* ROLE */

  sl.registerLazySingleton(() => RoleUseCase(roleRepo: sl()));

  /*____________________________________ Repository ____________________________________*/

  /* chambre */
  sl.registerLazySingleton<ChambresRepository>(() => ChambreRepositoryImplement(chambreRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TasksRepositories>(() => TasksRepositoryImplement(tasksRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<EtiquetageRepositories>(() => EtiquetageRopsitoriesImplement(etiquetageRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TracabiliteRepositories>(() => TracabilteRepositoriesImplement(tracabiliteRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CheckListRepositories>(() => CheckListRepositoriesImplement(checklistRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImplement(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepoImpl(networkInfo: sl(), registerRemoteDataSource: sl()));
  sl.registerLazySingleton<ZoneRepo>(() => ZoneRepoImplement(networkInfo: sl(), zoneRemoteDataSource: sl()));

/* ROLE */

  sl.registerLazySingleton<RoleRepo>(() => RoleRepoImplement(networkInfo: sl(), roleRemoteDataSource: sl()));

  /* Nutrition */
  sl.registerLazySingleton<NutirationRepositories>(() => NutritionRepositoriesImplement(nutritionRemoteDataSource: sl(), networkInfo: sl()));

  /*______________________________________ Data Sources ___________________________________*/

  sl.registerLazySingleton<ChambreRemoteDataSource>(() => ChambreRemoteDataSourceImplement(client: sl()));

  sl.registerLazySingleton<TasksRemoteDataSource>(() => TasksRemoteDataSourceImplement(client: sl()));

  sl.registerLazySingleton<EtiquetageRemoteDataSource>(() => EtiquetageRemoteDataSourceImplement(client: sl()));

  sl.registerLazySingleton<TracabiliteRemoteDataSource>(() => TracabiliteRemoteDataSourceImplements(client: sl()));

  sl.registerLazySingleton<NutritionRemoteDataSource>(() => NutritionRemoteDataSourceImplements(client: sl()));

  sl.registerLazySingleton<ChecklistRemoteDataSource>(() => ChecklistRemoteDataSourceImplement(client: sl()));

  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RegisterRemoteDataSource>(() => RegisterRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ZoneRemoteDataSource>(() => ZoneRemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<RoleRemoteDataSource>(() => RoleRemoteDataSourceImplement(client: sl()));

  //! Core ____________________________________________________________________________________________________________

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  //! External
  // Register any external dependencies such as HttpClient, SharedPreferences, etc.

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

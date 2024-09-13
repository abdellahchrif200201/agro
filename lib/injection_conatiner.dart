import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/lang/bloc/language_bloc.dart';
import 'package:devti_agro/core/router/bloc/auth_bloc.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/add_tache_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/delete_tache_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/update_check_list_use_case.dart';
import 'package:devti_agro/features/Checklist/infrastructure/datasource/checkList_remote_data_source.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/get_all_check_list_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/get_check_list_by_date_use_case.dart';
import 'package:devti_agro/features/Checklist/application/bloc/get_all_check_list/check_list_bloc.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories_implement.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/datasource/etiquetage_remote_data_source.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/repositories/etiquetage_ropsitories_implement.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/repositories/etiquetage_repositories.dart';
import 'package:devti_agro/features/Etiquetage/aplication/useCase/get_all_etiquetage_use_case.dart';
import 'package:devti_agro/features/Etiquetage/aplication/useCase/get_etiquetage_use_case.dart';
import 'package:devti_agro/features/Etiquetage/aplication/bloc/etiquetage_bloc.dart';
import 'package:devti_agro/features/Fournisseur/aplication/bloc/add_role_bloc/bloc/Fournisseur_bloc.dart';
import 'package:devti_agro/features/Fournisseur/aplication/usecase/Fournisseur_use_case.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/data/fournisseur_remote_data_source.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/ropositories/fournisseur_repo.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/ropositories/fournisseur_repo_implement.dart';
import 'package:devti_agro/features/Tracbalite/infrastructure/datasource/tracabilite_remote_data_source.dart';
import 'package:devti_agro/features/Tracbalite/infrastructure/repositories/Tracabilte_repositories_implement.dart';
import 'package:devti_agro/features/Tracbalite/infrastructure/repositories/tracabilite_repositories.dart';
import 'package:devti_agro/features/Tracbalite/application/useCase/get_all_tracabilte_use_case.dart';
import 'package:devti_agro/features/Tracbalite/application/useCase/get_tracabilte_by_date.dart';
import 'package:devti_agro/features/Tracbalite/application/bloc/tracabilte_bloc.dart';
import 'package:devti_agro/features/auth/login/infrastructure/dataSource/login_remote_data_source.dart';
import 'package:devti_agro/features/auth/login/infrastructure/repositories/login_repo_implement.dart';
import 'package:devti_agro/features/auth/login/infrastructure/repositories/login_repo.dart';
import 'package:devti_agro/features/auth/login/aplication/useCase/login_usse_case.dart';
import 'package:devti_agro/features/auth/login/aplication/bloc/login_bloc.dart';
import 'package:devti_agro/features/auth/register/infrastructure/datasource/register_remote_data_source.dart';
import 'package:devti_agro/features/auth/register/infrastructure/repositories/register_repo_impl.dart';
import 'package:devti_agro/features/auth/register/infrastructure/repositories/register_repo.dart';
import 'package:devti_agro/features/auth/register/application/usecase/register_use_case.dart';
import 'package:devti_agro/features/auth/register/application/bloc/register_bloc.dart';
import 'package:devti_agro/features/chambre/application/bloc/delete_update_chambre/delete_update_chambre_bloc.dart';
import 'package:devti_agro/features/chambre/application/use_cases/delete_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/application/use_cases/update_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/infrastructure/datasource/chambre_remote_data_source.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repository_implement.dart';
import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repositories.dart';
import 'package:devti_agro/features/chambre/application/use_cases/GetChambresByDateRangeUseCase.dart';
import 'package:devti_agro/features/chambre/application/use_cases/add_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/application/use_cases/get_all_chambre.dart';
import 'package:devti_agro/features/chambre/application/bloc/create_chambre_bloc/add_chambre_bloc.dart';
import 'package:devti_agro/features/nutrition/infrastructure/datasource/nutrition_remote_data_source.dart';
import 'package:devti_agro/features/nutrition/infrastructure/repositories/nutrition_repositories_implement.dart';
import 'package:devti_agro/features/nutrition/infrastructure/repositories/nutiration_repositories.dart';
import 'package:devti_agro/features/nutrition/application/useCase/get_all_nutiration_use_case.dart';
import 'package:devti_agro/features/nutrition/application/bloc/nutrition_bloc.dart';
import 'package:devti_agro/features/overview/infrastructure/datasource/tasks_remote_data_source.dart';
import 'package:devti_agro/features/overview/infrastructure/repositories/tasks_repository_implement.dart';
import 'package:devti_agro/features/overview/infrastructure/repositories/tasks_repositories.dart';
import 'package:devti_agro/features/overview/aplication/use_case/get_all_tasks.dart';
import 'package:devti_agro/features/overview/aplication/bloc/tasks_bloc.dart';
import 'package:devti_agro/features/permission/aplication/bloc/add_role_bloc/bloc/permission_bloc.dart';
import 'package:devti_agro/features/permission/aplication/usecase/Permission_use_case.dart';
import 'package:devti_agro/features/permission/infrastructure/data/Permission_remote_data_source.dart';
import 'package:devti_agro/features/permission/infrastructure/ropositories/Permission_repo_implement.dart';
import 'package:devti_agro/features/permission/infrastructure/ropositories/permission_repo.dart';
import 'package:devti_agro/features/role/aplication/bloc/add_role_bloc/bloc/role_bloc.dart';
import 'package:devti_agro/features/role/aplication/usecase/role_use_case.dart';
import 'package:devti_agro/features/role/infrastructure/ropositories/role_repo.dart';
import 'package:devti_agro/features/role/infrastructure/data/role_remote_data_source.dart';
import 'package:devti_agro/features/role/infrastructure/ropositories/role_repo_implement.dart';
import 'package:devti_agro/features/user/aplication/bloc/bloc/show_user_bloc.dart';
import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/features/user/aplication/usecase/add_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/delete_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/show_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/update_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/user_use_case.dart';
import 'package:devti_agro/features/user/infrastructure/data/user_remote_data_source.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo_implement.dart';
import 'package:devti_agro/features/zone/aplication/bloc/zone/bloc/zone_bloc.dart';
import 'package:devti_agro/features/zone/aplication/usecase/zone_use_case.dart';
import 'package:devti_agro/features/zone/infrastructure/ropositories/zone_repo.dart';
import 'package:devti_agro/features/zone/infrastructure/data/zone_remote_data_source.dart';
import 'package:devti_agro/features/zone/infrastructure/ropositories/zone_repo_implement.dart';
import 'package:get_it/get_it.dart';
import 'Package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //================================= Bloc ==================================


  
            /* chambre blocs */
  sl.registerFactory(() => ChambresBloc(getAllChambres: sl(),getChambresByDateRange: sl(),));
  sl.registerFactory(() => AddChambreBloc(addChambreUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateChambreBloc(deleteChambreUseCase: sl() , updateChambreUseCase: sl()));

  sl.registerFactory(() => TasksBloc(getAllTasks: sl()));
  sl.registerFactory(() => AddDeleteUpdateTacheBloc(addTache: sl(), deleteTache: sl() ,updateTache: sl()));

  sl.registerFactory(() => EtiquetageBloc(getAllEtiquetageUseCase: sl(), getEtiquetageByDateUseCase: sl()));
  sl.registerFactory(() => TracabilteBloc(getAllTracabilteUseCase: sl(), getTracabiliteByDateUseCase: sl()));
  sl.registerFactory(() => NutritionBloc(getAllNutirationUseCase: sl()));
  sl.registerFactory(() => CheckListBloc(getAllCheckListUseCase: sl(), getCheckListByDateUseCase: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));

  sl.registerFactory(() => ZoneBloc(zoneUseCase: sl()));
  sl.registerFactory(() => RoleBloc(roleUseCase: sl()));

  /*  user  */
  sl.registerFactory(() => UserBloc(userUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateUserBloc(deleteUser: sl(), addUser: sl() ,updateUser: sl()));

  sl.registerFactory(() => PermissionBloc(permissionUseCase: sl()));
  sl.registerFactory(() => FournisseurBloc(fournisseurUseCase: sl()));

  sl.registerFactory(() => ShowUserBloc(showUserUseCase: sl()));

  // Add the ThemeBloc registration
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => AuthBloc());

  sl.registerFactory(()=> LanguageBloc());

  // Use Cases ____________________________________________________________________________

  /* chambre */

  sl.registerLazySingleton(() => GetAllChambresUseCase(sl()));
  sl.registerLazySingleton(() => GetChambresByDateRangeUseCase(sl()));
  sl.registerLazySingleton(() => AddChambreUseCase(chambresRepository: sl()));
  sl.registerLazySingleton(() => DeleteChambreUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateChambreUseCase(repository: sl()));

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
  sl.registerLazySingleton(() => AddTacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTacheUsecase(repository: sl()));
  /* AUTH */

  sl.registerLazySingleton(() => LoginUseCase(loginRepo: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(registerRepo: sl()));

  /* ZONE */

  sl.registerLazySingleton(() => GetZonesByEntrepriseUseCase(zoneRepo: sl()));

  /* Fournisseur */

  sl.registerLazySingleton(() => FournisseurUseCase(fournisseurRepo: sl()));

  /* ROLE */

  sl.registerLazySingleton(() => RoleUseCase(roleRepo: sl()));

  /* Permission */

  sl.registerLazySingleton(() => PermissionUseCase(permissionRepo: sl()));

  /* User */

  sl.registerLazySingleton(() => UserUseCase(userRepo: sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(userRepo: sl()));
  sl.registerLazySingleton(() => AddUserUseCase(userRepo: sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(userRepo: sl()));
  sl.registerLazySingleton(() => ShowUserUseCase(userRepo: sl()));

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
  sl.registerLazySingleton<UserRepo>(() => UserRepoImplement(networkInfo: sl(), userRemoteDataSource: sl()));
  sl.registerLazySingleton<PermissionRepo>(() => PermissionRepoImplement(networkInfo: sl(), permissionRemoteDataSource: sl()));
  sl.registerLazySingleton<FournisseurRepo>(() => FournisseurRepoImplement(networkInfo: sl(), fournisseurRemoteDataSource: sl()));

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
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<PermissionRemoteDataSource>(() => PermissionRemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<FournisseurRemoteDataSource>(() => FournisseurRemoteDataSourceImplement(client: sl()));

  //! Core ____________________________________________________________________________________________________________

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  //! External
  // Register any external dependencies such as HttpClient, SharedPreferences, etc.

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

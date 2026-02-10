import 'package:chat_app_fe/app/core/auth/authservice.dart';
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/dio_instance.dart';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_manager.dart';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/datasource/signup/signup_data_source.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/repositories/signup/sign_up_repositories_impl.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/service/signup/signup_service.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/repositories/signup/sign_up_repositories.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/usecases/signup/signup_usecase.dart';
import 'package:chat_app_fe/app/view/features/Home/data/datasource/home_datasource.dart';
import 'package:chat_app_fe/app/view/features/Home/data/repositories/home_repositories_impl.dart';
import 'package:chat_app_fe/app/view/features/Home/data/repositories/home_socket_repository_impl.dart';
import 'package:chat_app_fe/app/view/features/Home/data/service/home_service.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_repositories.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_socket_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_usecases.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/datasource/login/login_data_source.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/repositories/login/login_repositories_impl.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/service/login/login_service.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/repositories/login_repositories.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/usecases/login/login_usecases.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/datasource/qr_datasource.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/repositories/qr_repositories_impl.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/service/qr_analysis_service.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/repositories/qr_repositories.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/usecases/qr_usecases.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/datasource%20/contacts_datasource.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/repositories/contact_repositories_impl.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/service/contacts_service.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/repositories/contact_repositories.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/usecases/contact_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupLocator(GetIt getIt) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<Localstorage>(
    () => Localstorage(pref: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<HomeUsecases>(
    () => HomeUsecasesImpl(
      homeRepositories: getIt<HomeRepositories>(),
      localstorage: getIt<Localstorage>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepositories>(
    () => HomeRepositoriesImpl(
      homeDatasource: getIt<HomeDatasource>(),
      localstorage: getIt<Localstorage>(),
    ),
  );
  getIt.registerLazySingleton<DioInstance>(() => DioInstance());
  getIt.registerLazySingleton<HomeService>(
    () => HomeService(getIt<DioInstance>().dio),
  );
  getIt.registerLazySingleton<HomeDatasource>(
    () => HomeDatasourceImpl(homeService: getIt<HomeService>()),
  );
  getIt.registerLazySingleton<LoginService>(
    () => LoginService(getIt<DioInstance>().dio),
  );
  getIt.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(loginService: getIt<LoginService>()),
  );
  getIt.registerLazySingleton<LoginRepositories>(
    () => LoginRepositoriesImpl(
      loginDataSource: getIt<LoginDataSource>(),
      localstorage: getIt<Localstorage>(),
    ),
  );
  getIt.registerLazySingleton<Authservice>(
    () => Authservice(getIt<DioInstance>().dio),
  );
  getIt.registerLazySingleton<ContactsService>(
    () => ContactsService(getIt<DioInstance>().dio),
  );
  getIt.registerLazySingleton<ContactsDatasource>(
    () => ContactsDatasourceImpl(contactsService: getIt<ContactsService>()),
  );
  getIt.registerLazySingleton<ContactRepositories>(
    () => ContactRepositoriesImpl(
      contactsDatasource: getIt<ContactsDatasource>(),
    ),
  );
  getIt.registerLazySingleton<LoginUsecases>(
    () => LoginUsecasesImpl(loginRepositories: getIt<LoginRepositories>()),
  );
  getIt.registerLazySingleton<ContactUsecases>(
    () =>
        ContactUsecasesImpl(contactRepositories: getIt<ContactRepositories>()),
  );
  getIt.registerLazySingleton<QrAnalysisService>(
    () => QrAnalysisService(getIt<DioInstance>().dio),
  );
  getIt.registerLazySingleton<QrDatasource>(
    () => QrDatasourceImpl(qrAnalysisService: getIt<QrAnalysisService>()),
  );
  getIt.registerLazySingleton<QrRepositories>(
    () => QrRepositoriesIMmpl(qrDatasource: getIt<QrDatasource>()),
  );
  getIt.registerLazySingleton<QrUsecases>(
    () => QrUsecasesImpl(qrRepositories: getIt<QrRepositories>()),
  );
  getIt.registerLazySingleton<WebsocketService>(() => WebsocketManager());
  getIt.registerLazySingleton<HomeSocketRepositories>(() =>
      HomeSocketRepositoryImpl(
          websocketService: getIt<WebsocketService>(),
          localstorage: getIt<Localstorage>()));
  getIt.registerLazySingleton<HomeSocketUsecases>(() => HomeSocketUsecasesImpl(
      homeSocketRepositories: getIt<HomeSocketRepositories>()));

  getIt.registerLazySingleton<SignUpService>(
      () => SignUpService(getIt<DioInstance>().dio));
  getIt.registerLazySingleton<SignupDataSource>(
      () => SignupDataSourceImpl(signUpService: getIt<SignUpService>()));
  getIt.registerLazySingleton<SignUpRepositories>(() => SignUpRepositoriesImpl(
      signupDataSource: getIt<SignupDataSource>(),
      localstorage: getIt<Localstorage>()));
  getIt.registerLazySingleton<SignupUsecases>(
      () => SignupUsecaseImpl(signUpRepositories: getIt<SignUpRepositories>()));
}

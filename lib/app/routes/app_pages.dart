import 'package:get/get.dart';

import '../../presentation/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../../presentation/auth/forgot_password/views/forgot_password_view.dart';
import '../../presentation/auth/login/bindings/login_binding.dart';
import '../../presentation/auth/login/views/login_view.dart';
import '../../presentation/auth/new_password/bindings/new_password_binding.dart';
import '../../presentation/auth/new_password/views/new_password_view.dart';
import '../../presentation/auth/otp/bindings/otp_binding.dart';
import '../../presentation/auth/otp/views/otp_view.dart';
import '../../presentation/auth/signup/bindings/signup_binding.dart';
import '../../presentation/auth/signup/views/signup_view.dart';
import '../../presentation/main/bindings/main_binding.dart';
import '../../presentation/main/views/main_view.dart';
import '../../presentation/splash/bindings/splash_binding.dart';
import '../../presentation/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
  ];
}

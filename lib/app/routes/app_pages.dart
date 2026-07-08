import 'package:get/get.dart';

import '../../presentation/admin/bindings/admin_binding.dart';
import '../../presentation/admin/views/admin_announcements_view.dart';
import '../../presentation/admin/views/admin_dashboard_view.dart';
import '../../presentation/admin/views/admin_hospitals_view.dart';
import '../../presentation/admin/views/admin_reports_view.dart';
import '../../presentation/admin/views/admin_requests_view.dart';
import '../../presentation/admin/views/admin_users_view.dart';
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
import '../../presentation/donations/bindings/donation_binding.dart';
import '../../presentation/donations/views/donation_history_view.dart';
import '../../presentation/donor/bindings/become_donor_binding.dart';
import '../../presentation/donor/views/become_donor_view.dart';
import '../../presentation/hospitals/bindings/hospitals_binding.dart';
import '../../presentation/hospitals/views/favorites_view.dart';
import '../../presentation/hospitals/views/hospitals_view.dart';
import '../../presentation/main/bindings/main_binding.dart';
import '../../presentation/main/views/main_view.dart';
import '../../presentation/notifications/bindings/notifications_binding.dart';
import '../../presentation/notifications/views/notifications_view.dart';
import '../../presentation/profile/bindings/edit_profile_binding.dart';
import '../../presentation/profile/views/edit_profile_view.dart';
import '../../presentation/requests/bindings/request_binding.dart';
import '../../presentation/requests/views/create_request_view.dart';
import '../../presentation/requests/views/request_detail_view.dart';
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
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.BECOME_DONOR,
      page: () => const BecomeDonorView(),
      binding: BecomeDonorBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_REQUEST,
      page: () => const CreateRequestView(),
      binding: CreateRequestBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_DETAIL,
      page: () => const RequestDetailView(),
      binding: RequestDetailBinding(),
    ),
    GetPage(
      name: _Paths.HOSPITALS,
      page: () => const HospitalsView(),
      binding: HospitalsBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_HISTORY,
      page: () => const DonationHistoryView(),
      binding: DonationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminDashboardView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => const AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_REQUESTS,
      page: () => const AdminRequestsView(),
      binding: AdminRequestsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOSPITALS,
      page: () => const AdminHospitalsView(),
      binding: AdminHospitalsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_REPORTS,
      page: () => const AdminReportsView(),
      binding: AdminReportsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ANNOUNCEMENTS,
      page: () => const AdminAnnouncementsView(),
      binding: AdminAnnouncementsBinding(),
    ),
  ];
}

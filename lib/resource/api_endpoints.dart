class ApiEndPoints {
  static const String baseUrl = 'https://playnow-backend-psi.vercel.app/v1';

  static const String auth = '$baseUrl/auth';
  static const String login = '$auth/login';
  static const String signup = '$auth/register';
  static const String logout = '$auth/logout';
  static const String socialLogin = '$auth/social-login';
  static const String logoutAll = '$auth/logout-all-devices';
  static const String forgotPassword = '$auth/forget-password';
  static const String resetPassword = '$auth/reset-password';
  static const String verifyOtp = '$auth/verify-otp';
  static const String initailProfileCreate = '$auth/profile';
}

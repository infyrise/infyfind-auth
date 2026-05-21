// import '../services/auth_service.dart';
// import '../storage/token_storage.dart';
// import '../config/dio_client.dart';
//
// class AuthController {
//   final auth = AuthService();
//
//   Future login(String email) async {
//     return await auth.sendOtp(email);
//   }
//
//   Future verify(String email, String otp) async {
//     final res = await auth.verifyOtp(email, otp);
//
//     if (res["token"] != null) {
//       await TokenStorage.save(res["token"]);
//       DioClient.setToken(res["token"]);
//     }
//
//     return res;
//   }
//
//   Future autoLogin() async {
//     final token = await TokenStorage.get();
//     if (token != null) {
//       DioClient.setToken(token);
//       return true;
//     }
//     return false;
//   }
// }
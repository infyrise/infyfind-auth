// import 'package:flutter/material.dart';
// import '../../services/user_service.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final userService = UserService();
//   Map? user;
//
//   @override
//   void initState() {
//     super.initState();
//     loadUser();
//   }
//
//   void loadUser() async {
//     final res = await userService.getMe();
//     setState(() {
//       user = res;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: user == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         children: [
//           Text("Name: ${user!['name']}"),
//           Text("Email: ${user!['email']}"),
//         ],
//       ),
//     );
//   }
// }
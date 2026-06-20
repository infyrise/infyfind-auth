import 'package:flutter/material.dart';
import 'ContainerButton.dart';
import 'app_colors.dart';

Future<T?> appModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  String title = 'Information',
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.9,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
        
                /// Drag Handle
                const SizedBox(height: 20),
                Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
        
                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
        
                      /// ICON
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'packages/infyfind_auth/assets/icon/app_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
        
                      const SizedBox(width: 12),
        
                      /// TEXT
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back 👋",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Login to continue your journey",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
        
                      /// SKIP
                      SizedBox(
                        width: 80,
                        child: ContainerButton(
                          text: "Skip",
                          onTap: () {
                            Navigator.pop(ctx, null); // 🔥 important for SDK flow
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        
                /// CONTENT
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
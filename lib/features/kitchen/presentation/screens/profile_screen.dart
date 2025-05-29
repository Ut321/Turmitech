import 'package:flutter/material.dart';
import 'package:meal_app/core/widgets/comming_soon_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Profile',
      icon: Icons.person_outline,
      description: 'Manage your account, preferences, and personal settings. Your profile customization is on the way!',
    );
  }
}
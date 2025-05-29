import 'package:flutter/material.dart';
import 'package:meal_app/core/widgets/comming_soon_screen.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Subscriptions',
      icon: Icons.calendar_today,
      description: 'Manage your meal subscriptions and recurring orders. Get ready for convenient meal planning!',
    );
  }
}
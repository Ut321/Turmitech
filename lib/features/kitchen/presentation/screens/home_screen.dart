import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/network_status_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/kitchens_section.dart';
import '../widgets/meal_plans_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
        leading: const Icon(Icons.location_on, color: Colors.black54),
        title: Row(
          children: [
            const Expanded(
              child: Text(
                '123 Main St, Toronto, O...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            const SizedBox(width: 16),
            const Icon(Icons.favorite_border, color: Colors.black54),
            const SizedBox(width: 16),
            const Icon(Icons.notifications_outlined, color: Colors.black54),
          ],
        ),
      ),
      body: const Column(
        children: [
          NetworkStatusWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomSearchBar(),
                  SizedBox(height: 16),
                  KitchensSection(),
                  SizedBox(height: 24),
                  MealPlansSection(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
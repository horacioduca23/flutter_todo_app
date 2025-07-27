import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/string_constants.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/adaptive/adaptive_app_bar.dart';
import '../../widgets/adaptive/adaptive_button.dart';
import '../../widgets/adaptive/adaptive_scaffold.dart';
import '../../widgets/home_body_content.dart';
import '../../widgets/home_header_delete_action.dart';
import '../../widgets/home_header_subtitle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.todoApp,
        actions: [HomeHeaderDeleteAction()],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              HomeHeaderSubtitle(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Divider(color: Colors.grey, thickness: 1.5),
              ),
              const SizedBox(height: 20),
              HomeBodyContent(),
            ],
          ),
        ),
      ),
      floatingActionButton: AdaptiveButton(
        color: const Color(0xFF4A6CF7),
        isFilled: true,
        onPressed: () => context.goNamed(AppRoutes.addTask.name),
        child: const Icon(Icons.add, color: Colors.white, size: 28.0),
      ),
    );
  }
}

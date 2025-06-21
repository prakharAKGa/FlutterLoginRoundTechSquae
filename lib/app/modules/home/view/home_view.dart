
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/modules/home/controller/home_controller.dart';
import 'package:round_tech_square/app/shared/app_theme.dart';
import 'package:round_tech_square/app/widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: Obx(() => controller.profile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                 
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.darkTheme.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(controller.profile!.avatar),
                        backgroundColor: AppTheme.darkTheme.colorScheme.secondary.withOpacity(0.1),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    Text(
                      controller.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
                        color: AppTheme.darkTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                   
                    Card(
                      color: AppTheme.darkTheme.colorScheme.secondary.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Details',
                              style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                                color: AppTheme.darkTheme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            _buildDetailRow('Name', controller.profile!.name),
                            const SizedBox(height: 10),
                            _buildDetailRow('Email', controller.profile!.email),
                            const SizedBox(height: 10),
                            _buildDetailRow('Role', controller.profile!.role),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                   
                    CustomGradientButton(
                      text: 'Logout',
                      onPressed: () async {
                        await controller.logout();
                      },
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.darkTheme.colorScheme.onSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.darkTheme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
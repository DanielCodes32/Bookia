import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = SharedPref.getuserinfo();

    return Scaffold(
      backgroundColor: AppColors.containercolor,
      appBar: AppBar(
        backgroundColor: AppColors.containercolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile', style: TextStyles.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: AppColors.blackColor,
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              // Profile info row
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user?.image ?? "",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.DmSerif,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          user?.email ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greycolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(30),
              // Menu items list
              _ProfileMenuItem(
                title: 'My Orders',
                onTap: () {
                  mydiag(context, "My Orders coming soon", Colors.grey);
                },
              ),
              const Gap(8),
              _ProfileMenuItem(
                title: 'Edit Profile',
                onTap: () {
                  pushTo(context, Routes.editProfile).then((_) {
                    setState(() {});
                  });
                },
              ),
              const Gap(8),
              _ProfileMenuItem(
                title: 'Reset Password',
                onTap: () {
                  pushTo(context, Routes.forgetpassword);
                },
              ),
              const Gap(8),
              _ProfileMenuItem(
                title: 'FAQ',
                onTap: () {
                  mydiag(context, "FAQ coming soon", Colors.grey);
                },
              ),
              const Gap(8),
              _ProfileMenuItem(
                title: 'Contact Us',
                onTap: () {
                  mydiag(context, "Contact Us coming soon", Colors.grey);
                },
              ),
              const Gap(8),
              _ProfileMenuItem(
                title: 'Privacy & Terms',
                onTap: () {
                  mydiag(context, "Privacy & Terms coming soon", Colors.grey);
                },
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: TextStyles.title),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.darkgreycolor),
            ),
          ),
          TextButton(
            onPressed: () {
              pop(context);
              SharedPref.pref.remove(SharedPref.ktoken);
              SharedPref.pref.remove(SharedPref.kuser);
              pushToBase(context, Routes.welcome);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyles.title.copyWith(fontSize: 18)),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blackColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

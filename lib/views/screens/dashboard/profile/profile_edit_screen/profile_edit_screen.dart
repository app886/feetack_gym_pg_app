import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/base/image_picker_sheet.dart';
import 'package:vlr/views/screens/dashboard/profile/profile_edit_screen/widget/personal_infor_section.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthController auth = Get.find<AuthController>();
      auth.fullNameController.text = auth.userModel?.name ?? "";
      auth.emailController.text = auth.userModel?.email ?? "";
      auth.mobileNoController.text = auth.userModel?.mobile ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                  color: primaryText1.withValues(alpha: 0.20),
                ),
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                  color: primaryText1.withValues(alpha: 0.20),
                )
              ]),
              child: GetBuilder<AuthController>(builder: (authController) {
                return CustomButton(
                  isLoading: authController.isLoading,
                  onTap: () {
                    authController.updateProfile().then((value) {
                      if (value.isSuccess) {
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                        pop(context);
                      } else {
                        showToast(
                            message: value.message, typeCheck: value.isSuccess);
                      }
                    });
                  },
                  height: 68,
                  radius: 999,
                  color: primaryText1,
                  borderColor: primaryText1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save Changes",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: white,
                            ),
                      ),
                      sizedBoxWidth(width: 12),
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: white,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        centerTitle: true,
        title: Text(
          "Profile",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
                letterSpacing: 1.4,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: GetBuilder<AuthController>(builder: (authController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _buildProfileImage(authController, context),
              ),
              const PersonalInforSection(),
              // ProfileBillingAddressSection(),

              sizedBoxHeight(height: 32),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildProfileImage(
      AuthController authController, BuildContext context) {
    bool hasLocalImage = authController.profileImage != null;

    return InkWell(
      onTap: () async {
        final file = await getImageBottomSheet(context);
        if (file != null) {
          authController.updateImages(file);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: white, width: 4),
              boxShadow: [
                BoxShadow(
                    color: black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: hasLocalImage
                  ? Image.file(
                      authController.profileImage!,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    )
                  : CustomImage(
                      color: white,
                      isProfile: true,
                      path: authController.userModel?.image ?? "",
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                      radius: 100,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: primaryText1, shape: BoxShape.circle),
              child: Icon(
                Icons.camera,
                color: white,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:antripe_flutter_assignment/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_button.dart';

class AddContactBottomSheet extends StatelessWidget {
  const AddContactBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final designationController = TextEditingController();
    final companyController = TextEditingController();
    final relationController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: SizeUtils.rsHeight(30),
        left: 32,
        right: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top center bar
          Container(
            width: SizeUtils.rsWidth(151),
            height: SizeUtils.rsHeight(6),
            decoration: BoxDecoration(
              color: AppColors.divider1,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          SizedBox(height: SizeUtils.rsHeight(30)),

          // Input Fields
          _buildTextField('Name', nameController),
          SizedBox(height: SizeUtils.rsHeight(12)),
          _buildTextField('Phone', designationController),
          SizedBox(height: SizeUtils.rsHeight(12)),
          _buildTextField('Designation', designationController),
          SizedBox(height: SizeUtils.rsHeight(12)),
          _buildTextField('Company', companyController),
          SizedBox(height: SizeUtils.rsHeight(12)),
          _buildTextField('Relation', relationController,suffixIcon: Icons.keyboard_arrow_down_outlined),
          SizedBox(height: SizeUtils.rsHeight(24)),
          CustomButton(
            label: "Save Contact".tr,
            backgroundColor: AppColors.green,
            textColor: Colors.white,
            borderRadius: 60,
            fullWidth: true,
            height: SizeUtils.rsHeight(50),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 24),
          CustomButton(
            label: "Cancel".tr,
            backgroundColor: AppColors.background,
            textColor: AppColors.textColor2,
            borderRadius: 60,
            borderColor: Colors.black,
            borderWidth: 1,
            fullWidth: true,
            height: SizeUtils.rsHeight(50),
            onPressed: () => Navigator.pop(context),
          ),

          SizedBox(height: SizeUtils.rsHeight(50)),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textColor1, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textColor1),

        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, color: AppColors.borderColor, size: 20),

        suffixIcon: suffixIcon == null
            ? null
            : GestureDetector(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, color: AppColors.divider1, size: 20),
              ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
        ),

        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}

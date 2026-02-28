import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_clipper.dart';
import '../controller/home_controller.dart';
import 'add_contact_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<HomeScreen> {
  final ContactController controller = Get.find();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.searchQuery.value = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      controller.searchQuery.value = '';
    });
  }

  void _openAddContactBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const AddContactBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: isSearching
            ? Container(
                height: SizeUtils.rsHeight(48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: SizeUtils.rsWidth(10)),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: "Search contacts...",
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ),
                          style: TextStyle(
                            fontSize: SizeUtils.rsFont(16),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _stopSearch,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.close, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final text = Text(
                            'Contacts',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeUtils.rsFont(16),
                                  color: Colors.black,
                                ),
                          );
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              text,
                              SizedBox(height: SizeUtils.rsHeight(4)),
                              Container(
                                height: 2,
                                width:
                                    (text.style!.fontSize! *
                                    'Contacts'.length *
                                    0.6), // approximate width of text
                                color: AppColors.green,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(width: SizeUtils.rsWidth(16)),

                  Text(
                    'Recent',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.rsFont(16),
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
        actions: [
          if (!isSearching) ...[
            // Search SVG
            GestureDetector(
              onTap: _startSearch,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SvgPicture.asset(
                  'assets/images/search.svg', // your SVG path
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            // Menu SVG
            GestureDetector(
              onTap: () {
                // Your menu action
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SvgPicture.asset(
                  'assets/images/menu.svg', // your SVG path
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: ClipPath(
        clipper: TeardropClipper(),
        child: Material(
          color: AppColors.green,
          elevation: 6,
          child: InkWell(
            onTap: _openAddContactBottomSheet,
            child: const SizedBox(
              height: 64,
              width: 64,
              child: Center(
                child: Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            }

            if (controller.contacts.isEmpty) {
              return const Center(child: Text('No contacts available'));
            }

            return Column(
              children: [
                SizedBox(height: SizeUtils.rsHeight(10)),

                /// Category List
                Padding(
                  padding: EdgeInsets.only(left: SizeUtils.rsWidth(21)),
                  child: SizedBox(
                    height: SizeUtils.rsHeight(90),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        final isSelected =
                            category.id == controller.selectedCategory.value;

                        return GestureDetector(
                          onTap: () =>
                              controller.selectedCategory.value = category.id,
                          child: Container(
                            width: SizeUtils.rsWidth(70),
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeUtils.rsWidth(6),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: SizeUtils.rsWidth(56),
                                  height: SizeUtils.rsHeight(56),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.green
                                          : Colors.grey,
                                      width: SizeUtils.rsHeight(2),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: SizeUtils.rsHeight(26),
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      'https://i.pravatar.cc/150?img=$index',
                                    ),
                                  ),
                                ),
                                SizedBox(height: SizeUtils.rsHeight(4)),
                                Text(
                                  category.name,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: isSelected
                                            ? AppColors.green
                                            : const Color(0xFF6F7D91),
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.rsFont(14),
                                      ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                /// Contacts List
                Expanded(
                  child: controller.filteredContacts.isEmpty
                      ? SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeUtils.rsHeight(50),
                              ), // space from top
                              Center(
                                child: SizedBox(
                                  width: SizeUtils.rsWidth(342),
                                  height: SizeUtils.rsHeight(224),
                                  child: Card(
                                    color: const Color(0xFFF0F6FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // center content inside card
                                        children: [
                                          Text(
                                            'Ee! No Contacts\nfound.',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: SizeUtils.rsFont(
                                                    20,
                                                  ),
                                                  color: AppColors.textColor1,
                                                ),
                                          ),
                                          const SizedBox(height: 16),
                                          CustomButton(
                                            label: "Add New Contact".tr,
                                            backgroundColor: AppColors.green,
                                            textColor: Colors.white,
                                            borderRadius: 60,
                                            fullWidth: true,
                                            height: SizeUtils.rsHeight(50),
                                            onPressed:
                                                _openAddContactBottomSheet,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeUtils.rsWidth(21),
                          ),
                          child: ListView.separated(
                            itemCount: controller.filteredContacts.length,
                            separatorBuilder: (_, __) => const Divider(
                              height: 1,
                              color: AppColors.divider,
                            ),
                            itemBuilder: (context, index) {
                              final contact =
                                  controller.filteredContacts[index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    contact.avatarUrl,
                                  ),
                                ),
                                title: Text(
                                  contact.name,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeUtils.rsFont(16),
                                        color: AppColors.textColor1,
                                      ),
                                ),
                                subtitle: Text(
                                  contact.phone,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.rsFont(14),
                                        color: AppColors.textColor1,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          }),

          /// Alphabet UI
          Obx(() {
            if (controller.filteredContacts.isEmpty) {
              return const SizedBox();
            }
            return Positioned(
              right: 2,
              top: 120,
              bottom: 0,
              child: Container(
                width: 24,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(26, (index) {
                    final letter = String.fromCharCode(65 + index);
                    return Expanded(
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: SizeUtils.rsFont(10),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

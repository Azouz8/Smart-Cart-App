import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';

import 'custom_submit_button.dart';

class CategoriesViewBody extends StatelessWidget {
  CategoriesViewBody({super.key});
  final controller = MultiSelectController();
  final List selectedCategories = [];
  final List<MultiSelectCard> list = [
    MultiSelectCard(value: 'Dart', label: 'Dart'),
    MultiSelectCard(value: 'Python', label: 'Python'),
    MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
    MultiSelectCard(value: 'Java', label: 'Java'),
    MultiSelectCard(value: 'C#', label: 'C#'),
    MultiSelectCard(value: 'C++', label: 'C++'),
    MultiSelectCard(value: 'Go Lang', label: 'Go Lang'),
    MultiSelectCard(value: 'Swift', label: 'Swift'),
    MultiSelectCard(value: 'PHP', label: 'PHP'),
    MultiSelectCard(value: 'Kotlin', label: 'Kotlin'),
    MultiSelectCard(value: 'Dart', label: 'Dart'),
    MultiSelectCard(value: 'Python', label: 'Python'),
    MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
    MultiSelectCard(value: 'Java', label: 'Java'),
    MultiSelectCard(value: 'C#', label: 'C#'),
    MultiSelectCard(value: 'C++', label: 'C++'),
    MultiSelectCard(value: 'Go Lang', label: 'Go Lang'),
    MultiSelectCard(value: 'Swift', label: 'Swift'),
    MultiSelectCard(value: 'PHP', label: 'PHP'),
    MultiSelectCard(value: 'Kotlin', label: 'Kotlin'),
    MultiSelectCard(value: 'Dart', label: 'Dart'),
    MultiSelectCard(value: 'Python', label: 'Python'),
    MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
    MultiSelectCard(value: 'Java', label: 'Java'),
    MultiSelectCard(value: 'C#', label: 'C#'),
    MultiSelectCard(value: 'C++', label: 'C++'),
    MultiSelectCard(value: 'Go Lang', label: 'Go Lang'),
    MultiSelectCard(value: 'Swift', label: 'Swift'),
    MultiSelectCard(value: 'PHP', label: 'PHP'),
    MultiSelectCard(value: 'Kotlin', label: 'Kotlin'),
    MultiSelectCard(value: 'Dart', label: 'Dart'),
    MultiSelectCard(value: 'Python', label: 'Python'),
    MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
    MultiSelectCard(value: 'Java', label: 'Java'),
    MultiSelectCard(value: 'C#', label: 'C#'),
    MultiSelectCard(value: 'C++', label: 'C++'),
    MultiSelectCard(value: 'Go Lang', label: 'Go Lang'),
    MultiSelectCard(value: 'Swift', label: 'Swift'),
    MultiSelectCard(value: 'PHP', label: 'PHP'),
    MultiSelectCard(value: 'Kotlin', label: 'Kotlin'),
    MultiSelectCard(value: 'Dart', label: 'Dart'),
    MultiSelectCard(value: 'Python', label: 'Python'),
    MultiSelectCard(value: 'JavaScript', label: 'JavaScript'),
    MultiSelectCard(value: 'Java', label: 'Java'),
    MultiSelectCard(value: 'C#', label: 'C#'),
    MultiSelectCard(value: 'C++', label: 'C++'),
    MultiSelectCard(value: 'Go Lang', label: 'Go Lang'),
    MultiSelectCard(value: 'Swift', label: 'Swift'),
    MultiSelectCard(value: 'PHP', label: 'PHP'),
    MultiSelectCard(value: 'Kotlin', label: 'Kotlin'),
    MultiSelectCard(value: 'Dart', label: 'Dart'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: CustomHomeAppBar(title: "Choose Your Favorite Categories"),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: MultiSelectContainer(
                  controller: controller,
                  items: list,
                  itemsPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration:
                        selectionDecoration(AppColorsLight.primaryColor),
                    decoration: selectionDecoration(Colors.grey.withAlpha(25)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    selectedTextStyle: TextStyle(fontSize: 18.sp),
                    textStyle: TextStyle(fontSize: 18.sp),
                  ),
                  splashColor: AppColorsLight.primaryColor,
                  highlightColor: AppColorsLight.primaryColor,
                  onChange: (selectedItems, selectedItem) {
                    selectedCategories.clear();
                    selectedCategories.addAll(selectedItems.map(
                      (e) {
                        return e;
                      },
                    ));
                    print(selectedCategories);
                  },
                ),
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: CustomSubmitButton(
                    title: "Submit",
                    route: AppRouter.homeView,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ShapeDecoration selectionDecoration(Color color) {
    return ShapeDecoration(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}

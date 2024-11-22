import 'package:donation/core/apptext_formfield.dart';
import 'package:donation/features/home/presentation/views/widgets/search_changablebuttons.dart';
import 'package:flutter/material.dart';

class SearchAndChangingSection extends StatelessWidget {
  const SearchAndChangingSection({
    super.key,
    required this.searchController,
    required this.buttontext,
  });

  final TextEditingController searchController;
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTexttFormField(
          hintText: 'Search for A donor',
          controller: searchController,
        ),
        SizedBox(height: 15),
        SearchAndChangableButton(buttontext: buttontext),
      ],
    );
  }
}

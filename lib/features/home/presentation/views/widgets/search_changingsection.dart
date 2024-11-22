import 'package:donation/core/apptext_formfield.dart';
import 'package:donation/features/home/presentation/views/widgets/search_changablebuttons.dart';
import 'package:flutter/material.dart';

class SearchAndChangingSection extends StatelessWidget {
  const SearchAndChangingSection({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTexttFormField(
            hintText: 'Search for A donor by BloodType',
            controller: searchController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a blood type to search';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          SearchAndChangableButton(
            searchController: searchController,
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}

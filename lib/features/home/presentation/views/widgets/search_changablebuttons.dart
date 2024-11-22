import 'package:donation/core/apptext_button.dart';
import 'package:donation/features/home/presentation/viewmodels/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndChangableButton extends StatefulWidget {
  const SearchAndChangableButton(
      {super.key, required this.searchController, required this.formKey});

  @override
  State<SearchAndChangableButton> createState() =>
      _SearchAndChangableButtonState();
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;
}

class _SearchAndChangableButtonState extends State<SearchAndChangableButton> {
  String buttontext = 'be donor'; // Default button text

  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().fetchUserRole(); // Fetch user role
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextButton(
            buttonHeight: 25,
            buttonText: 'Search',
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            onPressed: () {
              if (widget.formKey.currentState?.validate() ?? false) {
                // If form is valid, trigger the search
                String bloodType = widget.searchController.text.trim();
                context.read<UsersCubit>().searchDonors(bloodType);
              }
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: BlocConsumer<UsersCubit, UsersState>(
            builder: (context, state) {
              return AppTextButton(
                buttonHeight: 25,
                buttonText: buttontext, // Display the dynamic button text
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                onPressed: () {
                  if (buttontext == 'be donor') {
                    context.read<UsersCubit>().updateUserRoleToDonor();
                  } else {
                    context.read<UsersCubit>().updateUserRoleTopatient();
                  }
                },
              );
            },
            listener: (context, state) {
              if (state is RoleFetched) {
                // Update button text based on user role
                setState(() {
                  buttontext =
                      state.role == 'patient' ? 'be donor' : 'be patient';
                });
              } else if (state is UpdatedToDonor) {
                setState(() {
                  buttontext = 'be patient';
                });
              } else if (state is UpdatedToPatient) {
                setState(() {
                  buttontext = 'be donor';
                });
              } else if (state is UpdatedRoleFailed) {
                // Handle failure (optional)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failedmessage)),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:donation/core/apptext_button.dart';
import 'package:donation/features/home/presentation/viewmodels/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndChangableButton extends StatelessWidget {
  const SearchAndChangableButton({
    super.key,
    required this.buttontext,
  });

  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextButton(
            buttonHeight: 25,
            buttonText: 'Search',
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 15),
        // BlocConsumer to handle state changes
        Expanded(
            child: BlocConsumer<UsersCubit, UsersState>(
          builder: (context, state) {
            return AppTextButton(
              buttonHeight: 25,
              buttonText: buttontext, // Display updated text
              backgroundColor: Colors.red,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              onPressed: () {
                // if (buttontext == 'be donor') {
                //   BlocProvider.of<UsersCubit>(context)
                //       .updateUserRoleToDonor();
                // } else {
                //   BlocProvider.of<UsersCubit>(context)
                //       .updateUserRoleTopatient();
                // }
              },
            );
          },
          listener: (context, state) {
            // if (state is UpdatedToDonor) {
            //   setState(() {
            //     showToast(
            //         message:
            //             'Successfully updated to donor');
            //     buttontext =
            //         'be patient'; // Change the button text
            //   });
            // } else if (state is UpdatedToDonorFailed) {
            //   showToast(message: state.failedmessage);
            // } else if (state is UpdatedToPatient) {
            //   showToast(
            //       message:
            //           'Successfully updated to patient');
            //   buttontext = 'be donor';
            // } else if (state is UpdatedToPatientFailed) {
            //   showToast(message: state.failedmessage);
            // }
          },
        )),
      ],
    );
  }
}

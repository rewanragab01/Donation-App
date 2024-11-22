import 'package:donation/features/home/presentation/viewmodels/cubit/users_cubit.dart';
import 'package:donation/features/home/presentation/views/widgets/DonorList.dart';
import 'package:donation/features/home/presentation/views/widgets/search_changingsection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String buttontext = 'be donor'; // Initial button text
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UsersCubit>().streamDonors();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5.5,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SearchAndChangingSection(
                      searchController: searchController,
                      buttontext: buttontext),
                ),
                SizedBox(height: 50),
                const Text(
                  'Recent Donors',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                // Using shrinkWrap for ListView
                BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    if (state is Donorsloading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DonorsUserfetched) {
                      final Map<String, dynamic> donors = state.donors;
                      return DonorListView(donors: donors);
                    } else if (state is DonorsFetchfailure) {
                      return Text(state.failuremessage);
                    } else {
                      return Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

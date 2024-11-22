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

  @override
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
                  ),
                ),
                SizedBox(height: 50),
                BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    String title = 'Recent Donors';
                    if (state is DonorsSearchSuccess) {
                      title = 'Search Results';
                    }
                    return Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    if (state is Donorsloading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DonorsUserfetched) {
                      final donors = state.donors;
                      return DonorListView(donors: donors);
                    } else if (state is DonorsSearchSuccess) {
                      if (state.donors.isEmpty) {
                        return Center(
                          child: Text(
                            'No Donor Match',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      } else {
                        return DonorListView(donors: state.donors);
                      }
                    } else if (state is DonorsFetchfailure) {
                      return Text(state.failuremessage);
                    } else {
                      return SizedBox();
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

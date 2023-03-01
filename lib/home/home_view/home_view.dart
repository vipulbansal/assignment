import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vipul_assignment/home/home_bloc/home_bloc.dart';
import 'package:vipul_assignment/home/home_bloc/home_events.dart';
import 'package:vipul_assignment/home/home_bloc/home_states.dart';
import 'package:vipul_assignment/utils/custom_decorators.dart';

import '../../widgets/home_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  CustomDecorators customDecorators = CustomDecorators();
  bool isShowingFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          HomeBloc homeBloc = context.read<HomeBloc>();
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(),
              child: Builder(builder: (context) {
                if (state is UserDataLoadedErrorState) {
                  return Text(state.errorMessage);
                }
                if (state is NoNetworkState) {
                  return const Text("No Internet Connection");
                }
                return state is Loading
                    ? const Center(
                        child: Text("Loading..."),
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ROBOFRIENDS",
                                style: GoogleFonts.montez().copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isShowingFavourites
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                                  size: 20,
                                ),
                                onPressed: () {
                                  searchController.text = "";
                                  isShowingFavourites = !isShowingFavourites;
                                  homeBloc.add(
                                      ShowFavouritesEvent(isShowingFavourites));
                                },
                                tooltip: "Show/Hide Favourites",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: !isShowingFavourites,
                            child: TextField(
                              decoration: customDecorators
                                  .getInputDecoration("search robots"),
                              controller: searchController,
                              onChanged: (val) {
                                homeBloc.add(
                                  SearchUsersEvent(
                                    val,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                return HomeItem(homeBloc.filteredUsers[index],
                                    () {
                                  homeBloc.add(
                                    SetFavouriteEvent(
                                      homeBloc.filteredUsers[index],
                                      isShowingFavourites,
                                    ),
                                  );
                                });
                              },
                              itemCount: homeBloc.filteredUsers.length,
                            ),
                          ),
                        ],
                      );
              }),
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import 'package:hundred_days_of_programming/models/user_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder<DocumentSnapshot<User>>(
                future: User.userRef.doc("zePHJPeYVf2DUuzMRgvZ").get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.primary,
                      highlightColor: Colors.transparent,
                      child: homeTopView(
                        context,
                        null,
                      ),
                    );
                  }
                  User? user = snapshot.data!.data();
                  return homeTopView(context, user);
                }),
            Card(
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: listView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox homeTopView(BuildContext context, User? user) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .35,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hi, ${user == null ? 'User' : user.name}!",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(.5),
                  child: Text(
                    (user == null ? 'User' : user.name)[0],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: "eg: 6 / Day 6 / Leap Year Check",
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user == null
                      ? Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.primary,
                          highlightColor:
                              Theme.of(context).colorScheme.onPrimary,
                          child: ShimmerWidget(
                            width: MediaQuery.of(context).size.width * .5,
                            height: 90,
                          ),
                        )
                      : Text(
                          "${user.completedTasks.length}/100",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .40,
                      height: 40,
                      child: Material(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            user == null
                                ? 'Start'
                                : user.completedTasks.isEmpty
                                    ? 'Start'
                                    : 'Resume',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Map<dynamic, dynamic>> listView() {
    return FutureBuilder<Map>(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          Map? data = snapshot.data;
          return Column(
            children: List.generate(
              100,
              (index) => Dismissible(
                background: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return false; // Prevent dismissing for the update action
                  }
                  return true;
                },
                key: ValueKey(index + 1),
                child: ListTile(
                  trailing: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "🔴", // 🟢
                      ),
                    ],
                  ),
                  title: Text(
                    'Day ${data!["${index + 1}"]['id']}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  subtitle: Text(
                    data["${index + 1}"]['title'],
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  isThreeLine: true,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ).toList(),
          );
        });
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

Future<Map> readJson() async {
  final String response = await rootBundle.loadString('assets/data/input.json');
  Map data = await json.decode(response);
  return data;
}

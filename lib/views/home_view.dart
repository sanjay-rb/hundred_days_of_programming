import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .35,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi, Sanjay RB!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(.5),
                          child: Text(
                            'S',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
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
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.5),
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
                          Text(
                            "1/100",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .40,
                            height: 40,
                            child: Material(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Text(
                                  "Start",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
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
            ),
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

Future<Map> readJson() async {
  final String response = await rootBundle.loadString('assets/data/input.json');
  Map data = await json.decode(response);
  return data;
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "( Drag down to refresh )",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 8,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Task Completed",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "10/100",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<Map>(
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
                          title: Text('Day ${data!["${index + 1}"]['id']}'),
                          subtitle: Text(data["${index + 1}"]['title']),
                          isThreeLine: true,
                          leading: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_outline),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ).toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

Future<Map> readJson() async {
  final String response = await rootBundle.loadString('assets/data/input.json');
  Map data = await json.decode(response);
  return data;
}

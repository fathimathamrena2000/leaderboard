import 'package:flutter/material.dart';
import 'package:leaderboard_app/database/db_functions.dart';
import 'package:leaderboard_app/provider/userprovider.dart';
import 'package:leaderboard_app/widgets/list.dart';
import 'package:leaderboard_app/widgets/winner.dart';
import 'package:provider/provider.dart';

import '../model/usermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserDetails>(context, listen: false).fetchdata();
  }

  List<Leader> sortLeaders(List<Leader> leaders) {
    // Sort leaders based on points in descending order
    leaders.sort((a, b) => b.points.compareTo(a.points));

    return leaders;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails>(context);

    if (user.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (user.hasError) {
      return const Scaffold(
        body: Center(
          child: Text('Failed to fetch data. Please try again later.'),
        ),
      );
    } else if (user.userData == null || user.userData!.leaders.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No data available.'),
        ),
      );
    } else {
      List<Leader> sortedLeaders = sortLeaders(user.userData!.leaders);

      // Print sorted leaders
      sortedLeaders.forEach((leader) {
        print(
          'Name: ${leader.name}, Points: ${leader.points}',
        );
      });

      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 100, 78, 159),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // leading: const Icon(
            //   Icons.arrow_back_ios,
            //   color: Colors.white,
            // ),
            title: const Center(
              child: Text(
                "LeaderBoard",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            onPressed: () {},
            child: const Icon(Icons.document_scanner_outlined),
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child: BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home_outlined,
                            size: 30,
                          ))),
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.compare_arrows,
                            size: 30,
                          )))
                ],
              ),
            ),
          ),
          body: FutureBuilder<List<Leader>>(
              future: DatabaseHelper.getLeaders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Leader> leaders = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 197, 142, 206),
                              ),
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 43, 24, 92),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Region:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Icon(
                                      Icons.location_pin,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    "${user.userData!.region}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Winner(
                                isFirst: false,
                                height: 150,
                                myColor: Colors.grey.shade400,
                                img: sortedLeaders[1].profilePic,
                                score: sortedLeaders[1].points.toString(),
                                name: sortedLeaders[1].name,
                                rank: sortedLeaders[1].userId,
                              ),
                              Winner(
                                isFirst: true,
                                height: 170,
                                myColor:
                                    const Color.fromARGB(255, 225, 191, 87),
                                img: sortedLeaders[0].profilePic,
                                score: sortedLeaders[0].points.toString(),
                                name: sortedLeaders[0].name,
                                rank: sortedLeaders[0].userId,
                              ),
                              Winner(
                                isFirst: false,
                                height: 130,
                                myColor: Colors.orange,
                                img: sortedLeaders[2].profilePic,
                                score: sortedLeaders[2].points.toString(),
                                name: sortedLeaders[2].name,
                                rank: sortedLeaders[2].userId,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20)),
                          //   ),
                          // child:
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: const Color.fromARGB(255, 43, 24, 92),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 197, 142, 206),
                                )),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Rank",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        "Athelete",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        "Points",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListWheelScrollView(
                                    itemExtent: 100,
                                    children: List.generate(
                                      leaders.length - 3,
                                      (index) {
                                        Leader leader = leaders[index + 3];
                                        return ListUsers(
                                          rank: leader.userId,
                                          img: leader.profilePic,
                                          name: leader.name,
                                          score: leader.points.toString(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  );
                }
              }));
    }
  }
}

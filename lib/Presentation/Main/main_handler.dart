import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellar_demo/Application/state.dart';
import 'package:stellar_demo/Presentation/Main/annotate.dart';
import 'package:stellar_demo/Repository/project_model.dart';
import 'package:stellar_demo/Repository/soroban_server.dart';

class MainHandler extends ConsumerStatefulWidget {
  const MainHandler({super.key});

  @override
  ConsumerState<MainHandler> createState() => _MainHandlerState();
}

class _MainHandlerState extends ConsumerState<MainHandler> {
  int getHrsLeft(DateTime time) {
    var now = DateTime.now();
    var diff = time.difference(now);
    return diff.inHours;
  }

  @override
  Widget build(BuildContext context) {
    var projectt = ref.watch(projectStateProvider);
    return projectt.when(
        data: (snapshot) {
          return Scaffold(
              body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Available projects",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.length,
                    itemBuilder: (context, index) {
                      Projectt project = snapshot[index]!;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Annotate()));
                          },
                          child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(project.name),
                                      Spacer(),
                                      Text("${project.currentAmount}/${project.targetAmount}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(project.description),
                                      Spacer(),
                                      Text(
                                        "${getHrsLeft(DateTime.fromMillisecondsSinceEpoch(project.deadline)).toString()} hrs left",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ));
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () {
          return const CircularProgressIndicator();
        });
  }
}

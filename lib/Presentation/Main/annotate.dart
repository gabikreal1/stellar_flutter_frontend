import 'package:flutter/material.dart';
import 'package:stellar_demo/Repository/crowd_funding_repository.dart';
import 'package:stellar_demo/Repository/project_model.dart';

class Annotate extends StatefulWidget {
  final Projectt project;
  const Annotate({super.key, required this.project});

  @override
  State<Annotate> createState() => _AnnotateState();
}

class _AnnotateState extends State<Annotate> {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset("assets/images/annotate.png"),
            Text(
              "Annotate",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  CrowdFundingRepository.submit(controller.text, widget.project.id, "Dataannotation");
                },
                child: Text("Submit"))
          ],
        ),
      )),
    );
  }
}

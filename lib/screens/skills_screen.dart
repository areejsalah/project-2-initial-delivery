import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/skill_provider.dart';
import 'package:flutter_application_1/screens/resume_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/skill_widget.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  int count = 1;
  List<SkillWidget> skillsWidgets = [];
  void addNewSkill() {
    setState(() {
      skillsWidgets.add(SkillWidget());
      count++;
      log(skillsWidgets.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    skillsWidgets = List.generate(count, (index) => SkillWidget());
    return Consumer<SkillProvider>(
      builder: ((context, provider, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: addNewSkill,
              label: const Text('Add'),
              icon: const Icon(Icons.add),
            ),
            appBar: AppBar(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skills'),
                InkWell(
                  onTap: () {
                    provider.insertNewSkill();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ResumeScreen();
                    }));
                  },
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            )),
            body: ListView.builder(
                itemCount: skillsWidgets.length,
                itemBuilder: (context, index) {
                  return skillsWidgets[index];
                }));
      }),
    );
  }
}

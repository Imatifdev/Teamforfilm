import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/Utils/widgets/custom_button.dart';
import 'package:navin_project/view/TeamMember/Home/UI/home.dart';
import 'package:navin_project/view/TeamMember/Home/models/job_model.dart';

class JobDetailPage extends StatefulWidget {
  final Job job;

  const JobDetailPage({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

bool isSaved = false;

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text("Job Detail"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.job.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: AppConstants.primaryColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                widget.job.imageUrl,
                fit: BoxFit.cover,
                width: 300,
                height: 200.0,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
            child: CustomButton(
              text: "Download Script",
              height: 40,
              width: 200,
              color: AppConstants.secondaryColor.withOpacity(0.2),
              borderRadius: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppConstants.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.job.date,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        isSaved
                            ? CupertinoIcons.bookmark_solid
                            : CupertinoIcons.bookmark,
                        color: isSaved ? Colors.white : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  widget.job.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  widget.job.description,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

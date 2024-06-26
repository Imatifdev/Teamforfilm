import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/view/TeamMember/Home/UI/job_detail.dart';
import 'package:navin_project/view/TeamMember/Home/models/job_model.dart';

class JobCard extends StatefulWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetailPage(job: widget.job)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                  ],
                ),
                Text(
                  widget.job.description,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

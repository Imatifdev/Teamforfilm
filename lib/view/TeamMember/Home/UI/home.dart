import 'package:flutter/material.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/view/TeamMember/Home/Widgets/job_card.dart';
import 'package:navin_project/view/TeamMember/Home/models/job_model.dart'; // For the blur effect

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Jobs'),
              Tab(text: 'Favorites'),
            ],
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                JobsTab(),
                FavoritesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobsTab extends StatelessWidget {
  final List<Job> jobs = [
    Job(
      title: 'Casting Call: Exciting Opportunities Await!',
      date: 'June 27, 2024',
      description:
          'Are you a talented individual with a passion for performance? Are you ready to showcase your skills to a global audience? TeamForFilm, the revolutionary platform redefining the contours of cinema, invites you to be a part of our dynamic and vibrant community.',
      imageUrl: 'assets/images/job.jpg',
    ),
    // Add more job listings here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return JobCard(job: jobs[index]);
      },
    );
  }
}

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorites Tab Content'),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/course_model.dart';
import 'course_score_form.dart';
import '../provider/courses_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.course, required this.id});

  final Course id;
  final CoursesProvider course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<CourseScore> get scores =>
      widget.course.getCourseFor(widget.id.name).scores;

  void _addScore() async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      setState(() {
        widget.course.addScore(widget.id.name, newScore);
      });
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No Scores added yet.'));

    if (scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: scores.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(scores[index].studentName),
          trailing: Text(
            scores[index].studenScore.toString(),
            style: TextStyle(
              color: scoreColor(scores[index].studenScore),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: mainColor,
        title: Text(
          widget.id.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: _addScore, icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}

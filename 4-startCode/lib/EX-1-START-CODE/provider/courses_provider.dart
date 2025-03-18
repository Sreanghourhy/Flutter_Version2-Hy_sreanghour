import '../models/course_model.dart';
import '../repository/course_mock_repository.dart';

class CoursesProvider {
  List<Course> courses = MockCoursesRepository().getCourses();
  Course getCourseFor(String courseID) {
    return courses.firstWhere((course) => course.name == courseID);
  }

  List<Course> getCourses() {
    return courses;
  }

  void addScore(String courseID, CourseScore score) {
    final course = getCourseFor(courseID);
    course.addScore(score);
  }
}

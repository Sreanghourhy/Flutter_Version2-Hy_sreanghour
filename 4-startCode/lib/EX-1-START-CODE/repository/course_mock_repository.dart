import "../models/course_model.dart";
import "courses_repository.dart";

class MockCoursesRepository extends CoursesRepository {
  final List<Course> courses = [
    Course(name: "HTML"),
    Course(name: "JAVA"),
  ];

  @override
  List<Course> getCourses() {
    return courses;
  }

  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }
}

// void main() {
//   final mockCoursesRepository = MockCoursesRepository();
//   final courses = mockCoursesRepository.getCourses();
//   final htmlCourse = courses.firstWhere((course) => course.name == "HTML");
//   const score = CourseScore(studentName: "John Doe", studenScore: 90);
//   mockCoursesRepository.addScore(htmlCourse, score);
//   print(htmlCourse.average);
// }

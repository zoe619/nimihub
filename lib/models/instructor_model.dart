import 'package:nimihub_online/models/model.dart';

class Instructor
{
    final String id;
    final String image;
    final String name;
    final String subject;
    final String courses;
    final String students;

    Instructor({this.id, this.image, this.name,this.subject,this.courses,this.students});


    factory Instructor.fromJson(Map<String, dynamic> json)
    {
        return Instructor(
            id: json['id'] as String,
            image: json['image'] as String,
            name: json['full_name'] as String,
            subject: json['subject'] as String,
            courses: json['courses'] as String,
            students: json['students'] as String,

        );
    }

}

final List<Instructors> topInstructors = [
    Instructors(
      'Jane Doe', 'assets/images/Profile Image.png', 'Biotechnology', 54, 12
    ),
    Instructors(
      'Old Boy', 'assets/images/mastercard-2.png', 'Theft Illusion', 1,0
    ),
    Instructors(
      'Allison Paul', 'assets/images/Image Popular Product 3.png', 'Trading', 24, 1
    ),
    Instructors(
      'Mark Zipper', 'assets/images/Image Popular Product 2.png', 'Ecoms', 143, 82
    ),
    Instructors(
      'Kelp Ken', 'assets/images/Image Popular Product 1.png', 'Production', 24, 33
    ),

    Instructors(
      'Emma Pilots', 'assets/images/wireless headset.png', 'Airship', 23, 2
    ),
    Instructors(
      'Naruto Uzimaki', 'assets/home/people.png', 'Shadow Clone Jitzu', 89, 17
    ),
    Instructors(
      'Jiraiya sage', 'assets/home/nature.png', 'Rassengan', 2000, 8
    ),
    Instructors(
      'Dele Wizzy', 'assets/home/webCourse1.png', 'Computer Science', 231, 2
    ),
    Instructors(
      'Nagato Akatsuki', 'assets/home/images (1).jpeg', 'Tendo sensei', 1200, 32
    ),
];
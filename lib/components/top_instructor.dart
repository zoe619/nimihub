import 'package:flutter/material.dart';
import 'package:nimihub_online/models/instructor_model.dart';
import 'package:nimihub_online/screens/exams/exams.dart';
import 'package:nimihub_online/screens/instructor/instructor_screen.dart';
import 'package:nimihub_online/screens/instructor_profile/instructor_profile.dart';
import 'package:nimihub_online/screens/me/me_screen.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:get/get.dart';

class TopInstructors extends StatelessWidget
{

  final List<Instructor> instructors;

  TopInstructors({this.instructors});
  @override
  Widget build(BuildContext context)
  {
    return Container(
        height: getProportionateScreenHeight(250),
        width: double.infinity,
        // width: getProportionateScreenWidth(),
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: instructors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.4),
            itemBuilder: (BuildContext context, int index) {
              final instructor = instructors[index];
              return GestureDetector(
                onTap: ()=>Get.to(InstuctorProfile()),
                child: Card(
                  child: Container(
                    // height: getProportionateScreenHeight(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(120),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/tshirt.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              Icon(Icons.person),
                              Text('${instructor.name}')
                            ]),
                           
                            Row(children: [
                              Icon(Icons.book),
                              Container( height: 20, width: 100,child: Text('${instructor.subject} ', overflow: TextOverflow.ellipsis,))
                            ]),
                             Row(children: [
                              Icon(Icons.person),
                              Text('${instructor.students} students')
                            ]),
                            Row(children: [
                              Icon(Icons.star),
                              Text('${instructor.courses} courses')
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

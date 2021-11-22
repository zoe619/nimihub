
import 'dart:io';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:nimihub_online/enums/difficulty.dart';
import 'package:nimihub_online/models/failure_model.dart';
import 'package:nimihub_online/models/question_model.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/essay_answer.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/service/quiz/quiz_controller.dart';
import 'package:nimihub_online/service/quiz/quiz_repository.dart';
import 'package:nimihub_online/service/quiz/quiz_state.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants.dart';




class EssayScreen extends  HookWidget
{

  final quizQuestionsProvider = FutureProvider.autoDispose<List<Question>>(
        (ref) => ref.watch(quizRepositoryProvider).getQuestions(
        examId: UserData.examId,
        typeId: UserData.type,
        year: UserData.year,
        type: UserData.questionType,
        email: UserData.email
    ),
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool show = false;

  @override
  Widget build(BuildContext context)
  {


    final quizState = useProvider(quizControllerProvider.state);

    final quizQuestions = useProvider(quizQuestionsProvider);
    final pageController = usePageController();


    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: quizQuestions.when(
          data: (questions) => _buildBody(context, pageController, questions),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong',
          ),
        ),

      ),
    );
  }



  Widget _buildBody(
      BuildContext context,
      PageController pageController,
      List<Question> questions,
      ) {
    if (questions.isEmpty) return QuizError(message: 'No questions found.');

    final quizState = useProvider(quizControllerProvider.state);
    return quizState.status == QuizStatus.complete
        ? CustomButton(title: "END OF EXAM")
        : QuizQuestions(
      pageController: pageController,
      state: quizState,
      questions: questions,
    );
  }



}

class QuizError extends StatelessWidget {
  final String message;

  const QuizError({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            title: 'Retry',
            onTap: () => context.refresh(quizRepositoryProvider),
          ),
        ],
      ),
    );
  }
}

final List<BoxShadow> boxShadow = const [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4.0,
  ),
];

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 30.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}



class QuizQuestions extends ConsumerWidget
{
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;
  bool show = false;


  QuizQuestions({
    Key key,
    @required this.pageController,
    @required this.state,
    @required this.questions,
  }) : super(key: key);

  final isRestart = StateProvider((ref)=>false);
  final isPause = StateProvider((ref)=>false);

  final _controller = CountdownController();

  var unescape = HtmlUnescape();

  _submit(String questionId, String examId, String questionType, String year, String course, String user) async
  {

    try
    {


      DatabaseService db = new DatabaseService();
      List res = await db.addBookMark(questionId, examId, questionType, year, course, user);

      Map<String, dynamic> map;



      for(int i = 0; i < res.length; i++)
      {
        map = res[i];

      }

      if(map['status'] == "Failed")
      {

        Get.snackbar('Hi', map['msg'],
            backgroundColor: Colors.yellow, colorText: Colors.black);


      }else{

        Get.snackbar('Hi', map['msg'],
            backgroundColor: Colors.yellow, colorText: Colors.black);
      }

    }
    on PlatformException catch (err) {
      print(err.message);
    }

  }

  _delete(String questionId, String user) async
  {

    try
    {


      DatabaseService db = new DatabaseService();
      List res = await db.deleteBookMark(questionId, user);

      Map<String, dynamic> map;



      for(int i = 0; i < res.length; i++)
      {
        map = res[i];

      }

      if(map['status'] == "Failed")
      {

        Get.snackbar('Hi', map['msg'],
            backgroundColor: Colors.yellow, colorText: Colors.black);


      }else{

        Get.snackbar('Hi', map['msg'],
            backgroundColor: Colors.yellow, colorText: Colors.black);
      }

    }
    on PlatformException catch (err) {
      print(err.message);
    }

  }

  Question qt;

  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object, T> provider) watch)
  {
    final restart = watch(isRestart).state;
    final pause = watch(isPause).state;
    final IconData = restart ? Icons.refresh : (pause ? Icons.pause : Icons.play_arrow);

    return PageView.builder(

      controller: pageController,
//      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      pageSnapping: false,
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index)
      {

        final question = questions[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
              child: Flexible(
                child: Text(
                  HtmlCharacterEntities.decode(question.essay),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  softWrap: true,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              height: 32.0,
              thickness: 2.0,
              indent: 20.0,
              endIndent: 20.0,
            ),

           index > 0 || UserData.bookmark == "yes" ? Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EssayAnswerScreen(answer: question.correctAnswer)));
                    },
                    child: Text('View Answer',
                        style: TextStyle(
                            fontSize: 15.0, color: Colors.black)),
                  ),
                ),
              ),
            ) : SizedBox.shrink(),
            SizedBox(height: 20.0),
            index > 0 || UserData.bookmark == "yes" ?
            UserData.bookmark == "no" ?
            GestureDetector(
              onTap: (){
                _submit(question.id, UserData.examId.toString(),
                    UserData.type, UserData.year, UserData.course, UserData.email);
              },
              child: Text('Bookmark', style: TextStyle(
                  color: Colors.white
              ),),
            ) : GestureDetector(
              onTap: (){
                _delete(question.id, UserData.email);
              },
              child: Text('UnBookmark', style: TextStyle(
                  color: Colors.white
              ),),
            ): SizedBox.shrink()
          ],
        );
      },

    );

  }



}

class AnswerCard extends StatelessWidget
{
  final String answer;

  const AnswerCard({
    Key key,
    @required this.answer,

  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CircularIcon extends StatelessWidget
{
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key key,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }


}

import 'dart:io';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:nimihub_online/enums/difficulty.dart';
import 'package:nimihub_online/models/failure_model.dart';
import 'package:nimihub_online/models/question_model.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/answer_review.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/service/quiz/quiz_controller.dart';
import 'package:nimihub_online/service/quiz/quiz_repository.dart';
import 'package:nimihub_online/service/quiz/quiz_state.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants.dart';




class AnswerReviewScreen extends  HookWidget
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
        bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = useProvider(quizControllerProvider.state);
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
              title: pageController.page.toInt() + 1 < questions.length
                  ? 'Next Question'
                  : '',
              onTap: () {
                context
                    .read(quizControllerProvider)
                    .nextQuestion(questions, pageController.page.toInt());
                if (pageController.page.toInt() + 1 < questions.length) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear,
                  );
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
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
    return QuizQuestions(
      pageController: pageController,
      state: quizState,
      questions: questions,
    );
  }

  _showResult(String questions, String correct)
  {
    return _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 2),
          content:
          new Row(
            children: <Widget>[
              Text("Total Score: ${correct + "/" + questions}")
            ],
          ),
          action: new SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
        ));
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

class QuizResults extends StatelessWidget
{
  final QuizState state;
  final List<Question> questions;

  const QuizResults({
    Key key,
    @required this.state,
    @required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.correct.length} / ${questions.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
//        CustomButton(
//          title: 'New Quiz',
//          onTap: () {
//            context.refresh(quizRepositoryProvider);
//            context.read(quizControllerProvider).reset();
//          },
//        ),
      ],
    );
  }


}

class QuizQuestions extends ConsumerWidget
{
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;


  QuizQuestions({
    Key key,
    @required this.pageController,
    @required this.state,
    @required this.questions,
  }) : super(key: key);

  final isRestart = StateProvider((ref)=>false);
  final isPause = StateProvider((ref)=>false);

  final _controller = CountdownController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  var unescape = HtmlUnescape();



  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object, T> provider) watch)
  {
    final restart = watch(isRestart).state;
    final pause = watch(isPause).state;
    final IconData = restart ? Icons.refresh : (pause ? Icons.pause : Icons.play_arrow);

    return PageView.builder(

      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
//      scrollDirection: Axis.vertical,
      pageSnapping: false,
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index)
      {

        final question = questions[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kDefaultPadding),
            Text(
              'Question ${index + 1} of ${questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
              child: Flexible(
                child: Text(
                  question.question,
                  style: TextStyle(
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
            Column(
              children: [
               AnswerCard(correctAnswer: question.correctAnswer,
                 onTap: () => context
                     .read(quizControllerProvider)
                     .submitAnswer(question, ''),
               )],
        ),
        ]);
      },

    );

  }
}

class AnswerCard extends StatelessWidget
{
  final String correctAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key key,
    @required this.correctAnswer,
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: onTap,
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
                HtmlCharacterEntities.decode(correctAnswer),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
                softWrap: true,
                maxLines: 5,
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
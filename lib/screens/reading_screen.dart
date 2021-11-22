
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:nimihub_online/models/failure_model.dart';
import 'package:nimihub_online/models/subTopics.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/essay_answer.dart';
import 'package:nimihub_online/service/notes/note_repository.dart';
import 'package:nimihub_online/service/notes/notes_controller.dart';
import 'package:nimihub_online/service/notes/notes_state.dart';
import 'package:nimihub_online/service/quiz/quiz_controller.dart';
import 'package:nimihub_online/service/quiz/quiz_repository.dart';

import '../constants.dart';




class ReadingScreen extends  HookWidget
{

  final notesProvider = FutureProvider.autoDispose<List<SubTopic>>(
        (ref) => ref.watch(notesRepositoryProvider).getNotes(
        topicId: UserData.examId
    ),
  );
  final String chapterContent;
  ReadingScreen({this.chapterContent});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool show = false;

  @override
  Widget build(BuildContext context)
  {


    final quizState = useProvider(notesControllerProvider.state);

    final readingNotes = useProvider(notesProvider);
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
//        backgroundColor: Colors.transparent,
        body: readingNotes.when(
          data: (notes) => _buildBody(context, pageController, notes),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong',
          ),
        )


      ),

    );
  }



  Widget _buildBody
      (
      BuildContext context,
      PageController pageController,
      List<SubTopic> notes,
      )
  {
    if (notes.isEmpty) return QuizError(message: 'No Notes found.');
    final noteState = useProvider(notesControllerProvider.state);
    return noteState.status == NotesStatus.complete
        ? CustomButton(title: "END OF READING")
         : ReadingPage(
      pageController: pageController,
      state:noteState,
      notes: notes
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



class ReadingPage extends ConsumerWidget
{
  final PageController pageController;
  final List<SubTopic> notes;
  final NotesState state;
  bool show = false;

  ReadingScreen sc = new ReadingScreen();


  ReadingPage({
    Key key,
    @required this.pageController,
    @required this.notes,
    @required this.state
  }) : super(key: key);



  var unescape = HtmlUnescape();


  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object, T> provider) watch)
  {

    return PageView.builder(

      controller: pageController,
//      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      pageSnapping: false,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index)
      {

        final note = notes[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
                  HtmlCharacterEntities.decode('Chapter Content:'),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  softWrap: true,
                ),
            SizedBox(height: 4.0),
            index == 0 ? Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
              child: Flexible(
                child: Text(
                  HtmlCharacterEntities.decode(UserData.chapterContent),
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  softWrap: true,
                ),
              ),
            ) :SizedBox.shrink(),
            SizedBox(height: kDefaultPadding),
            Text(
              HtmlCharacterEntities.decode(note.topic),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 10,
              softWrap: true,
            ),
            SizedBox(height: kDefaultPadding),
             Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
              child: Flexible(
                child: Text(
                  HtmlCharacterEntities.decode(note.description),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  softWrap: true,
                ),
              ),
            )


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
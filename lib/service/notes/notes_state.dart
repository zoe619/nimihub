import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nimihub_online/models/question_model.dart';

enum NotesStatus { initial, correct, incorrect, complete }

class NotesState extends Equatable
{
  final String selectedAnswer;
  final List<Question> correct;
  final List<Question> incorrect;
  final NotesStatus status;

  bool get answered =>
      status == NotesStatus.incorrect || status == NotesStatus.correct;

  const NotesState({
    @required this.selectedAnswer,
    @required this.correct,
    @required this.incorrect,
    @required this.status,
  });

  factory NotesState.initial()
  {
    return NotesState(
      selectedAnswer: '',
      correct: [],
      incorrect: [],
      status: NotesStatus.initial,
    );
  }

  @override
  List<Object> get props => [
    selectedAnswer,
    correct,
    incorrect,
    status
  ];

}

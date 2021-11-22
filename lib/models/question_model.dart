import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Question extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final String essay;
  final String id;
  final String course;
  final List<String> answers;


  const Question({
    @required this.category,
    @required this.difficulty,
    @required this.question,
    @required this.correctAnswer,
    this.id,
    this.course,
    this.essay,
    @required this.answers,

  });

  @override
  List<Object> get props => [
    category,
    difficulty,
    question,
    correctAnswer,
    answers,
  ];

  factory Question.fromMap(Map<String, dynamic> map)
  {
    if (map == null) return null;
    return Question(
      category: map['question_type'] ?? '',
      difficulty: map['exam_id'] ?? '',
      question: map['question'] ?? '',
        essay: map['essay'] ?? '',
      correctAnswer: map['correct_answer'] ?? '',
      answers: List<String>.from(map['incorrect_answers'] ?? []),
      id: map['id'] ?? '',
      course: map['course'] ?? ''
    );
  }
}

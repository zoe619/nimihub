
import 'package:nimihub_online/models/question_model.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions({
    int examId,
    String typeId,
    String year
  });
}

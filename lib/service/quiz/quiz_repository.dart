import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:nimihub_online/enums/difficulty.dart';
import 'package:nimihub_online/models/failure_model.dart';
import 'package:nimihub_online/models/question_model.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/service/quiz/base_quiz_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRepository
{
  final Reader _read;

  QuizRepository(this._read);

  String url;

//  String url = 'https://opentdb.com/api.php';
  @override
  Future<List<Question>> getQuestions({
    @required int examId,
    @required String typeId,
    @required String year,
    String email,
    String type,
    String bookMark
  })
  async {
    var queryParameters;
    try {
      if(UserData.bookmark == 'yes')
      {
        queryParameters = {
          'email': email,
          'type': type

        };
        url = "https://fetch.nimihub.com/dele/api/services/getBookMarks.php";
      }else{
        queryParameters = {
          '_id': examId,
          '_row': 'exam_id',
          '_id2': typeId,
          '_row2':'question_type',
          '_row3':'year',
          '_id3':year
        };
        url = "https://fetch.nimihub.com/dele/api/services/questions.php";
      }



      final response = await _read(dioProvider).get(
        url,
        queryParameters: queryParameters
      );

      if (response.statusCode == 200)
      {

        final results = json.decode(response.data);

        if (results.isNotEmpty)
        {
          return results.map<Question>((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err)
    {
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );

    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}

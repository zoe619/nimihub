

import 'package:nimihub_online/models/subTopics.dart';

abstract class BaseNotesRepository {
  Future<List<SubTopic>> getNotes({
    int topicId
  });
}

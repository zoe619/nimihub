import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:http/http.dart' as http;
import 'package:nimihub_online/models/books.dart';
import 'package:nimihub_online/models/chapters.dart';
import 'package:nimihub_online/models/courses.dart';
import 'package:nimihub_online/models/examModel.dart';
import 'package:nimihub_online/models/instructor_model.dart';
import 'package:nimihub_online/models/itemsCount.dart';
import 'package:nimihub_online/models/lesson.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/subTopics.dart';
import 'package:nimihub_online/models/topics.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/wish.dart';
import 'package:nimihub_online/utilities/constants.dart';
import 'package:uuid/uuid.dart';

class DatabaseService
{
  static const ROOT = "http://192.168.0.178/EMPLOYEE/employee_actions.php";
  static const _CREATE_TABLE_ACTION = "CREATE_TABLE";


  static const _DELETE_EMP = "DELETE_EMP";


  static DatabaseService user;

  static Future<String> createTable()async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;

      final response = await http.post(ROOT, body: map);

      if(response.statusCode == 200){
        return response.body;
      }
      else{
        return "error";
      }

    }
    catch(err){
      return "error";
    }
  }





  Future<List<Product>> getCourses()async
  {


    try{

//      String url = "https://nimihub.com/new_mobile/pizza/getCourses";
      String url = "https://fetch.nimihub.com/dele/api/services/courses?table=course";
      http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Product> list = parseResponseProducts(response.body);
        return list;

      }
      else{
        return  List<Product>();
      }

    }
    catch(err)
    {
      return List<Product>();
    }
  }

  Future<List<ExamModel>> getExams()async
  {


    try{

      String url = "https://fetch.nimihub.com/dele/api/services/examList.php";
      http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<ExamModel> list = parseResponseExams(response.body);
        return list;

      }
      else{
        return  List<ExamModel>();
      }

    }
    catch(err)
    {
      return List<ExamModel>();
    }
  }

  Future<List<Instructor>> getInstructors()async
  {


    try{

      String url = "https://fetch.nimihub.com/dele/api/services/authorList.php";
      http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Instructor> list = parseResponseInstructors(response.body);
        return list;

      }
      else{
        return  List<Instructor>();
      }

    }
    catch(err)
    {
      return List<Instructor>();
    }
  }

  Future<List<Wishes>> getWishes(String email)async
  {
    var map = Map<String, dynamic>();
    map['email'] = email;

    try{

      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/getWishes.php";



      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Wishes> list = parseResponseWishes(response.body);
        return list;

      }
      else{
        return  List<Wishes>();
      }

    }
    catch(err){
      return List<Wishes>();
    }
  }

  Future<List<Books>> getBooks()async
  {


    try{

      String url = "https://fetch.nimihub.com/dele/api/services/books.php";
      http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Books> list = parseResponseBooks(response.body);
        return list;

      }
      else{
        return  List<Books>();
      }

    }
    catch(err)
    {
      return List<Books>();
    }
  }

  Future<List<Lesson>> getLessons(String courseId)async
  {

    var map = Map<String, dynamic>();
    map['courseId'] = courseId;

    try{

      String url = "https://fetch.nimihub.com/dele/api/services/getLesson.php";
      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Lesson> list = parseResponseLesson(response.body);
        return list;

      }
      else{
        return  List<Lesson>();
      }

    }
    catch(err)
    {
      return List<Lesson>();
    }
  }
  List<Courses> parseResponseCourses(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Courses>((json)=>Courses.fromJson(json)).toList();

  }
  List<Product> parseResponseProducts(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json)=>Product.fromJson(json)).toList();

  }
  List<ExamModel> parseResponseExams(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ExamModel>((json)=>ExamModel.fromJson(json)).toList();

  }

  List<Wishes> parseResponseWishes(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Wishes>((json)=>Wishes.fromJson(json)).toList();

  }

  List<Instructor> parseResponseInstructors(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Instructor>((json)=>Instructor.fromJson(json)).toList();

  }
  List<Books> parseResponseBooks(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Books>((json)=>Books.fromJson(json)).toList();

  }

  List<Lesson> parseResponseLesson(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Lesson>((json)=>Lesson.fromJson(json)).toList();

  }
  Future<List<ExamModel>> getExamsByUser(String email)async
  {
    var map = Map<String, dynamic>();
    map['id'] = email;
    map['row'] = 'email';

    try{

//      String url = "https://nimihub.com/new_mobile/pizza/getCourses";
      String url = "https://fetch.nimihub.com/dele/api/services/getExamList.php";
      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<ExamModel> list = parseResponseExams(response.body);
        return list;

      }
      else{
        return  List<ExamModel>();
      }

    }
    catch(err)
    {
      return List<ExamModel>();
    }
  }

  Future<List<Books>> getBooksByUser(String email)async
  {
    var map = Map<String, dynamic>();
    map['id'] = email;
    map['row'] = 'email';

    try{

//      String url = "https://nimihub.com/new_mobile/pizza/getCourses";
      String url = "https://fetch.nimihub.com/dele/api/services/getBookList.php";
      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Books> list = parseResponseBooks(response.body);
        return list;

      }
      else{
        return  List<Books>();
      }

    }
    catch(err)
    {
      return List<Books>();
    }
  }

  Future<List<Product>> getCoursesByUser(String email)async
  {
    var map = Map<String, dynamic>();
    map['id'] = email;
    map['row'] = 'email';
    try{

//      String url = "https://nimihub.com/new_mobile/pizza/getCoursesByUser.php";

      String url = "https://fetch.nimihub.com/dele/api/services/getCourseOrders.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Product> list = parseResponseProducts(response.body);
        return list;

      }
      else{
        return  List<Product>();
      }

    }
    catch(err){
      return List<Product>();
    }
  }

  Future<List<Courses>> getViewedCoursesByUser(String email)async
  {
    var map = Map<String, dynamic>();
    map['id'] = email;
    map['row'] = 'email';
    try{

//      String url = "https://nimihub.com/new_mobile/pizza/getCoursesByUser.php";

      String url = "https://fetch.nimihub.com/dele/api/services/getViewedCourses.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Courses> list = parseResponseCourses(response.body);
        return list;

      }
      else{
        return  List<Courses>();
      }

    }
    catch(err){
      return List<Courses>();
    }
  }

  Future<List<ItemCount>> getItemCountsByUser(String email)async
  {
    var map = Map<String, dynamic>();
    map['id'] = email;
    map['row'] = 'email';
    try{


      String url = "https://fetch.nimihub.com/dele/api/services/getItemCounts.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<ItemCount> list = parseResponseItem(response.body);
        return list;

      }
      else{
        return  List<ItemCount>();
      }

    }
    catch(err){
      return List<ItemCount>();
    }
  }

  Future<List<Chapter>> getChapters(String bookId)async
  {
    var map = Map<String, dynamic>();
    map['_id'] = bookId;
    map['_row'] = 'note';
    map['table'] = 'chapter';
    try{


      String url = "https://fetch.nimihub.com/dele/api/services/chapters.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Chapter> list = parseResponseChapters(response.body);
        return list;

      }
      else{
        return  List<Chapter>();
      }

    }
    catch(err){
      return List<Chapter>();
    }
  }

  Future<List<Topic>> getTopics(String chapterId)async
  {
    var map = Map<String, dynamic>();
    map['_id'] = chapterId;
    map['_row'] = 'chapter';
    map['table'] = 'topic';
    try{


      String url = "https://fetch.nimihub.com/dele/api/services/topics.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<Topic> list = parseResponseTopic(response.body);
        return list;

      }
      else{
        return  List<Topic>();
      }

    }
    catch(err){
      return List<Topic>();
    }
  }

  Future<List<SubTopic>> getSubTopics(String topicId)async
  {
    var map = Map<String, dynamic>();
    map['_id'] = topicId;
    map['_row'] = 'topic';
    map['table'] = 'subtopic';
    try{


      String url = "https://fetch.nimihub.com/dele/api/services/sub-topics.php";

      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(response.statusCode == 200)
      {

        List<SubTopic> list = parseResponseSubTopic(response.body);
        return list;

      }
      else{
        return  List<SubTopic>();
      }

    }
    catch(err){
      return List<SubTopic>();
    }
  }
  List<ItemCount> parseResponseItem(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ItemCount>((json)=>ItemCount.fromJson(json)).toList();

  }

  List<Chapter> parseResponseChapters(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Chapter>((json)=>Chapter.fromJson(json)).toList();

  }
  List<Topic> parseResponseTopic(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Topic>((json)=>Topic.fromJson(json)).toList();

  }
  List<SubTopic> parseResponseSubTopic(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SubTopic>((json)=>SubTopic.fromJson(json)).toList();

  }





  addUser(String name, String email, String password, String phone, String username )async{
    try{

      var map = Map<String, dynamic>();
      map['name'] = name;
      map['email'] = email;
      map['password'] = password;
      map['phone'] = phone;
      map['username'] = username;

      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/signup.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else{
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }

  addWishes(String email, String item, String itemId, String itemType, String created, String modified )async{
    try{

      var map = Map<String, dynamic>();

      map['email'] = email;
      map['item'] = item;
      map['itemId'] = itemId;
      map['itemType'] = itemType;
      map['created'] = created;
      map['modified'] = modified;

      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/addWishes.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else{
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }

  addReviews(String email, String comment, String rating, String itemId, String itemType)async
  {
    try{

      var map = Map<String, dynamic>();


      map['email'] = email;
      map['comment'] = comment;
      map['rating'] = rating;
      map['itemId'] = itemId;
      map['itemType'] = itemType;



      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/addReviews.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else{
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }

  addViewedCourse(String email,String itemId )async{
    try{

      var map = Map<String, dynamic>();

      map['email'] = email;
      map['itemId'] = itemId;


      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/addViewedCourses.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else{
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }

  addBookMark(String questionId, String examId, String questionType, String year, String course, String user )async
  {
    try{

      var map = Map<String, dynamic>();

      map['questionId'] = questionId;
      map['examId'] = examId;
      map['questionType'] = questionType;
      map['year'] = year;
      map['course'] = course;
      map['user'] = user;

      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/addBookmark.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else
        {
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }

  deleteBookMark(String questionId, String user) async
  {
    try{

      var map = Map<String, dynamic>();

      map['questionId'] = questionId;
      map['user'] = user;

      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/deleteBookmark.php";
      http.Response res = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);

        return result;
      }
      else
      {
        var error = json.decode(res.body);

        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }


  buyCourse(List<Product>items, String sum)async{
    try{


      var map = Map<String, dynamic>();
      map['item'] = items.toString();
      map['cost'] = sum;
      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/buy.php";
      http.Response res = await http.post(Uri.encodeFull(url),
          headers: {"Accept": "application/json"},

          body: json.encode({
            'id': DateTime.now().toString(),
            'cost': sum,
            'item': items
                .map((cp) =>
            {
              'id': cp.id,
              'title': cp.title,
              'quantity': cp.quantity,
              'price': cp.price
            }).toList()
          }),
        );

      if(res.statusCode == 200)
      {
        List result = json.decode(res.body);
        return result;
      }
      else{
        var error = json.decode(res.body);
        return error;
      }

    }
    catch(err){
      return err.toString();
    }
  }


  updateUser(String name, String phone, String username,String state,String gender,String dob)async
  {

    try{
      var map = Map<String, dynamic>();
      map['phone'] = phone;
      map['name'] = name;
      map['username'] = username;
      map['state'] = state;
      map['gender'] = gender;
      map['dob'] = dob;
      String url = "https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/update.php";
      http.Response response = await http.post(Uri.encodeFull(url), body: map, headers: {"Accept": "application/json"});
      if(response.statusCode == 200)
      {
        List result = json.decode(response.body);

        return result;
      }
      else{

        var error = json.decode(response.body);

        return error;
      }


    }
    catch(err)
    {
      return err.toString();
    }

  }






  static Future<String> deleteUser(int id)async
  {

    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);

      if(response.statusCode == 200){
        return response.body;
      }
      else{
        return "error";
      }

    }
    catch(err){
      return "error";
    }

  }

  //   function to retrieve user from firestore based on userId
  Future<Users> getUser(String userId) async
  {

    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    return Users.fromDoc(userDoc);
  }


  Future<Map<String, dynamic>> getUserDetails(String id) async{
    Users user = await getUser(id);
    Map<String, dynamic> userMap =
    {
      'name': user.name,
      'email': user.email,
      'phone': user.phone
    };
    return userMap;
  }

  //   function to retrieve user from firestore based on userId
  Future<Users> getUserWithId(String userId) async
  {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId).get();
    if(userDocSnapshot.exists)
    {
      return Users.fromDoc(userDocSnapshot);
    }
    return Users();

  }

  getUserWithEmail(String email) async
  {

    return usersRef.where('email', isEqualTo: email).get();

  }

  static void updateUserFirebase(Users user)
  {
    usersRef.doc(user.id).update({
      'name' : user.name,
      'phone':user.phone,
      'state':user.state,
      'gender':user.gender,
      'dob':user.dob

    });
  }

  static void updateWallet(Users user)
  {
    usersRef.doc(user.id).update({

    });
  }

  String getUserId(String email)
  {

    String id;
    FirebaseFirestore.instance
        .collection('users').where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc)
      {

        id = doc.id;

      })
    });
    return id;
  }







}
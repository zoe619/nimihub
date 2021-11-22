class Model {
  final String image;
  final String title;
  final String instructor;
  final double rating;
  final double oldAmount;
  final double newAmount;
  final String enrolled;
  final double money;
  Model(this.image, this.title, this.instructor, this.rating, this.oldAmount,
      this.newAmount, this.enrolled, this.money);
}

class Category {
  final String text;

  Category(this.text);
}

class Searches {
  final String text;

  Searches(this.text);
}

class SearchModel {
  final String image;
  final String title;
  final String instructor;
  final double rating;
  final double oldAmount;
  final double newAmount;
  final String enrolled;
  final double money;
  final String category;

  SearchModel(this.image, this.title, this.instructor, this.rating,
      this.oldAmount, this.newAmount, this.enrolled, this.money, this.category);
}

class Instructors {
  final String name;
  final String image;
  final String course;
  final int students;
  final int numcourses;

  Instructors(this.name, this.image, this.course, this.students, this.numcourses); 
}

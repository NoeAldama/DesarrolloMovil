import 'package:flutter_application_2/Person.dart';

class Student extends Person{


  String enrollment;
  Student(String name, this.enrollment) : super (name);
  //Student({required String name,required this.enrollment}) : super(name);
}
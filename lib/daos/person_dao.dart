import 'package:floor/floor.dart';
import 'package:flutter_demo/models/person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM person')
  Future<List<Person>> findAllPerson();

  @Query('SELECT name FROM person')
  Stream<List<String>> findAllPersonName();

  @Query('SELECT * FROM person WHERE id = :id')
  Stream<Person?> findAllPersonById(int id);

  @insert
  Future<void> insertPerson(Person person);
}

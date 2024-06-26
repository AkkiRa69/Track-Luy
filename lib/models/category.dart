import 'package:isar/isar.dart';
part 'category.g.dart';

@Collection()
class Categori {
  Id id = Isar.autoIncrement;
  late String emoji;
  late String name;
}

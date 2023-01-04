import 'package:hive/hive.dart';


part 'local_user_model.g.dart';

@HiveType(typeId: 0)
class CashedUserModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String token;
  @HiveField(3)
  late String? weightId;
  @HiveField(4)
  late String weight;
  @HiveField(5)
  late String time;
}

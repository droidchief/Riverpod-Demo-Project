import 'package:riverpod_demo_project/domain/model/user.dart';
import 'package:riverpod_demo_project/domain/model/new_user.dart';

abstract class UserRepository {
  Future<List<User>>getUserList();
  Future<NewUser>addNewUser(String name, String job);
  Future<NewUser>updateUser(String id, String name, String job);
  Future<void>deleteUser(String id);
}
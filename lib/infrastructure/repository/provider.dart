import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_project/domain/repository/user_repository.dart';
import 'package:riverpod_demo_project/infrastructure/repository/user_repository_impl.dart';

final userListProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

final addNewUserProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

final updateUserProvider = Provider<UserRepository>((ref){
  return UserRepositoryImpl();
});

final deleteUserProvider = Provider<UserRepository>((ref){
  return UserRepositoryImpl();
});
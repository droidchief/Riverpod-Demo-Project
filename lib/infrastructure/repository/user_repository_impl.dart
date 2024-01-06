import 'package:dio/dio.dart';
import 'package:riverpod_demo_project/core/internet_services/dio_client.dart';
import 'package:riverpod_demo_project/domain/model/new_user.dart';
import 'package:riverpod_demo_project/domain/model/user.dart';
import 'package:riverpod_demo_project/domain/repository/user_repository.dart';

import '../../core/internet_services/paths.dart';

class UserRepositoryImpl implements UserRepository{

  @override
  Future<NewUser> addNewUser(String name, String job) async {
    try{
      final response = await DioClient.instance.post(
        users,
        data: {
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    }on DioError catch(e){
      var error = DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<void> deleteUser(String id) async{
    try{
      await DioClient.instance.delete('$users/$id');
    }on DioError catch(e){
      var error = DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<List<User>> getUserList() async {
    try {
      final response = await DioClient.instance.get(users);
      final userList = (response["data"] as List).map((e) => User.fromJson(e)).toList();
      return userList;
    }on DioError catch(e){
      var error = DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<NewUser> updateUser(String id, String name, String job)async {
    try{
      final response = await DioClient.instance.put(
        '$users/$id',
        data: {
          'id': id,
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    }on DioError catch(e){
      var error = DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}

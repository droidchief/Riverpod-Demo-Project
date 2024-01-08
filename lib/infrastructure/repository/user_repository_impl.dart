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
    }on DioException catch(e){
      // var error = DioException.fromDioError(e);
      // throw error.errorMessage;
      if (e.response != null) {
        // DioErrorType.RESPONSE
        print('Dio error with response');
        print(e.response!.data);
        throw 'Error: ${e.response!.data}';
      } else {
        // DioErrorType.DEFAULT or DioErrorType.CONNECT_TIMEOUT, DioErrorType.RECEIVE_TIMEOUT, DioErrorType.SEND_TIMEOUT
        print('Dio error without response');
        throw 'Error: ${e.message}';
      }
    }
  }

  @override
  Future<void> deleteUser(String id) async{
    try{
      await DioClient.instance.delete('$users/$id');
    }on DioException catch(e){
      // var error = DioException.fromDioError(e);
      // throw error.errorMessage;

      if (e.response != null) {
        // DioErrorType.RESPONSE
        print('Dio error with response');
        print(e.response!.data);
        throw 'Error: ${e.response!.data}';
      } else {
        // DioErrorType.DEFAULT or DioErrorType.CONNECT_TIMEOUT, DioErrorType.RECEIVE_TIMEOUT, DioErrorType.SEND_TIMEOUT
        print('Dio error without response');
        throw 'Error: ${e.message}';
      }
    }
  }

  @override
  Future<List<User>> getUserList() async {
    try {
      final response = await DioClient.instance.get(users);
      final userList = (response["data"] as List).map((e) => User.fromJson(e)).toList();
      return userList;
    }on DioException catch(e){
      // var error = DioException.fromDioError(e);
      // throw error.errorMessage;

      if (e.response != null) {
        // DioErrorType.RESPONSE
        print('Dio error with response');
        print(e.response!.data);
        throw 'Error: ${e.response!.data}';
      } else {
        // DioErrorType.DEFAULT or DioErrorType.CONNECT_TIMEOUT, DioErrorType.RECEIVE_TIMEOUT, DioErrorType.SEND_TIMEOUT
        print('Dio error without response');
        throw 'Error: ${e.message}';
      }
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
    }on DioException catch(e){
      // var error = DioException.fromDioError(e);
      // throw error.errorMessage;

      if (e.response != null) {
        // DioErrorType.RESPONSE
        print('Dio error with response');
        print(e.response!.data);
        throw 'Error: ${e.response!.data}';
      } else {
        // DioErrorType.DEFAULT or DioErrorType.CONNECT_TIMEOUT, DioErrorType.RECEIVE_TIMEOUT, DioErrorType.SEND_TIMEOUT
        print('Dio error without response');
        throw 'Error: ${e.message}';
      }
    }
  }
}

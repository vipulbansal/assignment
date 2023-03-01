import 'package:flutter/material.dart';
import 'package:vipul_assignment/models/user_model.dart';
import '../network/base_network.dart';

class ApiProvider {
  Future<dynamic> fetchUsers(BuildContext context,) async {
    try {
      var responseBean = await BaseNetwork(
        context,
      ).retrofit.getUsers();
      if (responseBean.response.statusCode == 200) {
        List<dynamic> result = responseBean.data;
        List<UserModel> users = [];
        result.forEach((element) {
          users.add(UserModel.fromJson(element));
        });
        return users;
      } else {
        return "server error";
      }
    } catch (error) {
      print(
          "------------------------------------------------------------------------------------------\n$error\n------------------------------------------------------------------------------------------");
      return "We are unable to fetch your data, please try again later.";
    }
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageModel{
  final storage=const FlutterSecureStorage();

  saveToken(String token)async{
    storage.read(key: token);
  }

  Future<String?>? readToken()async{
   final String? token=await storage.read(key: 'token');
   return token;
  }
}
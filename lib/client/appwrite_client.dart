import 'package:appwrite/appwrite.dart';
import 'package:uuid/uuid.dart';

class AppWriteClient {
  static Future<String> signUpUser(
      dynamic email, dynamic password, dynamic name, Client client) async {
    var v4Id = const Uuid().v4();
    Account account = Account(client);

    try {
      await account.create(
          userId: v4Id, email: email, password: password, name: name);
    } on AppwriteException catch (e) {
      print(e.message);
      if (e.message != null) {
        return e.message!;
      } else {
        return 'An error has occurred. Please try again later.';
      }
    } catch (e) {
      return 'An error has occurred. Please try again later.';
    }
    return 'success';
  }

  static Future<String> logInUser(
      dynamic email, dynamic password, Client client) async {
    Account account = Account(client);

    try {
      await account.createEmailSession(email: email, password: password);
    } on AppwriteException catch (e) {
      print(e.message);
      if (e.message != null) {
        return e.message!;
      } else {
        return 'An error has occurred. Please try again later.';
      }
    } catch (e) {
      return 'An error has occurred. Please try again later.';
    }
    return 'success';
  }
}

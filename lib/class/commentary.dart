import 'user.dart';

class Commentary {
  User user;
  String text;
  int id;
  double rating;

  Commentary(this.user, this.text, this.id, this.rating);

  String showCommentary() {
    return "${user.name}: $text";
  }
}

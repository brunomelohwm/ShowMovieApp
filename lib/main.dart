import 'package:flutter/cupertino.dart';
import 'package:show_movie_app/app_widget.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MovieApp());
}

// class Paths {
//   static const String student = '/student';
//   static const String search = '/search';
//   static const String login = '/login';
//   static const String splash = '/splash';
// }

enum PathEnum {
  student(path: '/student'),
  search(path: '/search'),
  login(path: '/login'),
  splash(path: '/splash');

  const PathEnum({
    required String path,
  }) : _path = path;

  final String _path;

  String get path => _path;
}

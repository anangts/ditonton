import 'dart:io';

String tvReadJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/features/tv/$name').readAsStringSync();
}

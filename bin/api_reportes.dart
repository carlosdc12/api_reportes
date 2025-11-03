import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();
  final reports = [];
  final users = [
    {"name": "Angel", "age": 35, "phone": "6121234567"},
    {"name": "Jesus", "age": 55, "phone": "6121234569"},
  ];

  router.get('/hello', (Request request) {
    return Response.ok('Hello, World:');
  });

  router.get('/reports', (Request request) {
    final jsonResponse = jsonEncode(reports);
    return Response.ok(
      jsonResponse,
      headers: {'content-type': 'application/json'},
    );
  });

  router.get('/users', (Request request) {
    final jsonResponse = jsonEncode(users);
    return Response.ok(
      jsonResponse,
      headers: {'content-type': 'application/json'},
    );
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  await io.serve(handler, 'localhost', 8080);
  print('El servidor esta corriendo en el puerto 8080');
}

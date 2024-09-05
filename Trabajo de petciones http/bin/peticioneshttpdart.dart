import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post.dart';

void main() async {
  // URL de la API
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  //https://jsonplaceholder.typicode.com/users

  // Realizar la petición GET
  final response = await http.get(url);

  print(response);

  // Verificar si la petición fue exitosa
  if (response.statusCode == 200) {
    // Parsear la respuesta JSON a una lista
    List<dynamic> jsonData = json.decode(response.body);

    // Crear una lista de Post
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    // Mostrar los datos
    users.forEach((user) {
      print('Id: ${user.id}');
      print('Nombre: ${user.name}');
      print('Nombre de usuario: ${user.username}');
      print('Correo: ${user.email}');
      print('---');
    });

    //Mostrar usuarios con mas de 6 caracteres
    print("-------Usuarios con mas de 6 caracteres--------");
    usuarioscon6caracteres(response);
    //Muestra la cantidad de usuarios con el dominio de biz
    print("-------Cantidad de usuarios con dominio en biz--------");
    print(contaruseriosbiz(response));
  } else {
    // Manejo de errores
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

usuarioscon6caracteres(response) {
  List<dynamic> jsonData = json.decode(response.body);

  List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

  users.forEach((user) {
    if (user.username.length > 6) {
      print('Id: ${user.id}');
      print('Nombre: ${user.name}');
      print('Nombre de usuario: ${user.username}');
      print('Correo: ${user.email}');
      print('---');
    }
  });
}

int contaruseriosbiz(response) {
  int cont = 0;
  List<dynamic> jsonData = json.decode(response.body);
  List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

  users.forEach((user) {
    if (user.email.endsWith("biz")) {
      cont = cont + 1;
    }
  });
  return (cont);
}

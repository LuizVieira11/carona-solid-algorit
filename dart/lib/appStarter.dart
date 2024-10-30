import 'dart:io';

import 'User.dart';
import 'logic.dart';

void main() {
  List<User> passageiros = [];
  List<User> motoristas = [];
  Map<User, List<User>> arestas = {};
  // C:\\Users\\Luiz Gustav\\Desktop\\Programas\\carona-solid-algorit\\dart\\data\\users_efficiencyTest.txt
  //C:\\dev\\Blocos de notas\\carona-solid-algorit\\dart\\data\\users.txt
  String path =
      'C:\\dev\\Blocos de notas\\carona-solid-algorit\\dart\\data\\users.txt';

  File file = File(path);
  List<String> log = file.readAsLinesSync();

  log.forEach((u) {
    // Loop para inserir usuários utilizando a função addUser
    List<String> args = u.split(';');
    addUser(args, motoristas, passageiros);
  });

  List<User> passageirosSemMotorista = [];
  passageirosSemMotorista.addAll(passageiros);
  List<User> motoristasSemPassageiros = [];
  motoristasSemPassageiros.addAll(motoristas);

  algorithmWithSort(
    arestas: arestas,
    passageiros: passageiros,
    motoristas: motoristas,
    motoristasSemPassageiros: motoristasSemPassageiros,
    passageirosSemMotorista: passageirosSemMotorista,
  );

  printResults(
    arestas: arestas,
    passageiros: passageiros,
    motoristas: motoristas,
    passageirosSemMotorista: passageirosSemMotorista,
    motoristasSemPassageiros: motoristasSemPassageiros,
  );
}

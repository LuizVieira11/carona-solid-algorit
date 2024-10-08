import 'dart:io';

import 'User.dart';
import 'logic.dart';

void main() {
  List<User> passageiros = [];
  List<User> motoristas = [];
  Map<User, List<User>> arestas = {};
//C:\\Users\\Luiz Gustav\\Desktop\\Programas\\carona-solid-algorit\\dart\\users.txt
  String path =
      'C:\\dev\\Blocos de notas\\carona-solid-algorit\\dart\\userstest.txt';

  File file = File(path);
  List<String> log = file.readAsLinesSync();

  log.forEach((u) {
    List<String> args = u.split(";");

    if (args[4].parseBool()) {
      User user = User(name: args[0], maxPassenger: int.parse(args[2]));
      user.destination = args[1].split(",");
      user.willTravel = args[3].parseBool();
      user.reservedSeats = 0;
      user.isDriver = true;

      motoristas.add(user);
    } else {
      User user = User(name: args[0], maxPassenger: int.parse(args[2]));
      user.destination.add(args[1]);
      user.willTravel = args[3].parseBool();
      user.reservedSeats = 0;
      user.isDriver = false;

      passageiros.add(user);
    }
  });

  passageiros.forEach((p) {
    List<User> motoristasDisponiveis = [];
    motoristas.forEach((m) {
      if (m.destination.contains(p.destination[0]) &&
          m.reservedSeats < m.maxPassenger) {
        motoristasDisponiveis.add(m);
      }
    });
    if (motoristasDisponiveis.isNotEmpty) {
      motoristasDisponiveis
          .sort((m1, m2) => m1.reservedSeats.compareTo(m2.reservedSeats));
      User motoristaSelecionado = motoristasDisponiveis[0];
      motoristaSelecionado.reservedSeats++;
      if (!arestas.containsKey(motoristaSelecionado)) {
        arestas[motoristaSelecionado] = [];
      }
      arestas[motoristaSelecionado]!.add(p);
    }
  });

  arestas.forEach((driver, passengers) {
    print(
        '${driver.name}, ${driver.destination}: ${passengers.map((p) => p.name).join(', ')}');
  });

  List<User> passageirosSemMotorista = passageiros;
  List<User> motoristasSemPassageiros = [];
  motoristas.forEach((m) {
    if (arestas.containsKey(m)) {
      if (arestas[m]!.isNotEmpty) {
        arestas[m]!.forEach((p) {
          passageirosSemMotorista.remove(p);
        });
      }
    } else {
      motoristasSemPassageiros.add(m);
    }
  });

  if (passageirosSemMotorista.isEmpty) {
    print('\nTodos os passageiros foram emparelhados');
  } else {
    print(
        '\n\nPassageiros sem motoristas:  ${passageirosSemMotorista.map((p) => p.name).join(', ')}');
  }

  if (motoristasSemPassageiros.isEmpty) {
    print('\nTodos os motoristas foram emparelhados');
  } else {
    print(
        '\n\nMotoristas sem passageiros: ${motoristasSemPassageiros.map((m) => m.name).join(', ')}');
  }
}

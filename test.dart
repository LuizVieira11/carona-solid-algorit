import 'dart:io';

import 'User.dart';
import 'logic.dart';

void main() {
  List<User> passageiros = [];
  List<User> motoristas = [];
  Map<User, List<User>> arestas = {};

  String path =
      'C:\\Users\\Luiz Gustav\\Desktop\\Programas\\carona-solid-algorit\\users.txt';

  File file = File(path);
  List<String> log = file.readAsLinesSync();

  if (log.isEmpty) {
    print('aaaaa');
  }

  log.forEach((u) {
    List<String> args = u.split(";");
    List<String> cidades = [];

    if (cidades.length > 1) {
      cidades = args[1].split(",");
    } else {
      cidades.add(args[1]);
    }

    if (args[4].parseBool()) {
      User user = User(name: args[0], maxPassenger: int.parse(args[2]));
      user.destination = cidades;
      user.willTravel = args[3].parseBool();
      user.isDriver = true;

      motoristas.add(user);
    } else {
      User user = User(name: args[0], maxPassenger: int.parse(args[2]));
      user.destination = cidades;
      user.willTravel = args[3].parseBool();
      user.isDriver = false;

      passageiros.add(user);
    }

    passageiros.forEach((p) {
      List<User> motoristasDisponiveis = [];
      motoristas.forEach((m) {
        if (m.destination.contains(p.destination[0]) &&
            m.reservedSeats < m.maxPassenger) {
          motoristasDisponiveis.add(m);
        }
        if (motoristasDisponiveis.isNotEmpty) {
          motoristasDisponiveis
              .sort((m1, m2) => m1.maxPassenger.compareTo(m2.maxPassenger));
          User motoristaSelecionado = motoristasDisponiveis[0];
          motoristaSelecionado.reservedSeats++;
          if (!arestas.containsKey(motoristaSelecionado)) {
            arestas[motoristaSelecionado] = [];
          }
          arestas[motoristaSelecionado]!.add(p);
        }
      });
    });
  });
  arestas.forEach((m, p) {
    print('${m.name}, ${m.destination}: ${arestas[p]}');
  });
}

import 'dart:io';

import 'User.dart';
import 'logic.dart';

void addUser(List<String> args, List<User> motoristas, List<User> passageiros) {
  if (args[4].parseBool()) {
//    Faz a verificação do campo isDriver, nesse caso True -> Adiciona na lista de motoristas
    User user = User(name: args[0], maxPassenger: int.parse(args[2]));
    // user.destination = args[1].split(',');
    user.destination.add(args[1]);
    user.willTravel = args[3].parseBool();
    user.reservedSeats = 0;
    user.isDriver = true;

    motoristas.add(user);
  } else {
//    Se não for motorista, adiciona na lista de passageiros
    User user = User(name: args[0], maxPassenger: int.parse(args[2]));
    user.destination.add(args[1]);
    user.willTravel = args[3].parseBool();
    user.reservedSeats = 0;
    user.isDriver = false;

    passageiros.add(user);
  }
}

void main() {
  List<User> passageiros = [];
  List<User> motoristas = [];
  Map<User, List<User>> arestas = {};
// C:\\Users\\Luiz Gustav\\Desktop\\Programas\\carona-solid-algorit\\dart\\data\\users_efficiencyTest.txt
//C:\\dev\\Blocos de notas\\carona-solid-algorit\\dart\\data\\users.txt
  String path =
      'C:\\dev\\Blocos de notas\\carona-solid-algorit\\dart\\data\\users_efficiencyTest.txt';

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

  passageiros.forEach((p) {
    List<User> motoristaSelecionado = [];
    motoristas.forEach((m) {
      if (m.destination.contains(p.destination[0]) && m.reservedSeats <= 3) {
        motoristaSelecionado.add(m);
      }
    });
    if (motoristaSelecionado.isNotEmpty) {
      if (!arestas.containsKey(motoristaSelecionado)) {
        arestas[motoristaSelecionado[0]] = [];
      }
      arestas[motoristaSelecionado[0]]!.add(p);
      /** Faz a separação daqueles que ficaram sem motoristas e daqueles que ficaram sem passageiros */
      if (motoristasSemPassageiros.contains(motoristaSelecionado[0])) {
        motoristasSemPassageiros.remove(motoristaSelecionado[0]);
      }
      passageirosSemMotorista.remove(p);
    }
  });

  // passageiros.forEach((p) {
  //   List<User> motoristasDisponiveis = [];
  //   motoristas.forEach((m) {
  //     if (m.destination.contains(p.destination[0]) &&
  //         m.reservedSeats < m.maxPassenger) {
  //       /** Faz a comparação dos passageiros com todos os motoristas, aquele que for capaz de levar o passageiro
  //           é adicionado na lista de motoristas disponiveis para aquele passageiro*/
  //       motoristasDisponiveis.add(m);
  //     }
  //   });
  //   if (motoristasDisponiveis.isNotEmpty) {
  //     /** Se não estiver vazia a lista, os motoristas são ordenados por ordem crescente de assentos já reservados */
  //     motoristasDisponiveis
  //         .sort((m1, m2) => m1.reservedSeats.compareTo(m2.reservedSeats));
  //     User motoristaSelecionado = motoristasDisponiveis[0];
  //     motoristaSelecionado.reservedSeats++;
  //     /** Após, faz a seleção do motorista com menor quantidade de assentos disponiveis e aumenta o número
  //     de assentos reservados. Depois faz a adição no mapa com chave - valor */
  // if (!arestas.containsKey(motoristaSelecionado)) {
  //   arestas[motoristaSelecionado] = [];
  // }
  // arestas[motoristaSelecionado]!.add(p);
  // /** Faz a separação daqueles que ficaram sem motoristas e daqueles que ficaram sem passageiros */
  // if (motoristasSemPassageiros.contains(motoristaSelecionado)) {
  //   motoristasSemPassageiros.remove(motoristaSelecionado);
  // }
  // passageirosSemMotorista.remove(p);
  //   }
  // });

  print(
      '\nPassageiros: ${passageiros.map((p) => '${p.name} (${p.destination[0]})').join(', ')}');
  print(
      '\nMotoristas: ${motoristas.map((m) => '${m.name} (${m.destination[0]})').join(', ')}\n');

  arestas.forEach((driver, passengers) {
    print(
        '${driver.name}, ${driver.destination}: ${passengers.map((p) => p.name).join(', ')}');
  });

  if (passageirosSemMotorista.isEmpty) {
    print('\nTodos os passageiros foram emparelhados');
  } else {
    print(
        '\nPassageiros sem motoristas:  ${passageirosSemMotorista.map((p) => p.name).join(', ')}');
  }

  if (motoristasSemPassageiros.isEmpty) {
    print('\nTodos os motoristas foram emparelhados');
  } else {
    print(
        '\nMotoristas sem passageiros: ${motoristasSemPassageiros.map((m) => m.name).join(', ')}');
  }
}

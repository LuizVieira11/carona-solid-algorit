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

  algorithmWithoutSort(
    arestas: arestas,
    passageiros: passageiros,
    motoristas: motoristas,
    passageirosSemMotorista: passageirosSemMotorista,
    motoristasSemPassageiros: motoristasSemPassageiros,
  );

  printResults(
    arestas: arestas,
    passageiros: passageiros,
    motoristas: motoristas,
    passageirosSemMotorista: passageirosSemMotorista,
    motoristasSemPassageiros: motoristasSemPassageiros,
  );

  print(
      '\n--------------ENTRANDO NA PARTE DE QUE MOTORISTAS SEM PASSAGEIROS IRÃO VIRAR PASSAGEIROS--------------\n');

  List<User> motoristasAtt = List.from(motoristas);
  motoristasAtt.remove(motoristasSemPassageiros);
  List<User> motoristasSemPassageirosAtt = List.from(motoristasAtt);
  Map<User, List<User>> arestasAtt = {};

  motoristasSemPassageiros.forEach((m) {
    int nDest = m.destination.length;
    String finalDest = m.destination[nDest - 1];
    print(m.destination);
    m.destination.removeWhere((name) => name != finalDest);
  });

  List<User> passageirosAtt = List.from(passageiros);
  passageirosAtt.addAll(motoristasSemPassageiros);
  List<User> passageirosSemMotoristaAtt = List.from(passageirosAtt);

  algorithmWithSort(
    arestas: arestasAtt,
    passageiros: passageirosAtt,
    motoristas: motoristasAtt,
    passageirosSemMotorista: passageirosSemMotoristaAtt,
    motoristasSemPassageiros: motoristasSemPassageirosAtt,
  );

  printResults(
    arestas: arestasAtt,
    passageiros: passageirosAtt,
    motoristas: motoristasAtt,
    passageirosSemMotorista: passageirosSemMotoristaAtt,
    motoristasSemPassageiros: motoristasSemPassageirosAtt,
  );

  int model =
      motoristasSemPassageiros.length - motoristasSemPassageirosAtt.length;

  if (model >= 1) {
    print(
        'Hoje o número de motoristas que poderiam ser passageiros é de: $model');
  }
}

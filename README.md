# Algoritmo Carona Solidária UNISO

Nesse repositório eu estarei guardando as atualizações e otimizações do algoritmo do projeto.    
Normalmente, semanalmente eu realizo uma atualização realmente grande para entregas ou coisas do tipo.

O algoritmo hoje, serve para realizar a separação de distribuição igualitária de estudantes passageiros para os motoristas que têm destinos comuns.  
Esse feito abrange muito o pensamento de custo, ou seja, caso numa carona seja dividido o custo total de gasolina para os participantes.  

Caso o ponto de vista principal fosse a melhora da sustentabilidade do planeta, a redução da emissão de gases e a melhora na mobilidade, o correto seria um algoritmo de fluxo máximo.  
Porém esse tipo de algoritmo com esse pensamento não faz sentido, visto que se eu tenho um fluxo máximo de emparelhamento, é capaz que houveram motoristas sem passageiros, e estes, estarão andandode carro na rua do mesmo jeito.

## O algoritmo

A principal biblioteca utilizada para a fácil implementação dos grafos bipartidos foi a biblioteca NetworkX, com ela é possível realizar a criação e montagem de um grafo utilizando funções para uma organização prática do algoritmo.  

No momento decidimos seguir com a utilização de apenas uma classe de usuário, nela irá conter todas as informações pessoais do usuário mais as informações necessárias para a implementação do grafo.  

A classe tem atualmente implementado os seguintes atributos:  
Nome | Destino | Máximo de Passageiros | Assentos Reservados | Vai viajar | É motorista

Todos os atributos da classe são utilizados pela lógica para realizar o devido emparelhamento dos motoristas com os passageiros.  

Para verificação e separação por agora fizemos um algoritmo onde compara todos os motoristas com todos os passageiros através da igualdade do destino e se o número de assentos reservados é menor que o número de passageiros máximos, ao passar por essa verificação é feita a adição de uma aresta no grafo entre o motorista e passageiro e adiciona 1 no número de passageiros assentos reservados.

O algoritmo em pseudocódigo pode ser vizualisado no arquivo [algoritmo.txt](https://github.com/LuizVieira11/carona-solid-algorit/blob/main/algoritmo.txt).
# Algoritmo Carona Solidária UNISO

Nesse repositório eu estarei guardando as atualizações e otimizações do algoritmo do projeto.    
Normalmente, semanalmente eu realizo uma atualização realmente grande para entregas ou coisas do tipo.

O algoritmo hoje, serve para realizar a separação de distribuição igualitária de estudantes passageiros para os motoristas que têm destinos comuns.  
Esse feito abrange muito o pensamento de custo, ou seja, caso numa carona seja dividido o custo total de gasolina para os participantes.  

Caso o ponto de vista principal fosse a melhora da sustentabilidade do planeta, a redução da emissão de gases e a melhora na mobilidade, o correto seria um algoritmo de fluxo máximo.  
Porém esse tipo de algoritmo com esse pensamento não faz sentido, visto que se eu tenho um fluxo máximo de emparelhamento, é capaz que houveram motoristas sem passageiros, e estes, estarão andandode carro na rua do mesmo jeito.

Como um modo de melhorar a apresentação em Flutter, foi desenvolvido o mesmo algoritmo em dart, visto que não temos planejamento momentâneo em realizar a utilização de APIs para acesso em banco de dados ou conexão de tecnologias.  s

## O algoritmo

No momento decidimos seguir com a utilização de apenas uma classe de usuário, nela irá conter todas as informações pessoais do usuário mais as informações necessárias para a implementação do grafo.  

A classe tem atualmente implementado os seguintes atributos:  
Nome | Destino | Máximo de Passageiros | Assentos Reservados | Vai viajar | É motorista

Todos os atributos da classe são utilizados pela lógica para realizar o devido emparelhamento dos motoristas com os passageiros.  

Para verificação e separação por agora fizemos um algoritmo onde compara todos os motoristas com todos os passageiros através da igualdade do destino e se o número de assentos reservados é menor que o número de passageiros máximos, ao passar por essa verificação é feita a adição de uma aresta no grafo entre o motorista e passageiro e adiciona 1 no número de passageiros assentos reservados.

Para explicar a evolução do nosso algoritmo de emparelhamento de caronas, dividimos o desenvolvimento em três níveis de complexidade. O ponto de partida foi um algoritmo guloso, escolhido pela simplicidade e eficiência na resolução de problemas de emparelhamento em grafos com regras bem definidas. Este método já se mostrou eficaz no emparelhamento máximo, desde que os parâmetros corretos fossem usados, sem necessidade de algoritmos mais complexos, como Fulkerson, Berge ou o método húngaro, pois esses envolveriam maior trabalho computacional para alcançar resultados similares neste contexto.  

# Níveis de Complexidade e Parâmetros

## Primeiro Nível – Simplicidade Máxima

* Lógica: Baseamos o emparelhamento em uma lógica básica de comparação, onde o motorista e o passageiro se conectam caso o destino final de ambos corresponda.  
* Parâmetros: Os motoristas levam os passageiros diretamente ao destino final, sem múltiplas paradas.  
* Resultado: Não há uma distribuição homogênea de passageiros por motorista, mas o objetivo é focado em um emparelhamento direto e simples, maximizando conexões básicas.  

## Segundo Nível – Destinos Múltiplos

* Lógica: Aqui, aprimoramos o algoritmo para permitir que o motorista faça múltiplas paradas, atendendo a vários passageiros com destinos intermediários ao longo da rota.  
* Parâmetros: Motoristas podem agora combinar viagens com diferentes destinos.  
* Resultado: Mantém-se a simplicidade da lógica gulosa, maximizando emparelhamentos sem exigir uma distribuição equilibrada de passageiros por motorista.  

## Terceiro Nível – Distribuição Homogênea

* Lógica: Mantém a possibilidade de múltiplos destinos, mas adiciona um critério para balancear a quantidade de passageiros por motorista.  
* Parâmetros: Motoristas com rotas compatíveis são distribuídos de forma mais homogênea entre os passageiros, o que otimiza a ocupação e a eficiência de cada viagem.  
* Resultado: Todos os motoristas e passageiros são emparelhados, distribuindo melhor o uso de recursos.  

# Justificativa para o Uso do Algoritmo Guloso
Optamos pelo algoritmo guloso em vez de opções mais sofisticadas, como Fulkerson, Berge ou o algoritmo húngaro, pois nosso objetivo é realizar um emparelhamento de caronas que prioriza a eficiência prática, sem a necessidade de um emparelhamento perfeito ou de otimização de fluxos complexos. Embora algoritmos como Fulkerson ou Berge sejam mais sofisticados e destinados a emparelhamentos otimizados em grafos bipartidos ou a soluções de fluxo máximo, o trabalho e a complexidade de implementação não justificariam uma diferença expressiva nos resultados para o nosso contexto.

A lógica gulosa se alinha bem com a natureza do nosso problema de emparelhamento, onde as decisões imediatas de conexão entre motoristas e passageiros já atendem ao objetivo de maximizar emparelhamentos válidos. Ao usar uma abordagem mais direta, também reduzimos a carga computacional e mantemos a adaptabilidade do código para possíveis expansões, mantendo a simplicidade do processo.
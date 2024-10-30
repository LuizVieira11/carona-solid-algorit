import networkx as nx
import matplotlib.pyplot as plt
import os.path

# Criando um grafo bipartido
G = nx.Graph()

os.system('cls') or None
arquivo=open('userspy.txt','r',encoding='utf-8')

class User:
    # def __init__(self, name, destination, maxPassengers=0, reservedSeats=0, willTravel=False, isDriver=False):
    def __init__(self, name, destination, maxPassengers=0, reservedSeats=0, willTravel=False, isDriver=False, isMatched=False):
        self.name = name
        self.destination = destination
        self.maxPassengers = maxPassengers
        self.reservedSeats = reservedSeats
        self.willTravel = willTravel
        self.isDriver = isDriver
        self.isMatched = isMatched

    def __str__(self):
        return f"{self.name}, Destino: {self.destination}"

passageiros = []
motoristas = []

while True:
    linha=arquivo.readline()
    linha=linha.replace("\n","")
    linha=linha.replace("\t","")
    if len(linha) == 0:
        break
    args = linha.split(";")

    if eval(args[4]):
        motoristas.append(User(name=args[0], destination=args[1], maxPassengers=int(args[2]), 
                               reservedSeats=0, willTravel=True, isDriver=True, isMatched=False))
    else:
        passageiros.append(User(name=args[0], destination=args[1], maxPassengers=int(args[2]), 
                                reservedSeats=0, willTravel=True, isDriver=False, isMatched=False))





passageiros = []
motoristas = []
arestas = []

G.add_nodes_from(passageiros, bipartite=0)  # Adicionando objetos inteiros
G.add_nodes_from(motoristas, bipartite=1)  # Adicionando objetos inteiros
# @@ -46,9 +67,11 @@ def __str__(self):
# Criando as arestas com base no destino e disponibilidade de vagas
for p in passageiros:
    for m in motoristas:
        # if p.destination == m.destination and m.reservedSeats < m.maxPassengers:
        if p.destination == m.destination and m.reservedSeats < m.maxPassengers and p.isMatched == False:
            m.reservedSeats += 1
            p.isMatched = True
            arestas.append((m, p))  # Armazenando objetos completos
            # break

G.add_edges_from(arestas)

passageiros_sem_motorista = passageiros
for m in motoristas:
    for p in passageiros:
        if p in associacao_motoristas[m]:
            passageiros_sem_motorista.remove(p)
        if m in associacao_motoristas:
            if p in associacao_motoristas[m]:
                passageiros_sem_motorista.remove(p)

pos = nx.bipartite_layout(G, motoristas)
nx.draw(G, pos, with_labels=True, node_color=['lightblue' if node in motoristas else 'lightgreen' for node in G.nodes])
labels = {node: str(node) for node in G.nodes}
nx.draw_networkx_labels(G, pos, labels)
plt.show()

# Lidando com passageiros sem motorista
# passageiros_sem_motorista = [p.name for p in passageiros if not any(p == passageiro for motorista, passageiro in arestas)]
passageiros_nomes = [p.name for p in passageiros_sem_motorista]
print("\nPassageiros sem motorista:")
print(", ".join(passageiros_nomes) if passageiros_sem_motorista else "Todos os passageiros foram emparelhados com motoristas.")
import networkx as nx
import matplotlib.pyplot as plt

# Criando um grafo bipartido
G = nx.Graph()

class Passageiro:
    def __init__(self, name, destination):
        self.name = name
        self.destination = destination
        
    def __str__(self):
        return self.name
        
class Motorista(Passageiro):
    def __init__(self, name, destination, actualPassengers):
        super().__init__(name, destination)
        self.actualPassengers = actualPassengers
        

p1 = Passageiro("Joao", "Jardim das Flores")
p2 = Passageiro("Noé", "Caraguá")

passageiros = [p1, p2]

G.add_nodes_from([p.name for p in passageiros], bipartite=0)

m1 = Motorista("Maria", "Jardim das Flores", 0)

motoristas = [m1]

G.add_nodes_from([m.name for m in motoristas], bipartite=1)

arestas = []

for p in passageiros:
    for m in motoristas:
        if p.destination == m.destination and m.actualPassengers <= 3:
            m.actualPassengers = m.actualPassengers + 1
            arestas.append((m.name, p.name))

G.add_edges_from(arestas)
            
pos = nx.bipartite_layout(G, [m.name for m in motoristas])
nx.draw(G, pos, with_labels=True, node_color=['lightblue' if node in [m.name for m in motoristas] else 'lightgreen' for node in G.nodes])
plt.show()
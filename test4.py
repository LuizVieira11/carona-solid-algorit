import networkx as nx
import matplotlib.pyplot as plt
import os.path

# Criando um grafo bipartido
G = nx.Graph()

os.system('cls') or None
arquivo=open('users.txt','r',encoding='utf-8')

class User:
    def __init__(self, name, destination=[], maxPassengers=0, reservedSeats=0, willTravel=False, isDriver=False):
        self.name = name
        self.destination = destination
        self.maxPassengers = maxPassengers
        self.reservedSeats = reservedSeats
        self.willTravel = willTravel
        self.isDriver = isDriver
        
    def __str__(self):
        return f"{self.name}, {self.destination}"

passageiros = []
motoristas = []

while True:
    linha=arquivo.readline()
    linha=linha.replace("\n","")
    linha=linha.replace("\t","")
    if len(linha) == 0:
        break
    args = linha.split(";")
    
    list = args[1]
    
    if eval(args[4]):
        motoristas.append(User(name=args[0], destination=list, maxPassengers=int(args[2]), 
                               reservedSeats=0, willTravel=eval(args[3]), isDriver=eval(args[4])))
    else:
        passageiros.append(User(name=args[0], destination=list, maxPassengers=0, 
                                reservedSeats=0, willTravel=eval(args[3]), isDriver=eval(args[4])))

G.add_nodes_from(passageiros, bipartite=0)  # Adicionando objetos inteiros
G.add_nodes_from(motoristas, bipartite=1)  # Adicionando objetos inteiros       

arestas = []

# Distribuindo passageiros de maneira justa
for p in passageiros:
    motoristas_disponiveis = [m for m in motoristas if p.destination in m.destination and m.reservedSeats < m.maxPassengers]
    if motoristas_disponiveis:
        # Ordena os motoristas pela quantidade de vagas disponíveis, para priorizar motoristas menos ocupados
        motoristas_disponiveis.sort(key=lambda m: m.reservedSeats)
        motorista_selecionado = motoristas_disponiveis[0]
        motorista_selecionado.reservedSeats += 1
        arestas.append((motorista_selecionado, p))  # Conecta motorista e passageiro no grafo
            

G.add_edges_from(arestas)

# Visualizando o grafo bipartido
pos = nx.bipartite_layout(G, motoristas)
nx.draw(G, pos, with_labels=True, node_color=['lightblue' if node in motoristas else 'lightgreen' for node in G.nodes])
labels = {node: str(node) for node in G.nodes}
nx.draw_networkx_labels(G, pos, labels)
plt.show()

# Criando o retorno de associações motorista-passageiros
associacao_motoristas = {}

for motorista, passageiro in arestas:
    if motorista not in associacao_motoristas:
        associacao_motoristas[motorista] = []
    
    associacao_motoristas[motorista].append(passageiro)
        
print(associacao_motoristas)

# Exibindo as associações
print("Emparelhamento Motoristas e Passageiros:")
for motorista, passageiro in associacao_motoristas.items():
    passageiros_nomes = [p.name for p in passageiro]
    print(f"Motorista {motorista} está levando os passageiros: {', '.join(passageiros_nomes)}")

passageiros_sem_motorista = passageiros
motoristas_sem_passageiro = []
for m in motoristas:
    for p in passageiros:
        if m in associacao_motoristas:
            if p in associacao_motoristas[m]:
                passageiros_sem_motorista.remove(p)
        else:
            if m not in motoristas_sem_passageiro:
                motoristas_sem_passageiro.append(m)

# Lidando com passageiros sem motorista
passageiros_nomes = [p.name for p in passageiros_sem_motorista]
motoristas_nomes = [m.name for m in motoristas_sem_passageiro]
print("\nPassageiros sem motorista:")
print(", ".join(passageiros_nomes) if passageiros_sem_motorista else "Todos os passageiros foram emparelhados com motoristas.")
print("\nMotoristas sem passageiro:")
print(", ".join(motoristas_nomes) if motoristas_sem_passageiro else "Todos os motoristas foram emparelhados com passageiros.")
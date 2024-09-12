import networkx as nx
import matplotlib.pyplot as plt
import os.path

# Criando um grafo bipartido
G = nx.Graph()

os.system('cls') or None
arquivo=open('users.txt','r',encoding='utf-8')

class User:
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
    args = linha.split(",")
    
    if eval(args[5]):
        motoristas.append(User(name=args[0], destination=args[1], maxPassengers=int(args[2]), 
                               reservedSeats=int(args[3]), willTravel=eval(args[4]), isDriver=eval(args[5]), isMatched=eval(args[6])))
    else:
        passageiros.append(User(name=args[0], destination=args[1], maxPassengers=int(args[2]), 
                                reservedSeats=int(args[3]), willTravel=eval(args[4]), isDriver=eval(args[5]), isMatched=eval(args[6])))
    

# # Exemplo de passageiros
# p1 = User("Joao", "Jardim das Flores", willTravel=True)
# p2 = User("Noé", "Caraguá", willTravel=True)
# p3 = User("Catarina", "Jardim das Flores", willTravel=True)
# p4 = User("Maria Lucia", "Itapetininga", willTravel=True)

# # Exemplo de motorista
# m1 = User("Maria", "Jardim das Flores", maxPassengers=4, reservedSeats=0, willTravel=True, isDriver=True)
# m2 = User("Pedro", "Caraguá", maxPassengers=4, willTravel=True, isDriver=True)

# lista = [p1, p2, p3, p4, m1, m2]


# for u in lista:
#     if u.isDriver:
#         motoristas.append(u)
#     else:
#         passageiros.append(u)

G.add_nodes_from(passageiros, bipartite=0)  # Adicionando objetos inteiros
G.add_nodes_from(motoristas, bipartite=1)  # Adicionando objetos inteiros

arestas = []

# Criando as arestas com base no destino e disponibilidade de vagas
for p in passageiros:
    for m in motoristas:
        if p.destination == m.destination and m.reservedSeats < m.maxPassengers and p.isMatched == False:
            m.reservedSeats += 1
            p.isMatched = True
            arestas.append((m, p))  # Armazenando objetos completos
            # break

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
        

# Exibindo as associações
print("Emparelhamento Motoristas e Passageiros:")
for motorista, passageiro in associacao_motoristas.items():
    passageiros_nomes = [p.name for p in passageiro]
    print(f"Motorista {motorista} está levando os passageiros: {', '.join(passageiros_nomes)}")

passageiros_sem_motorista = passageiros
for m in motoristas:
    for p in passageiros:
        if m in associacao_motoristas:
            if p in associacao_motoristas[m]:
                passageiros_sem_motorista.remove(p)

# Lidando com passageiros sem motorista
passageiros_nomes = [p.name for p in passageiros_sem_motorista]
print("\nPassageiros sem motorista:")
print(", ".join(passageiros_nomes) if passageiros_sem_motorista else "Todos os passageiros foram emparelhados com motoristas.")


# class Passageiro:
#     def __init__(self, name, destination, willTravel=False):
#         self.name = name
#         self.destination = destination
#         self.willTravel = willTravel
        
#     def __str__(self):
#         # return f"Passageiro: {self.name}, Destino: {self.destination}, Pronto para viajar: {self.willTravel}"
#         return f"{self.name}, Destino: {self.destination}"
        
# class Motorista(Passageiro):
#     def __init__(self, name, destination, maxPassengers, reservedSeats=0, willTravel=False):
#         super().__init__(name, destination, willTravel)
#         self.maxPassengers = maxPassengers  # Limite máximo de passageiros
#         self.reservedSeats = reservedSeats  # Vagas reservadas inicialmente
        
#     def reservar_vaga(self):
#         if self.reservedSeats <= self.maxPassengers:
#             self.reservedSeats += 1
#         else:
#             raise Exception("Limite de passageiros excedido!")
    
#     def __str__(self):
#         # return (f"Motorista: {self.name}, Destino: {self.destination}, Vagas Reservadas: {self.reservedSeats}, "
#         #         f"Vagas Máximas: {self.maxPassengers}, Pronto para viajar: {self.willTravel}")
#         return (f"{self.name}, Destino: {self.destination}")

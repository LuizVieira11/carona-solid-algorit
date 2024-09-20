class User:
    #SELECT * FROM users WHERE willTravel = True
    def __init__(self, name, destination=[], maxPassengers=0, reservedSeats=0, willTravel=False, isDriver=False):
        self.name = name
        self.destination = destination
        self.maxPassengers = maxPassengers
        self.reservedSeats = reservedSeats
        self.willTravel = willTravel
        self.isDriver = isDriver
        
    def __str__(self):
        return f"{self.name}, {self.destination}"
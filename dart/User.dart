class User {
  String _name;
  List<String> _destination = [];
  int _maxPassenger;
  int _reservedSeats = 0;
  bool _willTravel = false;
  bool _isDriver = false;

// Constructor
  User({
    required String name,
    required int maxPassenger,
  })  : _name = name,
        _maxPassenger = maxPassenger;

// Gets & Sets
  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<String> get destination => _destination;

  set destination(List<String> value) {
    _destination = value;
  }

  int get maxPassenger => _maxPassenger;

  set maxPassenger(int value) {
    _maxPassenger = value;
  }

  int get reservedSeats => _reservedSeats;

  set reservedSeats(int value) {
    _reservedSeats = value;
  }

  bool get willTravel => _willTravel;

  set willTravel(bool value) {
    _willTravel = value;
  }

  bool get isDriver => _isDriver;

  set isDriver(bool value) {
    _isDriver = value;
  }
}

List<String> stats = ["recieved", "to confirm", "to pack", "completed"];

class OrderFormat {
  String name = '';
  int count = 0;
  List<String> itemNames = [];
  List<String> quantity = [];
  List<bool> availabilty = [];
  String status = 'recieved';
  String remarks = '';
}

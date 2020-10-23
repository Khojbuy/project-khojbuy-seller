class Cards {
  final String id;
  final String name;
  final String description;
  final String image;

  const Cards({this.id, this.name, this.description, this.image});
}

final List<Cards> cardSet = [
  const Cards(
      id: "1",
      name: "ORDERS",
      description: "All the orders that are recieved exclusively for you",
      image: "- assets/images/orders.png"),
  const Cards(
      id: "2",
      name: "REQUESTS",
      description: "Customers want to know about this ",
      image: "- assets/images/orders.png"),
  const Cards(
      id: "3",
      name: "PENDING REQUESTS",
      description: "All the orders that are recieved exclusively for you",
      image: "- assets/images/request.png"),
  const Cards(
      id: "4",
      name: "RESPONDED REQUESTS",
      description: "All the orders that are recieved exclusively for you",
      image: "- assets/images/confirm.png"),
];

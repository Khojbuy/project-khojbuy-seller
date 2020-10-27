import 'package:flutter/material.dart';

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

Widget orderSort(OrderFormat orderFormat, BuildContext context) {
  return GestureDetector(
    onTap: () {
      OrderLong(
        temp: orderFormat,
        context: context,
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      color: Color.fromRGBO(250, 250, 255, 1),
      shadowColor: Colors.blueGrey,
      elevation: 20,
      child: Column(
        children: [
          Text(
            orderFormat.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(41, 74, 171, 1),
            ),
          ),
          Text(
            orderFormat.count.toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(41, 74, 171, 0.6)),
          )
        ],
      ),
    ),
  );
}

class OrderLong extends StatefulWidget {
  final OrderFormat temp;
  final BuildContext context;
  OrderLong({Key key, @required this.temp, @required this.context})
      : super(key: key);
  @override
  _OrderLongState createState() => _OrderLongState(temp, context);
}

class _OrderLongState extends State<OrderLong> {
  OrderFormat orderFormat;
  BuildContext context;
  _OrderLongState(this.orderFormat, this.context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
        title: Text(orderFormat.name),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: orderFormat.count,
                itemBuilder: (BuildContext context, index) {
                  return CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(orderFormat.itemNames[index]),
                          Text(orderFormat.quantity[index])
                        ],
                      ),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Color.fromRGBO(41, 74, 171, 0.98),
                      value: orderFormat.availabilty[index],
                      onChanged: (val) {
                        orderFormat.availabilty[index] = val;
                      });
                }),
            TextField(
              autocorrect: true,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              onChanged: (value) {
                orderFormat.remarks = value;
              },
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remarks, if any",
                  helperText: "Any special information for the consumer"),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: InkWell(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    int ctr = stats.indexOf(orderFormat.status);
                    orderFormat.status = stats[ctr++];
                  },
                  elevation: 10,
                  backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                  label: Text(
                    "CONFIRM",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

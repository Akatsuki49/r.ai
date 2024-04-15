import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arithmania_frontend/widgets/transaction_list.dart';
import 'package:http/http.dart' as http;

class SpendingsPage extends StatefulWidget {
  const SpendingsPage({Key? key}) : super(key: key);

  @override
  State<SpendingsPage> createState() => _SpendingsPageState();
}

class _SpendingsPageState extends State<SpendingsPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _type = "expense";
  late String _balance;

  @override
  void initState() {
    super.initState();
    _updateBalance();
  }

  void _updateBalance() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Accessing the balance value and updating the global variable
        setState(() {
          _balance = snapshot.data()?['balance']?.toString() ?? 'N/A';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _balance == null // Check if balance is null
        ? Center(
            child:
                CircularProgressIndicator()) // Show CircularProgressIndicator while balance is null
        : Builder(
            builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 20, right: 20, bottom: 10),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My spendings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 300),
                          child: Image.asset(
                            'assets/images/mascot.png',
                          )
                          // child: Container(
                          //   color: Colors.red,
                          //   height: 60,
                          //   width: 60,
                          // ),
                          ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.asset('assets/images/cib_visa.png',
                                      height: 50, width: 50),
                                  SizedBox(width: 210),
                                  Image.asset('assets/images/Group.png',
                                      height: 50, width: 50),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text('Available Balance',
                                  style: TextStyle(fontSize: 15)),
                              Text('₹ $_balance',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          chotawidget("25"),
                          chotawidget("100"),
                          chotawidget("500"),
                          chotawidget("1000"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Color(0xff019254),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => _showTransactionDialog(),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text('Recent',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TransactionList(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget chotawidget(String amt) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "₹" + amt,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
    );
  }

  void _showTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  DropdownButton<String>(
                    value: _type,
                    onChanged: (String? newValue) {
                      setState(() {
                        _type = newValue!;
                      });
                    },
                    items: <String>['expense', 'income'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _addTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // void _addTransaction() {
  //   // Parse amount as double
  //   String txt = _amountController.text;
  //   String type = "";
  //   if (txt[0] == '-' || txt[0] == '.') {
  //     type = 'expense';
  //   } else {
  //     type = 'income';
  //   }
  //   double amount = double.parse(_amountController.text);
  //   // Make amount positive for backend request
  //   double absoluteAmount = amount.abs();

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('transactions')
  //       .add({
  //     "amount": amount,
  //     "type": type,
  //     "category": _categoryController.text,
  //     "description": "Added manually",
  //     "timestamp": DateTime.now(),
  //   }).then((value) {
  //     // Show success dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Success'),
  //           content: Text('Transaction added successfully.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     print('Transaction added successfully.');

  //     // Prepare data to send to the backend endpoint
  //     Map<String, dynamic> requestData = {
  //       "user_id": FirebaseAuth.instance.currentUser!.uid,
  //       "amount": absoluteAmount, // Sending positive amount to backend
  //       "type": type,
  //       "category": _categoryController.text,
  //       "description": "Added manually",
  //     };

  //     // Send POST request to the backend endpoint
  //     http
  //         .post(
  //             Uri.parse(
  //                 'https://b825-104-28-252-172.ngrok-free.app/update_transactions'),
  //             body: requestData)
  //         .then((response) {
  //       if (response.statusCode == 200) {
  //         print('Transaction data sent to the backend successfully.');
  //       } else {
  //         print(
  //             'Failed to send transaction data to the backend. Status code: ${response.statusCode}');
  //       }
  //     }).catchError((error) {
  //       print('Error sending transaction data to the backend: $error');
  //     });
  //   }).catchError((error) {
  //     print('Error adding transaction: $error');
  //   });
  // }
  void _addTransaction() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .add({
      "amount": double.parse(_amountController.text),
      "type": _type,
      "category": _categoryController.text,
      "description": "Added manually",
      "timestamp": DateTime.now(),
    }).then((value) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Transaction added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Transaction added successfully.');

      // Prepare data to send to the backend endpoint
      Map<String, dynamic> requestData = {
        "user_id": FirebaseAuth.instance.currentUser!.uid,
        "amount": _amountController.text,
        "type": 'expense',
        "category": _categoryController.text,
        "description": "Added manually",
      };

      // Send POST request to the backend endpoint
      http
          .post(
              Uri.parse(
                  'https://b825-104-28-252-172.ngrok-free.app/update_transactions'),
              body: requestData)
          .then((response) {
        if (response.statusCode == 200) {
          print('Transaction data sent to the backend successfully.');
        } else {
          print(
              'Failed to send transaction data to the backend. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error sending transaction data to the backend: $error');
      });
    }).catchError((error) {
      print('Error adding transaction: $error');
    });
  }
}

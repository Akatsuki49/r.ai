import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:arithmania_frontend/widgets/transaction_list.dart';

class SpendingsPage extends StatefulWidget {
  const SpendingsPage({Key? key}) : super(key: key);

  @override
  State<SpendingsPage> createState() => _SpendingsPageState();
}

class _SpendingsPageState extends State<SpendingsPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _type = "expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
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
                child: Container(
                  color: Colors.red,
                  height: 60,
                  width: 60,
                ),
              ),
              Container(
                color: Colors.white,
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                    FirebaseAuth.instance.currentUser!.uid,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TransactionList(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .orderBy('timestamp',
              descending: true) // Order transactions by timestamp
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No transactions found.');
        }
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                final double amount = data['amount'].toDouble();
                final String type = data['type'];
                final String category = data['category'];
                final DateTime timestamp = data['timestamp'].toDate();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    tileColor: Color(0xff1D1D21),
                    title: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date: ${_formatDate(timestamp)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatAmount(amount, type),
                          style: TextStyle(
                            color:
                                type == 'expense' ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatAmount(double amount, String type) {
    if (type == 'expense') {
      return '-₹${amount.toStringAsFixed(2)}'; // Expense amount in rupees
    } else {
      return '+₹${amount.toStringAsFixed(2)}'; // Income amount in rupees
    }
  }

  Widget chotawidget() {
    return Container(
      color: Colors.white,
      height: 70,
      width: 70,
    );
  }

  void _showTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: SingleChildScrollView(
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
    }).catchError((error) {
      print('Error adding transaction: $error');
    });
  }
}

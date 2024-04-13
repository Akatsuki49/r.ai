// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TransactionList extends StatelessWidget {
//   final String userId;

//   TransactionList({required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('transactions')
//           .orderBy('timestamp',
//               descending: true) // Order transactions by timestamp
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Text('No transactions found.');
//         }
//         return Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data() as Map<String, dynamic>;
//                 final double amount = data['amount'].toDouble();
//                 final String type = data['type'];
//                 final String category = data['category'];
//                 final DateTime timestamp = data['timestamp'].toDate();
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: ListTile(
//                     tileColor: Color(0xff1D1D21),
//                     title: Text(
//                       category,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     subtitle: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Date: ${_formatDate(timestamp)}',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Text(
//                           _formatAmount(amount, type),
//                           style: TextStyle(
//                             color:
//                                 type == 'expense' ? Colors.red : Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }

//   String _formatAmount(double amount, String type) {
//     if (type == 'expense') {
//       return '-₹${amount.toStringAsFixed(2)}'; // Expense amount in rupees
//     } else {
//       return '+₹${amount.toStringAsFixed(2)}'; // Income amount in rupees
//     }
//   }
// }

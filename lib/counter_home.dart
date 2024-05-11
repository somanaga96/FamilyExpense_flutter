// import 'package:familyexpense/utils/global/global.dart';
// import 'package:familyexpense/utils/transaction/transaction_tools.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CounterHomePage extends StatefulWidget {
//   const CounterHomePage({Key? key}) : super(key: key);
//
//   @override
//   _CounterHomePageState createState() => _CounterHomePageState();
// }
//
// class _CounterHomePageState extends State<CounterHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Access the CounterModel instance and call the total method
//     Provider.of<Global>(context, listen: false).transactionTotal();
//     Provider.of<Global>(context, listen: false).transactionCount();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Global>(
//       builder: (context, value, child) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Counter App'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 value.sum.toString(),
//                 style:
//                     const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               child: const Icon(Icons.add),
//               onPressed: () {
//                 TransactionTool tool = TransactionTool();
//                 tool.createTransaction(context, value, child);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

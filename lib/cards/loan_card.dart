import 'package:familyexpense/utils/loan/loan_servic.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatefulWidget {
  const LoanCard({super.key});

  @override
  State<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends State<LoanCard> {
  int sums = 0;
  int counts = 0;

  @override
  void initState() {
    super.initState();
    totalLoan(); // Call updateTotalLoan method when the widget initializes
    loanCount();
  }

  Future<void> totalLoan() async {
    LoanService loanService =
        LoanService(); // Create an instance of LoanService
    int totalLoan = await loanService.sumTotalLoan(); // Call the method
    setState(() {
      sums = totalLoan; // Update the sums variable with the total loan amount
    });
  }

  Future<void> loanCount() async {
    LoanService loanService =
        LoanService(); // Create an instance of LoanService
    int count = await loanService.loanCount(); // Call the method
    setState(() {
      counts = count; // Update the sums variable with the total loan amount
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      // color: Colors.grey[200],
      child: SizedBox(
        width: screenSize.width / 2.1,
        height: screenSize.height / 6,
        child: Column(
          children: [
            Column(
              children: [
                const Text('Loans'),
                Text('Count : ${counts.toString()}'),
                Text('Amount: ${sums.toString()}'),
                // Text('date: ${value.selectedDate.toString()}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

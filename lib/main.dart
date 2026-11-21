
import 'package:flutter/material.dart';

void main() {
  runApp(const TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      home: const TipScreen(),
    );
  }
}

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  State<TipScreen> createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  final TextEditingController amountController =
      TextEditingController();

  int chosenTip = 15;
  double? calculatedTip;
  double? finalTotal;
  bool showResult = false;
  String errorText = '';

  void calculate() {
    final amount =
        double.tryParse(amountController.text.trim());

    if (amount == null || !amount.isFinite || amount <= 0) {
      setState(() {
        errorText = 'Enter a valid amount';
        showResult = false;
      });
      return;
    }

    final tipValue = amount * chosenTip / 100;
    final totalValue = amount + tipValue;

    setState(() {
      calculatedTip = tipValue;
      finalTotal = totalValue;
      errorText = '';
      showResult = true;
    });
  }

  void clearAll() {
    setState(() {
      amountController.clear();
      chosenTip = 15;
      calculatedTip = null;
      finalTotal = null;
      errorText = '';
      showResult = false;
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
                prefixText: '₱',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Tip',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text('10%'),
                  selected: chosenTip == 10,
                  onSelected: (_) {
                    setState(() {
                      chosenTip = 10;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('15%'),
                  selected: chosenTip == 15,
                  onSelected: (_) {
                    setState(() {
                      chosenTip = 15;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('20%'),
                  selected: chosenTip == 20,
                  onSelected: (_) {
                    setState(() {
                      chosenTip = 20;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculate,
                child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: clearAll,
                child: const Text('Clear'),
              ),
            ),
            const SizedBox(height: 25),
            if (errorText.isNotEmpty)
              Text(
                errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            if (showResult)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip: ₱${calculatedTip!.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: ₱${finalTotal!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

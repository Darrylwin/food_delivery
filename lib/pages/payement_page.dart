import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery/components/my_button.dart';

import 'delivery_progress_page.dart';

class PayementPage extends StatefulWidget {
  const PayementPage({
    super.key,
  });

  @override
  State<PayementPage> createState() => _PayementPageState();
}

class _PayementPageState extends State<PayementPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void Function()? userTaper() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Configure ayement"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Card number: $cardNumber'),
                Text('Expiry date: $expiryDate'),
                Text('Card Holder name: $cardHolderName'),
                Text('Cvv: $cvvCode'),
              ],
            ),
          ),
          actions: [
            //cancel button
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),

            //validate button
            TextButton(
              child: const Text("Validate"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryProgressPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Checkout",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //credit card
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0) {},
              cardBgColor: const Color.fromARGB(255, 12, 86, 96),
            ),

            //credit card form
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formKey,
            ),

            // const Spacer(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            MyButton(
              text: "Pay now",
              onTap: userTaper,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../widgets/checkout_step_indicator.dart';

class CheckoutShippingPage extends StatelessWidget {
  const CheckoutShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CheckoutStepIndicator(currentStep: 1),
            const SizedBox(height: 32),
            Text('Shipping', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text(
              'Your saved shipping address will be used for this demo order.',
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Home address'),
                subtitle: const Text('Dublin, Ireland'),
                trailing: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Spacer(),
            SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () => context.pushNamed(RouteNames.checkoutPayment),
                child: const Text('Continue to payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/formatters/currency_formatter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../cart/presentation/cart_provider.dart';
import '../../domain/entities/payment_method.dart';
import '../checkout_providers.dart';
import '../widgets/checkout_step_indicator.dart';

class CheckoutPaymentPage extends ConsumerWidget {
  const CheckoutPaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodsProvider);
    final checkout = ref.watch(checkoutControllerProvider);
    final controller = ref.read(checkoutControllerProvider.notifier);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: methods.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('We could not load payment methods.')),
        data: (availableMethods) {
          if (availableMethods.isEmpty) {
            return const Center(child: Text('No payment methods available.'));
          }
          final visibleSelected =
              checkout.selectedPaymentMethodId ?? availableMethods.first.id;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              const CheckoutStepIndicator(currentStep: 2),
              const SizedBox(height: 30),
              Text('Payment', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text('Choose a secure payment method for your order.'),
              const SizedBox(height: 20),
              ...availableMethods.map(
                (method) => _PaymentMethodTile(
                  method: method,
                  selected: method.id == visibleSelected,
                  onSelected: () => controller.selectPaymentMethod(method.id),
                ),
              ),
              const SizedBox(height: 4),
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(RouteNames.addPaymentMethod),
                icon: const Icon(Icons.add),
                label: const Text('Add a new payment method'),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: checkout.billingMatchesShipping,
                onChanged: (value) =>
                    controller.setBillingMatchesShipping(value ?? false),
                title: const Text('Billing address is the same as shipping'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (checkout.errorMessage != null)
                Text(
                  checkout.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order total',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    formatCurrency(total, 'EUR'),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: checkout.isProcessing
                    ? null
                    : () async {
                        if (checkout.selectedPaymentMethodId == null) {
                          controller.selectPaymentMethod(visibleSelected);
                        }
                        final success = await controller.processPayment();
                        if (context.mounted && success) {
                          context.goNamed(RouteNames.checkoutSuccess);
                        }
                      },
                child: checkout.isProcessing
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Pay securely'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.method,
    required this.selected,
    required this.onSelected,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final subtitle = method.lastFour == null
        ? 'Fast and secure'
        : '•••• ${method.lastFour}';
    return Card(
      color: selected ? AppColors.selectedBackground : null,
      child: Semantics(
        button: true,
        selected: selected,
        label: '${method.label}, $subtitle${selected ? ', selected' : ''}',
        child: ListTile(
          onTap: onSelected,
          leading: Icon(
            method.type == PaymentMethodType.applePay
                ? Icons.phone_iphone
                : Icons.credit_card,
          ),
          title: Text(method.label),
          subtitle: Text(subtitle),
          trailing: Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? AppColors.primary : AppColors.secondaryText,
          ),
        ),
      ),
    );
  }
}

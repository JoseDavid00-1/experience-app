enum PaymentMethodType { card, applePay }

class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.label,
    required this.type,
    this.lastFour,
  });

  final String id;
  final String label;
  final PaymentMethodType type;
  final String? lastFour;
}

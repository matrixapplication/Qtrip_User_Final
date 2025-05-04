class PaymentParams {
  final String amount;
  final String orderId;
  final String orderType;

  PaymentParams({required this.amount,required this.orderId,required this.orderType});

  Map<String, dynamic> toMap() {
    return {
      'amount': this.amount,
      'order_id': this.orderId,
      'order_type': this.orderType,
    };
  }

  factory PaymentParams.fromMap(Map<String, dynamic> map) {
    return PaymentParams(
      amount: map['amount'] as String,
      orderId: map['order_id'] as String,
      orderType: map['order_type'] as String,
    );
  }
}
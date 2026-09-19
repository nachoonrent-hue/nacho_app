enum BookingType { dancer, mirage }

enum BookingStatus {
  requested,
  accepted,
  paymentPending,
  confirmed,
  checkedIn,
  completed,
  cancelled,
  disputed
}

class BookingModel {
  final String id;
  final BookingType type;
  final String itemId; // dancerId or experienceId
  final String itemTitle;
  final String itemImageUrl;
  final String customerId;
  final String customerName;
  final String providerId; // dancerId or hostId
  final String providerName;
  final String date;
  final String time;
  final int guestCount;
  final double totalAmount;
  final BookingStatus status;
  final String qrCode;
  final String specialNotes;
  final String createdAt;
  final bool isPaid;
  final String? cancellationReason;
  final String? disputeReason;

  BookingModel({
    required this.id,
    required this.type,
    required this.itemId,
    required this.itemTitle,
    required this.itemImageUrl,
    required this.customerId,
    required this.customerName,
    required this.providerId,
    required this.providerName,
    required this.date,
    required this.time,
    this.guestCount = 1,
    required this.totalAmount,
    required this.status,
    required this.qrCode,
    this.specialNotes = '',
    required this.createdAt,
    this.isPaid = false,
    this.cancellationReason,
    this.disputeReason,
  });

  BookingModel copyWith({
    BookingStatus? status,
    bool? isPaid,
    String? cancellationReason,
    String? disputeReason,
  }) {
    return BookingModel(
      id: id,
      type: type,
      itemId: itemId,
      itemTitle: itemTitle,
      itemImageUrl: itemImageUrl,
      customerId: customerId,
      customerName: customerName,
      providerId: providerId,
      providerName: providerName,
      date: date,
      time: time,
      guestCount: guestCount,
      totalAmount: totalAmount,
      status: status ?? this.status,
      qrCode: qrCode,
      specialNotes: specialNotes,
      createdAt: createdAt,
      isPaid: isPaid ?? this.isPaid,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      disputeReason: disputeReason ?? this.disputeReason,
    );
  }

  String get statusLabel {
    switch (status) {
      case BookingStatus.requested:
        return 'Request Pending';
      case BookingStatus.accepted:
        return 'Request Accepted';
      case BookingStatus.paymentPending:
        return 'Payment Pending';
      case BookingStatus.confirmed:
        return 'Booking Confirmed';
      case BookingStatus.checkedIn:
        return 'Checked In';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.disputed:
        return 'Disputed';
    }
  }
}

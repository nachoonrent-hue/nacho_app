import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/dancer_model.dart';
import '../models/wedding_event_model.dart';
import '../models/organizer_model.dart';
import '../models/mirage_experience_model.dart';
import '../models/booking_model.dart';
import '../models/review_model.dart';
import '../models/notification_model.dart';
import 'mock_data.dart';

class AppState extends ChangeNotifier {
  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  UserModel _currentUser = MockData.currentUser;
  UserModel get currentUser => _currentUser;

  final List<DancerModel> _dancers = List.from(MockData.dancers);
  List<DancerModel> get dancers => _dancers;

  final List<WeddingEventModel> _weddingEvents = List.from(MockData.weddingEvents);
  List<WeddingEventModel> get weddingEvents => _weddingEvents;

  final List<OrganizerModel> _organizers = List.from(MockData.organizers);
  List<OrganizerModel> get organizers => _organizers;

  final List<MirageExperienceModel> _mirageExperiences = List.from(MockData.mirageExperiences);
  List<MirageExperienceModel> get mirageExperiences => _mirageExperiences;

  final List<BookingModel> _bookings = List.from(MockData.bookings);
  List<BookingModel> get bookings => _bookings;

  final List<ReviewModel> _reviews = List.from(MockData.reviews);
  List<ReviewModel> get reviews => _reviews;

  final List<NotificationModel> _notifications = List.from(MockData.notifications);
  List<NotificationModel> get notifications => _notifications;

  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  // Save / Bookmark Toggles
  void toggleSaveDancer(String dancerId) {
    final saved = List<String>.from(_currentUser.savedDancerIds);
    if (saved.contains(dancerId)) {
      saved.remove(dancerId);
    } else {
      saved.add(dancerId);
    }
    _currentUser = _currentUser.copyWith(savedDancerIds: saved);
    notifyListeners();
  }

  void toggleSaveEvent(String eventId) {
    final saved = List<String>.from(_currentUser.savedEventIds);
    if (saved.contains(eventId)) {
      saved.remove(eventId);
    } else {
      saved.add(eventId);
    }
    _currentUser = _currentUser.copyWith(savedEventIds: saved);
    notifyListeners();
  }

  void toggleSaveExperience(String expId) {
    final saved = List<String>.from(_currentUser.savedExperienceIds);
    if (saved.contains(expId)) {
      saved.remove(expId);
    } else {
      saved.add(expId);
    }
    _currentUser = _currentUser.copyWith(savedExperienceIds: saved);
    notifyListeners();
  }

  bool isDancerSaved(String id) => _currentUser.savedDancerIds.contains(id);
  bool isEventSaved(String id) => _currentUser.savedEventIds.contains(id);
  bool isExperienceSaved(String id) => _currentUser.savedExperienceIds.contains(id);

  // Profile creation & update
  void saveDancerProfile(DancerModel profile) {
    final index = _dancers.indexWhere((d) => d.id == profile.id);
    if (index >= 0) {
      _dancers[index] = profile;
    } else {
      _dancers.insert(0, profile);
    }
    _currentUser = _currentUser.copyWith(
      hasDancerProfile: true,
      dancerProfileId: profile.id,
    );
    notifyListeners();
  }

  void createWeddingEvent(WeddingEventModel event) {
    _weddingEvents.insert(0, event);
    notifyListeners();
  }

  void createMirageExperience(MirageExperienceModel exp) {
    _mirageExperiences.insert(0, exp);
    notifyListeners();
  }

  // Booking engine state transitions
  void createBooking(BookingModel booking) {
    _bookings.insert(0, booking);
    _notifications.insert(
      0,
      NotificationModel(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: 'New Booking Created',
        body: 'Booking request for ${booking.itemTitle} submitted successfully.',
        timeAgo: 'Just now',
        isRead: false,
        type: 'booking',
        targetId: booking.id,
      ),
    );
    notifyListeners();
  }

  void updateBookingStatus(String bookingId, BookingStatus status, {String? reason}) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index >= 0) {
      final current = _bookings[index];
      _bookings[index] = current.copyWith(
        status: status,
        isPaid: (status == BookingStatus.confirmed || status == BookingStatus.completed) ? true : current.isPaid,
        cancellationReason: status == BookingStatus.cancelled ? reason : current.cancellationReason,
        disputeReason: status == BookingStatus.disputed ? reason : current.disputeReason,
      );

      _notifications.insert(
        0,
        NotificationModel(
          id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Booking Status Updated',
          body: 'Booking for ${current.itemTitle} is now ${_bookings[index].statusLabel}.',
          timeAgo: 'Just now',
          isRead: false,
          type: 'booking',
          targetId: bookingId,
        ),
      );

      notifyListeners();
    }
  }

  void addReview(ReviewModel review) {
    _reviews.insert(0, review);
    notifyListeners();
  }

  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }
}

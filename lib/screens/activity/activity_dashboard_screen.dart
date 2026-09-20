import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/status_badge.dart';
import '../booking/check_in_screen.dart';

class ActivityDashboardScreen extends StatefulWidget {
  const ActivityDashboardScreen({super.key});

  @override
  State<ActivityDashboardScreen> createState() =>
      _ActivityDashboardScreenState();
}

class _ActivityDashboardScreenState extends State<ActivityDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final userBookings = appState.bookings;
    final totalEarnings = userBookings
        .where((b) => b.isPaid)
        .fold(0.0, (sum, b) => sum + b.totalAmount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Activity', style: AppTypography.h1),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryPlum,
          unselectedLabelColor: AppColors.secondaryText,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
          indicator: BoxDecoration(
            color: AppColors.primaryPlum.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'My Events'),
            Tab(text: 'Dancer Requests'),
            Tab(text: 'Mirage Activity'),
            Tab(text: 'Notifications'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Overview Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics Overview
                Row(
                  children: [
                    Expanded(
                      child: Entrance(
                        index: 0,
                        child: _MetricCard(
                          title: 'Total Earnings',
                          value: totalEarnings,
                          prefix: '₹',
                          color: AppColors.emeraldSuccess,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Entrance(
                        index: 1,
                        child: _MetricCard(
                          title: 'Active Bookings',
                          value: userBookings.length.toDouble(),
                          color: AppColors.primaryPlum,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                const Entrance(
                  index: 2,
                  child: Text(
                    'Recent Booking Activity',
                    style: AppTypography.h2,
                  ),
                ),
                const SizedBox(height: 12),

                if (userBookings.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('No active bookings yet.')),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userBookings.length,
                    itemBuilder: (context, index) {
                      final booking = userBookings[index];
                      return Entrance(
                        index: index,
                        offset: 10,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.borderLight),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPlum.withValues(
                                  alpha: 0.04,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  booking.itemImageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 50,
                                        height: 50,
                                        color: AppColors.chipBackground,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.itemTitle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${booking.date} • ₹${booking.totalAmount.toInt()}',
                                      style: AppTypography.small,
                                    ),
                                  ],
                                ),
                              ),
                              StatusBadge(status: booking.status.name),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),

          // 2. My Events Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.weddingEvents.length,
            itemBuilder: (context, index) {
              final evt = appState.weddingEvents[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    evt.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${evt.date} • ${evt.dancersNeeded} Dancers Needed',
                  ),
                  trailing: StatusBadge(status: evt.status),
                ),
              );
            },
          ),

          // 3. Dancer Requests Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: userBookings
                .where((b) => b.type == BookingType.dancer)
                .length,
            itemBuilder: (context, index) {
              final b = userBookings
                  .where((b) => b.type == BookingType.dancer)
                  .toList()[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    b.itemTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Date: ${b.date} • ₹${b.totalAmount.toInt()}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CheckInScreen(booking: b),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    child: const Text('Manage', style: TextStyle(fontSize: 11)),
                  ),
                ),
              );
            },
          ),

          // 4. Mirage Activity Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.mirageExperiences.length,
            itemBuilder: (context, index) {
              final exp = appState.mirageExperiences[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    exp.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Category: ${exp.category} • ₹${exp.pricePerGuest.toInt()}/guest',
                  ),
                  trailing: const StatusBadge(status: 'Active'),
                ),
              );
            },
          ),

          // 5. Notifications Feed Tab
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.notifications.length,
            itemBuilder: (context, index) {
              final notif = appState.notifications[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: notif.isRead ? Colors.white : AppColors.warmIvory,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryPlum.withValues(
                        alpha: 0.1,
                      ),
                      child: const Icon(
                        Icons.notifications_rounded,
                        color: AppColors.primaryPlum,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(notif.body, style: AppTypography.small),
                          const SizedBox(height: 4),
                          Text(
                            notif.timeAgo,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final double value;
  final String? prefix;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (prefix != null) ...[
                AnimatedDefaultTextStyle(
                  duration: AppMotion.fast,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  child: Text(prefix!),
                ),
                const SizedBox(width: 2),
              ],
              AnimatedStat(
                value: value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/notifications/domain/entity/app_notification_entity.dart';
import 'package:shoptoo/features/notifications/presentation/providers/notification_provider.dart';
import 'package:shoptoo/features/notifications/presentation/providers/notifications_stream_provider.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class NotificationScreen extends ConsumerWidget {
  final String userId;

  const NotificationScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(userNotificationsProvider(userId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: true,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF84F562).withOpacity(0.1),
                        const Color(0xFF94F7A1).withOpacity(0.05),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 70,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1E293B),
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stay updated with your orders & offers',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: notifications.maybeWhen(
                data: (data) {
                  final unreadCount = data.where((n) => !n.isRead).length;
                  if (unreadCount > 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Pallete.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$unreadCount',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  );
                },
                orElse: () => Text(
                  'Notifications',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              centerTitle: true,
              actions: [
                Consumer(
                  builder: (context, ref, child) {
                    return IconButton(
                      onPressed: () async {
                        final data = notifications.value;
                        if (data != null) {
                          final unread = data.where((n) => !n.isRead);
                          for (final notification in unread) {
                            await ref
                                .read(notificationRepositoryProvider)
                                .markAsRead(userId, notification.id);
                          }
                          ref.invalidate(userNotificationsProvider(userId));
                        }
                      },
                      icon: Icon(
                        Iconsax.tick_circle,
                        color: Pallete.primaryColor,
                        size: 24,
                      ),
                      tooltip: 'Mark all as read',
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: notifications.when(
          loading: () => _buildLoadingState(),
          error: (e, _) => _buildErrorState(e.toString(), ref),
          data: (data) {
            if (data.isEmpty) {
              return _buildEmptyState();
            }

            final unreadNotifications =
                data.where((n) => !n.isRead).toList();
            final readNotifications =
                data.where((n) => n.isRead).toList();

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(userNotificationsProvider(userId));
              },
              color: Pallete.primaryColor,
              child: ListView(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                children: [
                  if (unreadNotifications.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'New',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    ...unreadNotifications.map((notification) =>
                        _buildNotificationItem(
                          notification: notification,
                          isUnread: true,
                          ref: ref,
                        )),
                  ],
                  if (readNotifications.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Text(
                        'Earlier',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    ...readNotifications.map((notification) =>
                        _buildNotificationItem(
                          notification: notification,
                          isUnread: false,
                          ref: ref,
                        )),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required AppNotificationEntity notification,
    required bool isUnread,
    required WidgetRef ref,
  }) {
    final iconData = _getNotificationIcon(notification.title);
    final iconColor = _getNotificationColor(notification.title);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ref
                .read(notificationRepositoryProvider)
                .markAsRead(userId, notification.id);
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: iconColor.withOpacity(0.1),
          highlightColor: iconColor.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUnread
                  ? Pallete.primaryColor.withOpacity(0.03)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isUnread
                    ? Pallete.primaryColor.withOpacity(0.1)
                    : const Color(0xFFF1F5F9),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0A1E293B),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notification Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        iconColor.withOpacity(0.2),
                        iconColor.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      iconData,
                      size: 24,
                      color: iconColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Notification Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: isUnread
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: const Color(0xFF1E293B),
                                letterSpacing: -0.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 4, left: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallete.primaryColor,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.body,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatTimeAgo(notification.createdAt),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String title) {
    final lowerTitle = title.toLowerCase();
    
    if (lowerTitle.contains('order') || lowerTitle.contains('shipped') || lowerTitle.contains('delivered')) {
      return Iconsax.box;
    } else if (lowerTitle.contains('sale') || lowerTitle.contains('discount') || lowerTitle.contains('offer')) {
      return Iconsax.discount_shape;
    } else if (lowerTitle.contains('payment') || lowerTitle.contains('refund')) {
      return Iconsax.card;
    } else if (lowerTitle.contains('welcome') || lowerTitle.contains('welcome')) {
      return Iconsax.emoji_happy;
    } else if (lowerTitle.contains('security') || lowerTitle.contains('verify')) {
      return Iconsax.shield_tick;
    } else if (lowerTitle.contains('cart') || lowerTitle.contains('wishlist')) {
      return Iconsax.shopping_cart;
    } else if (lowerTitle.contains('review') || lowerTitle.contains('rating')) {
      return Iconsax.star;
    } else if (lowerTitle.contains('message') || lowerTitle.contains('chat')) {
      return Iconsax.message;
    }
    
    return Iconsax.notification;
  }

  Color _getNotificationColor(String title) {
    final lowerTitle = title.toLowerCase();
    
    if (lowerTitle.contains('order') || lowerTitle.contains('shipped') || lowerTitle.contains('delivered')) {
      return const Color(0xFF10B981); // Emerald
    } else if (lowerTitle.contains('sale') || lowerTitle.contains('discount') || lowerTitle.contains('offer')) {
      return const Color(0xFFF59E0B); // Amber
    } else if (lowerTitle.contains('payment') || lowerTitle.contains('refund')) {
      return const Color(0xFFEF4444); // Red
    } else if (lowerTitle.contains('welcome') || lowerTitle.contains('welcome')) {
      return Pallete.primaryColor; // Primary
    } else if (lowerTitle.contains('security') || lowerTitle.contains('verify')) {
      return const Color(0xFF6366F1); // Indigo
    } else if (lowerTitle.contains('cart') || lowerTitle.contains('wishlist')) {
      return const Color(0xFF8B5CF6); // Violet
    } else if (lowerTitle.contains('review') || lowerTitle.contains('rating')) {
      return const Color(0xFFF97316); // Orange
    }
    
    return const Color(0xFF64748B); // Slate
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 24),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF1F5F9),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF1F5F9),
                  ),
                ),
                const SizedBox(width: 16),
                // Skeleton for content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFF1F5F9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFF1F5F9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFF1F5F9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFF1F5F9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.1),
              ),
              child: Icon(Iconsax.warning_2, size: 50, color: Colors.red),
            ),
            const SizedBox(height: 24),
            Text(
              'Unable to Load Notifications',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(userNotificationsProvider(userId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6366F1).withOpacity(0.1),
                    const Color(0xFF8B5CF6).withOpacity(0.05),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Iconsax.notification,
                  size: 64,
                  color: Pallete.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No Notifications Yet',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'When you get notifications about orders, offers, and updates, they\'ll appear here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to explore products
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: Text(
                'Explore Products',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// FirebaseMessaging.onMessage.listen((message) {
//   final userId = ref.read(authUserIdProvider);

//   final notification = AppNotificationEntity(
//     id: message.messageId!,
//     title: message.notification?.title ?? '',
//     body: message.notification?.body ?? '',
//     createdAt: DateTime.now(),
//     isRead: false,
//   );

//   ref
//       .read(notificationRepositoryProvider)
//       .saveNotification(userId, notification);
// });



// class NotificationScreen extends ConsumerWidget {
//   final String userId;

//   const NotificationScreen({required this.userId, super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifications =
//         ref.watch(userNotificationsProvider(userId));

//     return notifications.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (e, _) => Center(child: Text(e.toString())),
//       data: (data) => ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (_, index) {
//           final n = data[index];

//           return ListTile(
//             title: Text(
//               n.title,
//               style: TextStyle(
//                 fontWeight:
//                     n.isRead ? FontWeight.normal : FontWeight.bold,
//               ),
//             ),
//             subtitle: Text(n.body),
//             onTap: () {
//               ref
//                   .read(notificationRepositoryProvider)
//                   .markAsRead(userId, n.id);
//             },
//           );
//         },
//       ),
//     );
//   }
// }





// Admin → User (How Admin Sends)
// Best Practice (Millions of Users)

// Admin does NOT send directly

// Admin hits Cloud Function

// Cloud Function:

// Sends FCM

// Writes Firestore record

// This avoids abuse & scales properly.


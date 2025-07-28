import 'package:clive/util/ui_util/image_manager.dart';
import 'package:flutter/cupertino.dart';
import '../../../ui/features/tickets/ticket_screen.dart';
import '../../../ui/features/wishlist/wishlist_screen.dart';

class DashboardBarItem {
  String title;
  Widget screen;
  String icon;

  DashboardBarItem({
    required this.title,
    required this.screen,
    required this.icon,
});
  
  static List<DashboardBarItem> items = [
    DashboardBarItem(title: 'Wishlist', screen: WishlistScreen(), icon: ImageManager.wishlist),
    DashboardBarItem(title: 'All Tickets', screen: TicketScreen(), icon: ImageManager.tickets),
    DashboardBarItem(title: 'Account', screen: Container(), icon: ImageManager.account),
  ];

}
import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/util/persistor/data_persistor.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../networking/models/reponse/ticket.dart';
import '../../widgets/app_calendar.dart';
import '../../widgets/wishlist_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ticket'),
                Text('See all  tickets'),
                AppInputField(),
                AppCalendar(),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: ColorManager.deepGreen,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Center(child: Row(
                        children: [
                          Text('• 07 Thur, 2024 ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                        ],
                      ))
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder(
                        future: DataPersistor.getWishlist(),
                        builder: (context, snapshot) {
                          if(snapshot.data?.isEmpty == false) {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                              Ticket ticket = snapshot.data![index];
                              return WishListWidget(ticket: ticket);
                            });
                          } else {
                            return Center(
                              child: Text('No ticket has been added to your wishlist'),
                            );
                          }
                        }
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

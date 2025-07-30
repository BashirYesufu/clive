import 'package:clive/util/persistor/data_persistor.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:clive/util/ui_util/image_manager.dart';
import 'package:clive/util/ui_util/ui_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../networking/models/reponse/ticket.dart';

class WishListWidget extends StatefulWidget {
  const WishListWidget({required this.ticket, super.key});
  final Ticket ticket;

  @override
  State<WishListWidget> createState() => _WishListWidgetState();
}

class _WishListWidgetState extends State<WishListWidget> {
  Ticket get ticket => widget.ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40.0),
      height: 165,
      decoration: BoxDecoration(
          color: ColorManager.border.withValues(alpha: 0.1),
          border: Border.all(
          color: ColorManager.border,
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: Container(
              width: 4,
              height: 165,
              color: Colors.black, margin: EdgeInsets.only(right: 4),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticket.duration ?? ''),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ticket.artist ?? ''),
                            RichText(
                              text: TextSpan(
                                text: 'Amount: ',
                                  style: TextStyle(
                                      color: ColorManager.border
                                  ),
                                children: [
                                  TextSpan(
                                      text: ticket.ticketRef ??'',
                                    style: TextStyle(
                                      color: ColorManager.black
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.more_vert_rounded),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageManager.location),
                          Text(ticket.location ?? '', style: TextStyle(
                              color: ColorManager.blue
                          ),)
                        ],
                      ),
                      InkWell(
                        onTap: (){
                         if(ticket.purchased == false){
                           UIActions.showPriSecPopup(context, message: 'Are you sure you want to purchase tickets', onTap: (){
                             setState(() {
                               DataPersistor.removeFromWishlist(ticket);
                               DataPersistor.addPurchasedTicket(ticket);
                             });
                           });
                         }
                        },
                        child: Container(
                          height: 48,
                            width: 140,
                            decoration: BoxDecoration(
                              color: ColorManager.backGround,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text(ticket.purchased == true ? 'View Receipt' : 'Purchase Ticket'))),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

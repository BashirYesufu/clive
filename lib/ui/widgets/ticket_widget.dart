import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/material.dart';

import '../../networking/models/reponse/ticket.dart';
import 'app_check_box.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({required this.ticket, this.onChanged, super.key});
  final Ticket ticket;
  final Function(bool)? onChanged;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  Ticket get ticket => widget.ticket;
  bool showingDetails = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showingDetails ? ColorManager.border.withValues(alpha: 0.2) : Colors.transparent,
        border: Border.all(
          color: Colors.transparent
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCheckBox(
                    onChanged: (value){
                      setState(() {
                        showingDetails = value;
                      });
                      widget.onChanged?.call(showingDetails);
                    },
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket.artist ?? ''),
                      RichText(
                        text: TextSpan(
                          text: 'Ref: ',
                          style: TextStyle(
                            color: ColorManager.border,
                          ),
                          children: [
                            TextSpan(
                              text: ticket.ticketRef ?? 'ref',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('# ${ticket.ticketPrice ?? 0.00}'),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'Location: ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: ticket.location ??''
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          showingDetails ? Column(
            children: [
              SizedBox(height: 20),

              AppInputField(
                title: 'Quantity',
              ),
              Container(
                width: 111,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.border)
                ),
              )
            ],
          ) : SizedBox()
        ],
      ),
    );
  }
}

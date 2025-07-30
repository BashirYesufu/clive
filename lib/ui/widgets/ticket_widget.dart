import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/material.dart';

import '../../networking/models/reponse/ticket.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../sheets/quantity_sheet.dart';
import 'app_check_box.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({required this.ticket, this.onSelected, this.showingDetails = false, super.key});
  final Ticket ticket;
  final Function(bool)? onSelected;
  final bool showingDetails;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> with QuantityDelegate{
  Ticket get ticket => widget.ticket;
  num quantity = 0;
  bool get showingDetails => widget.showingDetails;

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
                 showingDetails ? SizedBox() : AppCheckBox(
                    onChanged: (value)=> widget.onSelected?.call(showingDetails),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: ()=> QuantitySheet.launch(context, delegate: this),
                child: AppInputField(
                  title: 'Quantity',
                  hintText: 'Select item',
                  enabled: false,
                  controller: TextEditingController(text: '$quantity'),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quantity', style: AppTextStyles.black(weight: FontWeight.w500),),
                  Container(
                    width: 111,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ColorManager.backGround,
                      border: Border.all(color: ColorManager.border),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(quantity == 0){return;}
                              quantity -= 1;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('$quantity', style: AppTextStyles.black(),),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ) : SizedBox()
        ],
      ),
    );
  }

  @override
  void onQuantitySelected(num quantity) {
    setState(() {
      this.quantity = quantity;
    });
  }
}

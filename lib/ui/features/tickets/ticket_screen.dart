import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/ui/widgets/app_picker_field.dart';
import 'package:clive/ui/widgets/ticket_widget.dart';
import 'package:clive/util/persistor/data_persistor.dart';
import 'package:clive/util/ui_util/app_text_styles.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/material.dart';
import '../../sheets/tickets_sheets.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with TicketDelegate{
  final TextEditingController _locationTC = TextEditingController();
  List<Ticket> selectedTickets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('List of Tickets', style: AppTextStyles.black(weight: FontWeight.w700, size: 28),),
            Text('Select the tickets you wish to pay for',  style: AppTextStyles.grey(),),
            SizedBox(height: 20),
            InkWell(
              child: AppPickerField(
                title: 'Location',
                controller: _locationTC,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                items: ['Lagos', 'Abuja', 'Ibadan', 'Enugu'],
              ),
            ),
            InkWell(
              onTap: ()=> TicketListSheet.launch(context, location: _locationTC.text, delegate: this),
              child: AppInputField(
                title: 'Tickets',
                hintText: 'Select item',
                enabled: false,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Text('Selected Tickets'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(selectedTickets.length, (index)=> TicketWidget(ticket: selectedTickets[index], showingDetails: true,)),
                ),
              ),
            ),
            selectedTickets.isNotEmpty ? InkWell(
              onTap: ()=> DataPersistor.saveWishList(selectedTickets),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text('Add to Wishlist ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
              ),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  void proceedWithTickets(List<Ticket> ticket) {
    setState(() {
      selectedTickets = ticket;
    });
  }

}

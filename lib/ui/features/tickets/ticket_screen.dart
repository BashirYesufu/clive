import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/ui/widgets/app_button.dart';
import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/ui/widgets/app_picker_field.dart';
import 'package:clive/ui/widgets/ticket_widget.dart';
import 'package:clive/util/persistor/data_persistor.dart';
import 'package:clive/util/ui_util/app_text_styles.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:clive/util/ui_util/ui_actions.dart';
import 'package:flutter/material.dart';
import '../../sheets/tickets_sheets.dart';
import '../../widgets/app_switch.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with TicketDelegate{
  String? _location;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('List of Tickets', style: AppTextStyles.black(weight: FontWeight.w700, size: 28),),
                    Text('Select the tickets you wish to pay for',  style: AppTextStyles.grey(),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Offline Mode', style: AppTextStyles.grey(),),
                    FutureBuilder(
                        future: DataPersistor.isOffline(),
                        builder: (context, snapshot) {
                          return AppSwitch(
                            isOn: snapshot.data ?? false,
                            onToggle: (value){
                              DataPersistor.toggleOfflineMode(value);
                            },
                          );
                        }
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              child: AppPickerField(
                title: 'Location',
                hintText: 'Select location',
                onChanged: (dynamic text)=> _location = text,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                items: ['Lagos', 'Abuja', 'Ibadan', 'Enugu', 'Port Harcourt', 'Kano'],
              ),
            ),
            InkWell(
              onTap: ()=> TicketListSheet.launch(context, location: _location, delegate: this),
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
            selectedTickets.isNotEmpty ? AppButton(
              onTap: ()=> DataPersistor.addToWishlist(selectedTickets).then((_){
                  UIActions.showSuccessPopup(context, message: 'Tickets added to wishlist successfully');
                }),
              title: 'Add to Wishlist ',
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

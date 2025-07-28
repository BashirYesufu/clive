import 'package:clive/bloc/repository/ticket_bloc.dart';
import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/ui/widgets/app_input_field.dart';
import 'package:clive/ui/widgets/ticket_widget.dart';
import 'package:clive/util/persistor/data_persistor.dart';
import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final TicketBloc _ticketBloc = TicketBloc();
  List<Ticket> selectedTickets = [];

  void bindTicketBloc(){
    _ticketBloc.getTickets();
  }

  @override
  void initState() {
    bindTicketBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('List of Tickets'),
            Text('Select the tickets you wish to pay for'),
            AppInputField(),
            AppInputField(),
            Text('Selected Tickets'),
            Expanded(
              child: StreamBuilder<List<Ticket>>(
                  stream: _ticketBloc.ticketResponse,
                  builder: (context, snapshot){
                    if(snapshot.data?.isEmpty == false) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                        Ticket ticket = snapshot.data![index];
                        return TicketWidget(ticket: ticket, onChanged: (value){
                          selectedTickets.add(ticket);
                        },);
                      });
                    }
                    if(snapshot.data?.isEmpty == true) {
                      return Center(child: Text('No tickets available'));
                    }
                    return Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
              ),
            ),
            selectedTickets.isNotEmpty ? InkWell(
              onTap: (){
                selectedTickets.map((ticket)=> DataPersistor.addToWishlist(ticket));
              },
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
}

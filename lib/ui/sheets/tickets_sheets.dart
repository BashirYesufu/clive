import 'package:clive/ui/widgets/app_button.dart';
import 'package:clive/util/route/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../bloc/repository/ticket_bloc.dart';
import '../../networking/models/reponse/ticket.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/ui_actions.dart';
import '../widgets/ticket_widget.dart';

mixin TicketDelegate {
  void proceedWithTickets(List<Ticket> ticket);
}

class TicketListSheet extends StatefulWidget {
  const TicketListSheet({required this.delegate, this.location, super.key});
  final TicketDelegate delegate;
  final String? location;

  static launch(BuildContext context, {String? location, required TicketDelegate delegate}){
    UIActions.showSheet(context, height: MediaQuery.of(context).size.height - 200, child: TicketListSheet(location: location, delegate: delegate,));
  }

  @override
  State<TicketListSheet> createState() => _TicketListSheetState();
}

class _TicketListSheetState extends State<TicketListSheet> {
  final TicketBloc _ticketBloc = TicketBloc();
  List<Ticket> selectedTickets = [];

  void bindTicketBloc(){
    _ticketBloc.getTickets(location: widget.location);
  }

  @override
  void initState() {
    bindTicketBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tickets', style: AppTextStyles.black( size: 16, weight: FontWeight.w600),),
          Expanded(
            child: StreamBuilder<List<Ticket>>(
              stream: _ticketBloc.ticketResponse,
              builder: (context, snapshot){
                if(snapshot.data?.isEmpty == false) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Ticket ticket = snapshot.data![index];
                        return TicketWidget(ticket: ticket, onSelected: (value){
                          setState(() {
                            selectedTickets.add(ticket);
                          });
                        },
                     );
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
          selectedTickets.isNotEmpty ? SafeArea(
            child: AppButton(
              onTap: (){
                AppRouter.goBack(context);
                widget.delegate.proceedWithTickets(selectedTickets);
              },
              title: 'Select Tickets',
            ),
          ) : SizedBox()

        ],
      ),
    );
  }
}

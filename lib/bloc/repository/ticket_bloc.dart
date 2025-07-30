import 'package:clive/networking/repository/ticket/ticket_repository.dart';
import 'package:clive/util/persistor/data_persistor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

import '../../networking/models/reponse/ticket.dart';

class TicketBloc {
  final _repo = TicketRepository();

  final _ticketSubject = BehaviorSubject<List<Ticket>>();
  Stream<List<Ticket>> get ticketResponse => _ticketSubject.stream;
  void getTickets({String? location}) async {
    final bool isConnected = await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      // DataPersistor.getTickets().then((savedTickets){
      //   if(location != null && location.isNotEmpty) {
      //     List<Ticket> newTix = savedTickets.where((tix) => tix.location?.toLowerCase() == location.toLowerCase()).toList();
      //     _ticketSubject.sink.add(newTix);
      //   }
      //   _repo.getTickets().then((response) {
      //     DataPersistor.saveTickets(response);
      //   });
      // });
      await _repo.getTickets().then((response) {
        if(location != null && location.isNotEmpty) {
          List<Ticket> newTix = response.where((tix) => tix.location?.toLowerCase() == location.toLowerCase()).toList();
          _ticketSubject.sink.add(newTix);
        } else {
          DataPersistor.saveTickets(response);
          _ticketSubject.sink.add(response);
        }
      });
    } else {
      DataPersistor.getTickets().then((savedTickets){
        if(location != null && location.isNotEmpty) {
          List<Ticket> newTix = savedTickets.where((tix) => tix.location?.toLowerCase() == location.toLowerCase()).toList();
          _ticketSubject.sink.add(newTix);
        } else {
          _ticketSubject.sink.add(savedTickets);
        }
      });
    }
  }

}
import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/networking/repository/ticket/ticket_api_service.dart';
import 'package:clive/networking/repository/ticket/ticket_repository_impl.dart';

class TicketRepository implements TicketRepositoryImpl {
  final _service = TicketApiService();

  @override
  Future<List<Ticket>> getTickets() {
    return _service.getTickets();
  }

}
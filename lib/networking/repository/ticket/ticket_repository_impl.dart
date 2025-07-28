import '../../models/reponse/ticket.dart';

abstract class TicketRepositoryImpl {
  Future<List<Ticket>> getTickets();
}
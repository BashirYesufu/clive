import 'dart:async';

import 'package:clive/networking/common/api_urls.dart';
import 'package:clive/networking/common/network_manager.dart';

import '../../models/reponse/ticket.dart';

class TicketApiService {
  final _networkManager = NetworkManager();

  Future<List<Ticket>> getTickets() async {
    var completer = Completer<List<Ticket>>();
    try {
      final response = await _networkManager.makeRequest(requestType: RequestType.get, url: ApiUrls.tickets, useNestedParam: false);
      if (response?.data != null) {
        List<Ticket> result = List<Ticket>.from(response?.data.map((x)=> Ticket.fromJson(x)));
        completer.complete(result);
      }
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

}
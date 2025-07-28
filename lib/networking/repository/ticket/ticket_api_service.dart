import 'dart:async';

import 'package:clive/networking/common/api_urls.dart';
import 'package:clive/networking/common/network_manager.dart';

import '../../models/reponse/ticket.dart';

class TicketApiService {
  final _networkManager = NetworkManager();

  Future<List<Ticket>> getTickets() async {
    var completer = Completer<List<Ticket>>();
    await _networkManager.makeRequest(requestType: RequestType.get, url: ApiUrls.tickets, useNestedParam: false).then((response){
      List<Ticket> result = List<Ticket>.from(response?.data.map((x)=> Ticket.fromJson(x)));
      print(result);
      completer.complete(result);
    }, onError: (error){
      completer.completeError(error);
    });

    return completer.future;

  }

}
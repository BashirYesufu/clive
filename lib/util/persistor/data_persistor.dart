import 'dart:convert';

import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/util/persistor/persistor_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistor {

  static void saveWishList(List<Ticket> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(data.isEmpty){
      return;
    }
    final dataJson = jsonEncode(data);
    prefs.setString(DataPersistorKeys.keyWishlist, dataJson);
  }

  static Future<List<Ticket>> getWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyWishlist);
    if(cache == null){
      return [];
    }
    List<Ticket> jsonData = List<Ticket>.from(jsonDecode(cache).map((json)=> Ticket.fromJson(json)));
    return jsonData;
  }

  static void addToWishlist(Ticket data) async {
    List<Ticket> currentList = await getWishlist();
    currentList.add(data);
    saveWishList(currentList);
  }

  static void removeFromWishlist(Ticket data) async {
    List<Ticket> currentList = await getWishlist();
    currentList.removeWhere((ticket)=> ticket.ticketRef == data.ticketRef);
    saveWishList(currentList);
  }

  static void saveTickets(List<Ticket> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(data.isEmpty){
      return;
    }
    final dataJson = jsonEncode(data);
    prefs.setString(DataPersistorKeys.keyTickets, dataJson);
  }

  static Future<List<Ticket>> getTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyTickets);
    if(cache == null){
      return [];
    }
    List<Ticket> jsonData = List<Ticket>.from(jsonDecode(cache).map((json)=> Ticket.fromJson(json)));
    return jsonData;
  }
}
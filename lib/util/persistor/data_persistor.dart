import 'dart:convert';

import 'package:clive/networking/models/reponse/ticket.dart';
import 'package:clive/util/persistor/persistor_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistor {

  static Future<void> saveWishList(List<Ticket> data) async {
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

  static Future<void> addToWishlist(List<Ticket> data) async {
    List<Ticket> currentWishlist = await getWishlist();

    // Convert the current wishlist to a Set for efficient duplicate checking.
    // Sets automatically handle uniqueness based on the overridden == and hashCode.
    Set<Ticket> wishlistSet = currentWishlist.toSet();

    for (Ticket ticket in data) {
      ticket.purchased = false;
      //Add the ticket to the set. If it's already there, the set won't add it again.
      wishlistSet.add(ticket);
    }

    //Convert the Set back to a List and save it
    saveWishList(wishlistSet.toList());
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

  static void _savePurchasedTickets(List<Ticket> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(data.isEmpty){
      return;
    }
    final dataJson = jsonEncode(data);
    prefs.setString(DataPersistorKeys.keyPurchasedTickets, dataJson);
  }

  static void addPurchasedTicket(Ticket data) async {
    List<Ticket> currentList = await getPurchasedTickets();

    Set<Ticket> listSet = currentList.toSet();
    data.purchased = true;
    listSet.add(data);

    _savePurchasedTickets(listSet.toList());
  }

  static Future<List<Ticket>> getPurchasedTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyPurchasedTickets);
    if(cache == null){
      return [];
    }
    List<Ticket> jsonData = List<Ticket>.from(jsonDecode(cache).map((json)=> Ticket.fromJson(json)));
    return jsonData;
  }
}
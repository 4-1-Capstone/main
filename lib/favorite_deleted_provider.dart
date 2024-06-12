import 'package:flutter/material.dart';

class FavoriteAndDeletedProvider with ChangeNotifier {
  List<String> _favoriteItems = [];
  List<String> _deletedItems = [];

  List<String> get favoriteItems => _favoriteItems;
  List<String> get deletedItems => _deletedItems;

  void addFavoriteItem(String item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void removeFavoriteItem(String item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }

  void addDeletedItem(String item) {
    _deletedItems.add(item);
    notifyListeners();
  }

  void removeDeletedItem(String item) {
    _deletedItems.remove(item);
    notifyListeners();
  }
}

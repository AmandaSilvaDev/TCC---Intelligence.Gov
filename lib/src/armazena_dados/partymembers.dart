import 'package:flutter/material.dart';
import 'package:chamber_deputies/src/models/partymembers.dart';

import 'package:chamber_deputies/src/repositories/party_detalhes.dart';


class PartymembersStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<PartyDetailsMode> value =
      ValueNotifier<PartyDetailsMode>(PartyDetailsMode());
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final PartyDetailsRepository repository;

  PartymembersStore({
    required this.repository,
  });


  Future getPartymembers() async {
    isLoading.value = true;

    try {
      final result = await repository.getPartymembers();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
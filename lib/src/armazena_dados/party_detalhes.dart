import 'package:flutter/material.dart';
import 'package:chamber_deputies/src/models/party_detalhado.dart';

import 'package:chamber_deputies/src/repositories/party_detalhes.dart';


class PartyDetailsStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<PartyDetailsModel> value =
      ValueNotifier<PartyDetailsModel>(PartyDetailsModel());
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final PartyDetailsRepository repository;

  PartyDetailsStore({
    required this.repository,
  });

  Future getPartyDetails() async {
    isLoading.value = true;

    try {
      final result = await repository.getPartyDetails();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future getPartymembers() async {
    isLoading.value = true;

    try {
      final result = await repository.getPartyDetails();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
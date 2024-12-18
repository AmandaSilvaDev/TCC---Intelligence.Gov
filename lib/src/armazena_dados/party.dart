import 'package:chamber_deputies/src/models/party.dart';
import 'package:flutter/material.dart';
import 'package:chamber_deputies/src/repositories/party.dart';

class PartyStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Partymodels>> value =
      ValueNotifier<List<Partymodels>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final PartyRepository repository;

  PartyStore({
    required this.repository,
  });

  Future getparty() async {
    isLoading.value = true;

    try {
      final result = await repository.getparty();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getpartyById(int id) async {
    isLoading.value = true;

    try {
      final result = await repository.getpartyById(id);
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future filterparty(String? name, String? sigla, String ? urlLogo,
      String? uri) async {
    isLoading.value = true;

    try {
      final result =
          await repository.filterparty(name, sigla, urlLogo, uri);
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  
}

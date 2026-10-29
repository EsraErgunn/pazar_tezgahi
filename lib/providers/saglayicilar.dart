import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pazar_urunu_modeli.dart';
import '../services/i_pazar_servisi.dart';
import '../services/sahte_pazar_servisi.dart';

// ==========================================
// ===== TUBA (1. Geliştirici) BÖLÜMÜ =====
// ==========================================

final pazarServisiSaglayici = Provider<IPazarServisi>((ref) {
  return const SahtePazarServisi();
});

class UrunListesiYoneticisi extends AsyncNotifier<List<PazarUrunu>> {
  @override
  Future<List<PazarUrunu>> build() => _yukle();

  Future<List<PazarUrunu>> _yukle() async {
    final temel = await ref.read(pazarServisiSaglayici).urunleriGetir();
    return temel;
  }

  Future<void> yenile() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_yukle);
  }

  Future<void> urunEkle(PazarUrunu urun) async {
    final mevcut = state.value ?? [];
    state = AsyncData([urun, ...mevcut]);
  }
}

final urunListesiSaglayici =
    AsyncNotifierProvider<UrunListesiYoneticisi, List<PazarUrunu>>(
        UrunListesiYoneticisi.new);

final aramaSaglayici = StateProvider<String>((ref) => '');

final kategoriSaglayici =
    StateProvider<UrunKategorisi>((ref) => UrunKategorisi.tumu);

final filtreliUrunlerSaglayici = Provider<AsyncValue<List<PazarUrunu>>>((ref) {
  final sorgu = ref.watch(aramaSaglayici);
  final kategori = ref.watch(kategoriSaglayici);

  return ref.watch(urunListesiSaglayici).whenData((liste) {
    return liste.where((u) {
      final kategoriUyar =
          kategori == UrunKategorisi.tumu || u.kategori == kategori;
      final aramaUyar = sorgu.isEmpty || u.aramaEslesir(sorgu);
      return kategoriUyar && aramaUyar;
    }).toList();
  });
});

// ==========================================
// ===== ESRA (3. Geliştirici) BÖLÜMÜ =====
// ==========================================
// Bu bölüm Esra tarafından doldurulacaktır.
// Sözleşme gereği tema yönetimi ve yerel depolama burada yer alacaktır.

class TemaYoneticisi extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.light;

  void degistir() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final temaSaglayici =
    NotifierProvider<TemaYoneticisi, ThemeMode>(TemaYoneticisi.new);

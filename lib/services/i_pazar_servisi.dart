import '../models/pazar_urunu_modeli.dart';

abstract class IPazarServisi {
  Future<List<PazarUrunu>> urunleriGetir();
  Future<PazarUrunu?> urunGetir(String id);
}

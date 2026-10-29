enum UrunKategorisi {
  tumu('Tümü'), sebze('Sebze'), meyve('Meyve'),
  kahvaltilikSut('Kahvaltılık/Süt'), zeytinYag('Zeytin/Yağ'), kuruyemis('Kuruyemiş');
  const UrunKategorisi(this.etiket);
  final String etiket;
}

enum UrunRozeti {
  yok(''), organik('Organik'), tukendi('Tükendi'), tazeGeldi('Taze Geldi');
  const UrunRozeti(this.etiket);
  final String etiket;
}

enum OlcuBirimi {
  kilo('kg'), adet('adet');
  const OlcuBirimi(this.etiket);
  final String etiket;
}

class PazarUrunu {
  final String id, ad, uretici, pazarYeri, pazarGunu, tezgahNo;
  final String acilisSaatleri, yetistirilenBolge, hasatTarihi;
  final String saklamaOnerisi, aciklama, gorselUrl;
  final UrunKategorisi kategori;
  final UrunRozeti rozet;
  final OlcuBirimi birim;
  final double birimFiyat, stokMiktari;

  const PazarUrunu({
    required this.id, required this.ad, required this.uretici,
    required this.pazarYeri, required this.pazarGunu, required this.tezgahNo,
    required this.acilisSaatleri, required this.yetistirilenBolge,
    required this.hasatTarihi, required this.saklamaOnerisi,
    required this.aciklama, required this.gorselUrl, required this.kategori,
    this.rozet = UrunRozeti.yok, this.birim = OlcuBirimi.kilo,
    required this.birimFiyat, required this.stokMiktari,
  });

  factory PazarUrunu.fromJson(Map<String, dynamic> json) => PazarUrunu(
    id: json['id'] as String? ?? '',
    ad: json['ad'] as String? ?? '',
    uretici: json['uretici'] as String? ?? '',
    pazarYeri: json['pazarYeri'] as String? ?? '',
    pazarGunu: json['pazarGunu'] as String? ?? '',
    tezgahNo: json['tezgahNo'] as String? ?? '',
    acilisSaatleri: json['acilisSaatleri'] as String? ?? '',
    yetistirilenBolge: json['yetistirilenBolge'] as String? ?? '',
    hasatTarihi: json['hasatTarihi'] as String? ?? '',
    saklamaOnerisi: json['saklamaOnerisi'] as String? ?? '',
    aciklama: json['aciklama'] as String? ?? '',
    gorselUrl: json['gorselUrl'] as String? ?? '',
    kategori: UrunKategorisi.values.firstWhere(
      (k) => k.name == json['kategori'], orElse: () => UrunKategorisi.sebze),
    rozet: UrunRozeti.values.firstWhere(
      (r) => r.name == json['rozet'], orElse: () => UrunRozeti.yok),
    birim: OlcuBirimi.values.firstWhere(
      (b) => b.name == json['birim'], orElse: () => OlcuBirimi.kilo),
    birimFiyat: (json['birimFiyat'] as num?)?.toDouble() ?? 0.0,
    stokMiktari: (json['stokMiktari'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'ad': ad, 'uretici': uretici, 'pazarYeri': pazarYeri,
    'pazarGunu': pazarGunu, 'tezgahNo': tezgahNo, 'acilisSaatleri': acilisSaatleri,
    'yetistirilenBolge': yetistirilenBolge, 'hasatTarihi': hasatTarihi,
    'saklamaOnerisi': saklamaOnerisi, 'aciklama': aciklama, 'gorselUrl': gorselUrl,
    'kategori': kategori.name, 'rozet': rozet.name, 'birim': birim.name,
    'birimFiyat': birimFiyat, 'stokMiktari': stokMiktari,
  };

  PazarUrunu copyWith({
    String? id, String? ad, String? uretici, String? pazarYeri,
    String? pazarGunu, String? tezgahNo, String? acilisSaatleri,
    String? yetistirilenBolge, String? hasatTarihi, String? saklamaOnerisi,
    String? aciklama, String? gorselUrl, UrunKategorisi? kategori,
    UrunRozeti? rozet, OlcuBirimi? birim, double? birimFiyat, double? stokMiktari,
  }) => PazarUrunu(
    id: id ?? this.id, ad: ad ?? this.ad, uretici: uretici ?? this.uretici,
    pazarYeri: pazarYeri ?? this.pazarYeri, pazarGunu: pazarGunu ?? this.pazarGunu,
    tezgahNo: tezgahNo ?? this.tezgahNo, acilisSaatleri: acilisSaatleri ?? this.acilisSaatleri,
    yetistirilenBolge: yetistirilenBolge ?? this.yetistirilenBolge,
    hasatTarihi: hasatTarihi ?? this.hasatTarihi,
    saklamaOnerisi: saklamaOnerisi ?? this.saklamaOnerisi,
    aciklama: aciklama ?? this.aciklama, gorselUrl: gorselUrl ?? this.gorselUrl,
    kategori: kategori ?? this.kategori, rozet: rozet ?? this.rozet,
    birim: birim ?? this.birim, birimFiyat: birimFiyat ?? this.birimFiyat,
    stokMiktari: stokMiktari ?? this.stokMiktari,
  );

  /// Türkçe harf duyarsız arama (İ/I, ı/i sorununu önler).
  bool aramaEslesir(String sorgu) {
    String sade(String s) => s
        .replaceAll('İ', 'i').replaceAll('I', 'i').replaceAll('ı', 'i')
        .toLowerCase()
        .replaceAll('ç', 'c').replaceAll('ğ', 'g').replaceAll('ö', 'o')
        .replaceAll('ş', 's').replaceAll('ü', 'u');
    final q = sade(sorgu.trim());
    return sade(ad).contains(q) || sade(pazarYeri).contains(q);
  }
}

class Ayirtma {
  final String id, urunId, urunAdi, tezgahNo, pazarYeri, not;
  final double miktar, birimFiyat;
  final OlcuBirimi birim;
  final bool topluTalepMi;
  final DateTime tarih;

  double get tutar => miktar * birimFiyat;

  const Ayirtma({
    required this.id, required this.urunId, required this.urunAdi,
    required this.tezgahNo, required this.pazarYeri, required this.not,
    required this.miktar, required this.birimFiyat,
    this.birim = OlcuBirimi.kilo, this.topluTalepMi = false,
    required this.tarih,
  });

  factory Ayirtma.fromJson(Map<String, dynamic> json) => Ayirtma(
    id: json['id'] as String? ?? '',
    urunId: json['urunId'] as String? ?? '',
    urunAdi: json['urunAdi'] as String? ?? '',
    tezgahNo: json['tezgahNo'] as String? ?? '',
    pazarYeri: json['pazarYeri'] as String? ?? '',
    not: json['not'] as String? ?? '',
    miktar: (json['miktar'] as num?)?.toDouble() ?? 0.0,
    birimFiyat: (json['birimFiyat'] as num?)?.toDouble() ?? 0.0,
    birim: OlcuBirimi.values.firstWhere(
      (b) => b.name == json['birim'], orElse: () => OlcuBirimi.kilo),
    topluTalepMi: json['topluTalepMi'] as bool? ?? false,
    tarih: json['tarih'] != null
        ? DateTime.tryParse(json['tarih'] as String) ?? DateTime.now()
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'urunId': urunId, 'urunAdi': urunAdi, 'tezgahNo': tezgahNo,
    'pazarYeri': pazarYeri, 'not': not, 'miktar': miktar,
    'birimFiyat': birimFiyat, 'birim': birim.name,
    'topluTalepMi': topluTalepMi, 'tarih': tarih.toIso8601String(),
  };

  Ayirtma copyWith({
    String? id, String? urunId, String? urunAdi, String? tezgahNo,
    String? pazarYeri, String? not, double? miktar, double? birimFiyat,
    OlcuBirimi? birim, bool? topluTalepMi, DateTime? tarih,
  }) => Ayirtma(
    id: id ?? this.id, urunId: urunId ?? this.urunId, urunAdi: urunAdi ?? this.urunAdi,
    tezgahNo: tezgahNo ?? this.tezgahNo, pazarYeri: pazarYeri ?? this.pazarYeri,
    not: not ?? this.not, miktar: miktar ?? this.miktar,
    birimFiyat: birimFiyat ?? this.birimFiyat, birim: birim ?? this.birim,
    topluTalepMi: topluTalepMi ?? this.topluTalepMi, tarih: tarih ?? this.tarih,
  );
}

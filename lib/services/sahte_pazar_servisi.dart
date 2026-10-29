import '../models/pazar_urunu_modeli.dart';
import 'i_pazar_servisi.dart';

class SahtePazarServisi implements IPazarServisi {
  final bool hataSimulasyonu;
  const SahtePazarServisi({this.hataSimulasyonu = false});

  static final List<Map<String, dynamic>> _kayitlar = [
    {
      'id': 'u01', 'ad': 'Organik Salkım Domates', 'uretici': 'Ayşe Hanım Çiftliği',
      'pazarYeri': 'Kadıköy Salı Pazarı', 'pazarGunu': 'Salı', 'tezgahNo': 'B-12',
      'acilisSaatleri': '07:00 - 18:00', 'yetistirilenBolge': 'Bursa / Mudanya',
      'hasatTarihi': '28 Ekim 2026', 'saklamaOnerisi': 'Buzdolabı dışında, serin yerde',
      'aciklama': 'İlaçsız, doğal gübreyle yetiştirilmiş mis kokulu salkım domates.',
      'gorselUrl': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500',
      'kategori': 'sebze', 'rozet': 'organik', 'birim': 'kilo',
      'birimFiyat': 55.0, 'stokMiktari': 45.0,
    },
    {
      'id': 'u02', 'ad': 'Köy Biberi', 'uretici': 'Mehmet Amca Bahçesi',
      'pazarYeri': 'Feriköy Organik Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'C-04',
      'acilisSaatleri': '08:00 - 17:00', 'yetistirilenBolge': 'Çanakkale / Biga',
      'hasatTarihi': '27 Ekim 2026', 'saklamaOnerisi': 'Sebzelik bölmesinde hava alarak saklayınız',
      'aciklama': 'Çıtır çıtır, hafif tatlı taze köy biberi.',
      'gorselUrl': 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=500',
      'kategori': 'sebze', 'rozet': 'tazeGeldi', 'birim': 'kilo',
      'birimFiyat': 60.0, 'stokMiktari': 30.0,
    },
    {
      'id': 'u03', 'ad': 'Çengelköy Salatalık', 'uretici': 'Beykoz Bostanı',
      'pazarYeri': 'Beşiktaş Cumartesi Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'A-08',
      'acilisSaatleri': '07:30 - 18:30', 'yetistirilenBolge': 'İstanbul / Beykoz',
      'hasatTarihi': '26 Ekim 2026', 'saklamaOnerisi': 'Serin yerde muhafaza ediniz',
      'aciklama': 'Küçük boy, ince kabuklu, sulu çıtır salatalık.',
      'gorselUrl': 'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=500',
      'kategori': 'sebze', 'rozet': 'tukendi', 'birim': 'kilo',
      'birimFiyat': 40.0, 'stokMiktari': 0.0,
    },
    {
      'id': 'u04', 'ad': 'Amasya Elması', 'uretici': 'Elma Vadisi',
      'pazarYeri': 'Kadıköy Salı Pazarı', 'pazarGunu': 'Salı', 'tezgahNo': 'D-15',
      'acilisSaatleri': '07:00 - 18:00', 'yetistirilenBolge': 'Amasya',
      'hasatTarihi': '20 Ekim 2026', 'saklamaOnerisi': 'Serin ve kuru ortamda saklayınız',
      'aciklama': 'Geleneksel Amasya misket elması, sert ve sulu.',
      'gorselUrl': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=500',
      'kategori': 'meyve', 'rozet': 'organik', 'birim': 'kilo',
      'birimFiyat': 45.0, 'stokMiktari': 60.0,
    },
    {
      'id': 'u05', 'ad': 'Bursa Şeftalisi', 'uretici': 'Gürsu Meyvecilik',
      'pazarYeri': 'Yeşilköy Çarşamba Pazarı', 'pazarGunu': 'Çarşamba', 'tezgahNo': 'B-03',
      'acilisSaatleri': '08:00 - 18:00', 'yetistirilenBolge': 'Bursa / Gürsu',
      'hasatTarihi': '25 Ekim 2026', 'saklamaOnerisi': 'Oda sıcaklığında olgunlaştırınız',
      'aciklama': 'Büyük boy, tatlı ve aromatik Bursa şeftalisi.',
      'gorselUrl': 'https://images.unsplash.com/photo-1595156972049-b05b637996c5?w=500',
      'kategori': 'meyve', 'rozet': 'tazeGeldi', 'birim': 'kilo',
      'birimFiyat': 75.0, 'stokMiktari': 25.0,
    },
    {
      'id': 'u06', 'ad': 'Anamur Muzu', 'uretici': 'Toros Narenciye',
      'pazarYeri': 'Beşiktaş Cumartesi Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'C-11',
      'acilisSaatleri': '07:30 - 18:30', 'yetistirilenBolge': 'Mersin / Anamur',
      'hasatTarihi': '26 Ekim 2026', 'saklamaOnerisi': 'Oda sıcaklığında asarak saklayınız',
      'aciklama': 'Yerli küçük boy kokulu Anamur muzu.',
      'gorselUrl': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500',
      'kategori': 'meyve', 'rozet': 'yok', 'birim': 'kilo',
      'birimFiyat': 85.0, 'stokMiktari': 35.0,
    },
    {
      'id': 'u07', 'ad': 'Ezine Beyaz Peynir', 'uretici': 'Kazdağı Mandırası',
      'pazarYeri': 'Kadıköy Salı Pazarı', 'pazarGunu': 'Salı', 'tezgahNo': 'E-02',
      'acilisSaatleri': '07:00 - 18:00', 'yetistirilenBolge': 'Çanakkale / Ezine',
      'hasatTarihi': '15 Ekim 2026', 'saklamaOnerisi': 'Kendi salamura suyunda buzdolabında',
      'aciklama': 'Koyun ve keçi sütü karışımı tam yağlı klasik Ezine peyniri.',
      'gorselUrl': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=500',
      'kategori': 'kahvaltilikSut', 'rozet': 'organik', 'birim': 'kilo',
      'birimFiyat': 290.0, 'stokMiktari': 20.0,
    },
    {
      'id': 'u08', 'ad': 'Köy Tereyağı', 'uretici': 'Trabzon Yayla Evi',
      'pazarYeri': 'Feriköy Organik Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'E-08',
      'acilisSaatleri': '08:00 - 17:00', 'yetistirilenBolge': 'Trabzon / Tonya',
      'hasatTarihi': '24 Ekim 2026', 'saklamaOnerisi': 'Buzdolabında kapalı kapta saklayınız',
      'aciklama': 'Geleneksel yayık tereyağı, katkısız ve mis kokulu.',
      'gorselUrl': 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=500',
      'kategori': 'kahvaltilikSut', 'rozet': 'tazeGeldi', 'birim': 'kilo',
      'birimFiyat': 360.0, 'stokMiktari': 15.0,
    },
    {
      'id': 'u09', 'ad': 'Gezen Tavuk Yumurtası', 'uretici': 'Bolu Köy Çiftliği',
      'pazarYeri': 'Yeşilköy Çarşamba Pazarı', 'pazarGunu': 'Çarşamba', 'tezgahNo': 'E-05',
      'acilisSaatleri': '08:00 - 18:00', 'yetistirilenBolge': 'Bolu / Mengen',
      'hasatTarihi': '27 Ekim 2026', 'saklamaOnerisi': 'Buzdolabında sivri ucu aşağıda',
      'aciklama': 'Doğada serbest gezen tavukların günlük taze yumurtası.',
      'gorselUrl': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=500',
      'kategori': 'kahvaltilikSut', 'rozet': 'organik', 'birim': 'adet',
      'birimFiyat': 6.5, 'stokMiktari': 120.0,
    },
    {
      'id': 'u10', 'ad': 'Soğuk Sıkım Zeytinyağı', 'uretici': 'Edremit Zeytinliği',
      'pazarYeri': 'Feriköy Organik Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'F-01',
      'acilisSaatleri': '08:00 - 17:00', 'yetistirilenBolge': 'Balıkesir / Edremit',
      'hasatTarihi': '10 Ekim 2026', 'saklamaOnerisi': 'Işık almayan serin ortamda saklayınız',
      'aciklama': 'Erken hasat, asit oranı 0.4 altı soğuk sıkım natürel sızma (1L).',
      'gorselUrl': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500',
      'kategori': 'zeytinYag', 'rozet': 'organik', 'birim': 'adet',
      'birimFiyat': 340.0, 'stokMiktari': 25.0,
    },
    {
      'id': 'u11', 'ad': 'Gemlik Yağlı Sele Siyah Zeytin', 'uretici': 'Gemlik Zeytincisi',
      'pazarYeri': 'Kadıköy Salı Pazarı', 'pazarGunu': 'Salı', 'tezgahNo': 'F-07',
      'acilisSaatleri': '07:00 - 18:00', 'yetistirilenBolge': 'Bursa / Gemlik',
      'hasatTarihi': '18 Ekim 2026', 'saklamaOnerisi': 'Hafif zeytinyağı ilave ederek saklayınız',
      'aciklama': 'İnce kabuklu, küçük çekirdekli doğal fermente siyah zeytin.',
      'gorselUrl': 'https://images.unsplash.com/photo-1541256942802-7b2996800bc1?w=500',
      'kategori': 'zeytinYag', 'rozet': 'yok', 'birim': 'kilo',
      'birimFiyat': 195.0, 'stokMiktari': 30.0,
    },
    {
      'id': 'u12', 'ad': 'Kırma Yeşil Zeytin', 'uretici': 'Ege Bahçeleri',
      'pazarYeri': 'Beşiktaş Cumartesi Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'F-12',
      'acilisSaatleri': '07:30 - 18:30', 'yetistirilenBolge': 'Aydın / Kuşadası',
      'hasatTarihi': '22 Ekim 2026', 'saklamaOnerisi': 'Salamura suyunda buzdolabında',
      'aciklama': 'Limon ve kaya tuzuyla tatlandırılmış taze kırma yeşil zeytin.',
      'gorselUrl': 'https://images.unsplash.com/photo-1541256942802-7b2996800bc1?w=500',
      'kategori': 'zeytinYag', 'rozet': 'tazeGeldi', 'birim': 'kilo',
      'birimFiyat': 180.0, 'stokMiktari': 18.0,
    },
    {
      'id': 'u13', 'ad': 'Giresun Çifte Kavrulmuş Fındık', 'uretici': 'Yeşil Giresun Çiftliği',
      'pazarYeri': 'Yeşilköy Çarşamba Pazarı', 'pazarGunu': 'Çarşamba', 'tezgahNo': 'G-03',
      'acilisSaatleri': '08:00 - 18:00', 'yetistirilenBolge': 'Giresun / Görele',
      'hasatTarihi': '12 Ekim 2026', 'saklamaOnerisi': 'Hava almayan cam kavanozda saklayınız',
      'aciklama': 'Giresun kalite, taze çifte kavrulmuş çıtır tombul fındık.',
      'gorselUrl': 'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?w=500',
      'kategori': 'kuruyemis', 'rozet': 'yok', 'birim': 'kilo',
      'birimFiyat': 430.0, 'stokMiktari': 20.0,
    },
    {
      'id': 'u14', 'ad': 'Aydın Dağ İnciri', 'uretici': 'Büyük Menderes Kooperatifi',
      'pazarYeri': 'Kadıköy Salı Pazarı', 'pazarGunu': 'Salı', 'tezgahNo': 'G-09',
      'acilisSaatleri': '07:00 - 18:00', 'yetistirilenBolge': 'Aydın / Germencik',
      'hasatTarihi': '05 Ekim 2026', 'saklamaOnerisi': 'Serin ve kuru yerde saklayınız',
      'aciklama': 'Dalında kurutulmuş, bal kıvamında doğal sarı lop incir.',
      'gorselUrl': 'https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?w=500',
      'kategori': 'kuruyemis', 'rozet': 'organik', 'birim': 'kilo',
      'birimFiyat': 380.0, 'stokMiktari': 15.0,
    },
    {
      'id': 'u15', 'ad': 'Maraş Kabuklu Ceviz', 'uretici': 'Kafkas Dağ Çiftliği',
      'pazarYeri': 'Feriköy Organik Pazarı', 'pazarGunu': 'Cumartesi', 'tezgahNo': 'G-14',
      'acilisSaatleri': '08:00 - 17:00', 'yetistirilenBolge': 'Kahramanmaraş',
      'hasatTarihi': '14 Ekim 2026', 'saklamaOnerisi': 'Bez torbada havadar ortamda',
      'aciklama': 'İnce kabuklu, elle kırılabilen yeni mahsul ceviz.',
      'gorselUrl': 'https://images.unsplash.com/photo-1568252542512-9fe8fe9c87bb?w=500',
      'kategori': 'kuruyemis', 'rozet': 'tazeGeldi', 'birim': 'kilo',
      'birimFiyat': 260.0, 'stokMiktari': 30.0,
    },
  ];

  @override
  Future<List<PazarUrunu>> urunleriGetir() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (hataSimulasyonu) throw Exception('Pazar verileri yüklenirken bir hata oluştu.');
    return _kayitlar.map(PazarUrunu.fromJson).toList();
  }

  @override
  Future<PazarUrunu?> urunGetir(String id) async {
    final liste = await urunleriGetir();
    for (final u in liste) {
      if (u.id == id) return u;
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pazar_urunu_modeli.dart';
import '../providers/saglayicilar.dart';
import '../widgets/urun_karti.dart';
import 'urun_detay_sayfasi.dart';

class TezgahListesiSayfasi extends ConsumerStatefulWidget {
  const TezgahListesiSayfasi({super.key});

  @override
  ConsumerState<TezgahListesiSayfasi> createState() =>
      _TezgahListesiSayfasiState();
}

class _TezgahListesiSayfasiState extends ConsumerState<TezgahListesiSayfasi> {
  final TextEditingController _aramaDenetleyici = TextEditingController();

  @override
  void dispose() {
    _aramaDenetleyici.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temaModu = ref.watch(temaSaglayici);
    final urunlerDurumu = ref.watch(filtreliUrunlerSaglayici);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TazeTezgah'),
        actions: [
          IconButton(
            tooltip: temaModu == ThemeMode.dark ? 'Açık Tema' : 'Koyu Tema',
            icon: Icon(temaModu == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode_outlined),
            onPressed: () => ref.read(temaSaglayici.notifier).degistir(),
          ),
        ],
      ),
      body: Column(
        children: [
          _aramaCubugu(),
          _kategoriFiltresi(),
          Expanded(
            child: urunlerDurumu.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => _DurumGorunumu(
                ikon: Icons.wifi_off,
                mesaj: 'Bağlantı hatası oluştu. Lütfen tekrar deneyin.',
                butonYazisi: 'Tekrar Dene',
                butonaBasilinca: () =>
                    ref.read(urunListesiSaglayici.notifier).yenile(),
              ),
              data: (liste) => liste.isEmpty
                  ? const _DurumGorunumu(
                      ikon: Icons.search_off,
                      mesaj: 'Aramanıza uygun ürün bulunamadı.')
                  : RefreshIndicator(
                      onRefresh: () =>
                          ref.read(urunListesiSaglayici.notifier).yenile(),
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220, mainAxisExtent: 270,
                          crossAxisSpacing: 12, mainAxisSpacing: 12,
                        ),
                        itemCount: liste.length,
                        itemBuilder: (context, i) => UrunKarti(
                          urun: liste[i],
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => UrunDetaySayfasi(urun: liste[i]),
                          )),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aramaCubugu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextField(
        controller: _aramaDenetleyici,
        decoration: InputDecoration(
          hintText: 'Ürün veya semt pazarı ara…',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _aramaDenetleyici.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _aramaDenetleyici.clear();
                    ref.read(aramaSaglayici.notifier).state = '';
                  })
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onChanged: (v) {
          ref.read(aramaSaglayici.notifier).state = v;
          setState(() {});
        },
      ),
    );
  }

  Widget _kategoriFiltresi() {
    final secili = ref.watch(kategoriSaglayici);
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (final k in UrunKategorisi.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(k.etiket),
                selected: secili == k,
                onSelected: (_) =>
                    ref.read(kategoriSaglayici.notifier).state = k,
              ),
            ),
        ],
      ),
    );
  }
}

class _DurumGorunumu extends StatelessWidget {
  final IconData ikon;
  final String mesaj;
  final String? butonYazisi;
  final VoidCallback? butonaBasilinca;

  const _DurumGorunumu({
    required this.ikon,
    required this.mesaj,
    this.butonYazisi,
    this.butonaBasilinca,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(mesaj, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
            if (butonYazisi != null && butonaBasilinca != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FilledButton.icon(
                  onPressed: butonaBasilinca,
                  icon: const Icon(Icons.refresh),
                  label: Text(butonYazisi!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../components/bottom_bar.dart';
import '../components/dialogs/app_info_dialog.dart';
import '../components/error_info.dart';
import '../components/inputs/arv_stations_selector.dart';
import '../components/inputs/cond_save_button.dart';
import '../components/inputs/direction_selector.dart';
import '../components/inputs/saved_cond_list_button.dart';
import '../components/inputs/station_input.dart';
import '../components/inputs/target_date_selector.dart';
import '../components/inputs/time_selector.dart';
import '../components/train_list_tile.dart';
import '../models/search_condition.dart';
import '../models/service.dart';
import '../providers/local_storage.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    if (ref.read(localStorageProvider).initKey == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async => await showDialog(
        context: context, barrierDismissible: false,
        builder: (context) => const AppInfoDialog()
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final initialized = ref.watch(localStorageProvider).initKey != null;
    final service = ref.watch(serviceProvider);
    final cond = ref.watch(condProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('列車検索'),
        toolbarHeight: 40,
        backgroundColor: const Color(0xFFF05322),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: '本アプリについて',
            onPressed: () async => await showDialog(
              context: context,
              builder: (context) => const AppInfoDialog()
            )
          )
        ]
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).cardColor,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const TargetDateSelector(),
                const Gap(4),
                const Row(children: [Gap(8), TimeSelector(), Text('以降')])
              ]
            ),
            const Gap(16),
            Expanded(child: Builder(builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const StationInput(),
                if (service.value?.stations.containsKey(cond.depID) == true)
                  ...(const [
                    Gap(8),
                    DirectionSelector(),
                    Gap(2),
                    ArvStationsSelector(),
                    Gap(4),
                    Row(children: [
                      Spacer(),
                      SavedCondListButton(),
                      Gap(10),
                      CondSaveButton()
                    ])
                  ])
              ]
            )))
          ])
        ),
        if (service.hasError)  Expanded(child: ErrInfoWidget(
          message: kDebugMode ? service.error.toString() : null,
          detail: kDebugMode ? service.stackTrace.toString() : null
        ))
        else if (service.hasValue && initialized) () {
          final trains = service.value?.getTrains(cond) ?? [];
          return trains.isEmpty ? const Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8),
            child: Center(child: Text(
              '条件に一致する列車はありません',
              style: TextStyle(color: Colors.grey)
            ))
          ) : Expanded(child: ListView.builder(
            itemCount: trains.length,
            itemBuilder: (context, idx) => TrainListTile(train: trains[idx])
          ));
        }()
        else
          const Expanded(child: Center(child: CircularProgressIndicator()))
      ]),
      bottomNavigationBar: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () => launchUrl(Uri.parse('https://x.com/pwrSupplyTrnApp')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              visualDensity: VisualDensity.compact, elevation: 1
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const FaIcon(FontAwesomeIcons.xTwitter, size: 16),
              const Gap(6),
              Text('最新情報\nお問合せ', style: const TextStyle(
                fontSize: 10, height: 1.1
              ))
            ])
          )
        ])
      )
    );
  }
}


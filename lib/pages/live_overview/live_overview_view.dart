import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/pages/live_overview/live_overview.dart';
import 'package:ecoparking_management/pages/live_overview/widgets/info_multi_columns.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LiveOverviewView extends StatelessWidget with ViewLoggy {
  final LiveOverviewController controller;

  const LiveOverviewView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.liveOverview.label,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            children: <Widget>[
              InfoMultiColumns(
                columns: <ColumnArguments>[
                  ColumnArguments(
                    highlightedChild: RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: '6',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 24.0,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                          TextSpan(
                            text: ' / 10',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 24.0,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    secondaryChild: Text(
                      'Parking Lots Occupied',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                  ColumnArguments(
                    highlightedChild: Text(
                      '${controller.format.simpleCurrencySymbol("VND")} 100000',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    secondaryChild: Text(
                      'Parking Lots Occupied',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                  ColumnArguments(
                    highlightedChild: Text(
                      '100',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    secondaryChild: Text(
                      'Total Customers today',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

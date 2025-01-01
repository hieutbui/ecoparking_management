import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InfoMultiColumns extends StatelessWidget {
  final List<ColumnArguments> columns;

  const InfoMultiColumns({
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const FlexColumnWidth(),
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
              width: 1.0,
            ),
          ),
          children: columns.map((column) {
            final index = columns.indexOf(column);

            return TableCell(
              child: MouseRegion(
                cursor: column.onTap != null
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: column.onTap,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 22.0,
                      left: 24.0,
                      bottom: 24.0,
                      right: 28.0,
                    ),
                    decoration: BoxDecoration(
                      border: index != 0 && index != columns.length - 1
                          ? Border(
                              right: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1.0,
                              ),
                              left: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1.0,
                              ),
                            )
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        column.highlightedChild,
                        const SizedBox(height: 8.0),
                        column.secondaryChild,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ColumnArguments with EquatableMixin {
  final Widget highlightedChild;
  final Widget secondaryChild;
  final void Function()? onTap;

  const ColumnArguments({
    required this.highlightedChild,
    required this.secondaryChild,
    this.onTap,
  });

  @override
  List<Object?> get props => [
        highlightedChild,
        secondaryChild,
        onTap,
      ];
}

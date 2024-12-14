import 'package:flutter/material.dart';

class TableInfo extends StatelessWidget {
  final List<String> titles;
  final List<DataRow> data;
  final int rowPerPage;
  final List<Widget>? actions;
  final Widget? header;
  final void Function(int?)? onRowsPerPageChanged;
  final List<DataRow>? emptyData;

  const TableInfo({
    super.key,
    required this.titles,
    required this.data,
    required this.rowPerPage,
    this.header,
    this.actions,
    this.onRowsPerPageChanged,
    this.emptyData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth,
          child: PaginatedDataTable(
            showCheckboxColumn: true,
            header: header,
            actions: actions,
            columns: titles
                .map(
                  (title) => DataColumn(
                    label: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: const Color(0xFF9E9E9E),
                              ),
                    ),
                  ),
                )
                .toList(),
            source: TableInfoSource(
              data: data,
              emptyData: emptyData,
            ),
            onRowsPerPageChanged: onRowsPerPageChanged,
            rowsPerPage: rowPerPage > 0 ? rowPerPage : 1,
            showEmptyRows: false,
            availableRowsPerPage: rowPerPage > 0
                ? <int>[
                    rowPerPage,
                    rowPerPage * 2,
                    rowPerPage * 5,
                    rowPerPage * 10,
                  ]
                : const <int>[
                    1,
                  ],
          ),
        );
      },
    );
  }
}

class TableInfoSource extends DataTableSource {
  final List<DataRow> data;
  final List<DataRow>? emptyData;

  TableInfoSource({
    required this.data,
    this.emptyData,
  });

  @override
  DataRow getRow(int index) {
    if (data.isNotEmpty) {
      return data[index];
    }

    if (emptyData != null && emptyData!.isNotEmpty) {
      return emptyData![index];
    }

    return const DataRow(
      cells: [
        DataCell(
          Text('No data'),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

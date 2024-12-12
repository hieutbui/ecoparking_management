import 'package:flutter/material.dart';

class TableInfo extends StatelessWidget {
  final List<String> titles;
  final List<DataRow> data;
  final int rowPerPage;
  final List<Widget>? actions;
  final Widget? header;
  final void Function(int?)? onRowsPerPageChanged;

  const TableInfo({
    super.key,
    required this.titles,
    required this.data,
    required this.rowPerPage,
    this.header,
    this.actions,
    this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth,
          child: PaginatedDataTable(
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
            source: TableInfoSource(data),
            onRowsPerPageChanged: onRowsPerPageChanged,
            rowsPerPage: rowPerPage,
            showEmptyRows: false,
            availableRowsPerPage: <int>[
              rowPerPage,
              rowPerPage * 2,
              rowPerPage * 5,
              rowPerPage * 10,
            ],
          ),
        );
      },
    );
  }
}

class TableInfoSource extends DataTableSource {
  final List<DataRow> data;

  TableInfoSource(this.data);

  @override
  DataRow getRow(int index) {
    return data[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

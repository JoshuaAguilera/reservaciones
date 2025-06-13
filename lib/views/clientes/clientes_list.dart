import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

class ClientesList extends StatefulWidget {
  const ClientesList({super.key});

  @override
  State<ClientesList> createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          // Consumer(
          //   builder: (context, ref, _) {
          //     final search = ref.watch(destinoSearchProvider);
          //     final filterList = ref.watch(filterFateProvider);
          //     final selectItem = ref.watch(selectFateProvider);
          //     final keyList = ref.watch(keyFateListProvider);
          //     final updateList = ref.watch(updateViewFateListProvider);

          //     Tuple3<String, String, String> _getArgRole() {
          //       return Tuple3(
          //         search,
          //         filterList.orderBy ?? "",
          //         keyList,
          //       );
          //     }

          //     return RiverPagedBuilder<int, Destino>(
          //       key: ValueKey(keyList + updateList),
          //       firstPageKey: 1,
          //       provider: destinosProvider(_getArgRole()),
          //       itemBuilder: (context, item, index) {
          //         return _DestinoItem(destino: item);
          //       },
          //       pagedBuilder: (controller, builder) {
          //         if (filterList.layout == Layout.mosaico) {
          //           return PagedGridView<int, Destino>(
          //             pagingController: controller,
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               mainAxisSpacing: 4,
          //               crossAxisSpacing: 4,
          //               childAspectRatio: 1.5,
          //             ),
          //             builderDelegate: builder,
          //           );
          //         } else if (filterList.layout == Layout.table) {
          //           return Card(
          //             child: Padding(
          //               padding: const EdgeInsets.all(14.0),
          //               child: Column(
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Table(
          //                       columnWidths: selectItem
          //                           ? {
          //                               0: FractionColumnWidth(0.12),
          //                               1: FractionColumnWidth(0.38),
          //                               2: FractionColumnWidth(0.25),
          //                               3: FractionColumnWidth(0.25),
          //                             }
          //                           : {
          //                               0: FractionColumnWidth(0.38),
          //                               1: FractionColumnWidth(0.24),
          //                               2: FractionColumnWidth(0.24),
          //                               3: FractionColumnWidth(0.1),
          //                             },
          //                       children: [
          //                         TableRow(
          //                           children: [
          //                             if (selectItem) SizedBox(),
          //                             _textW("Nombre", size: 14, isBold: true),
          //                             _textW("Cuenta Toalla",
          //                                 size: 14, isBold: true),
          //                             _textW("Cuenta Recurso",
          //                                 size: 14, isBold: true),
          //                             if (!selectItem) SizedBox(),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: PagedListView(
          //                       pagingController: controller,
          //                       builderDelegate: builder,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         } else {
          //           return PagedListView(
          //             pagingController: controller,
          //             builderDelegate: builder,
          //           );
          //         }
          //       },
          //       firstPageErrorIndicatorBuilder: (_, __) {
          //         return const MessageErrorScroll(
          //           title: "Error al consultar destinos",
          //         );
          //       },
          //       limit: 20,
          //       pullToRefresh: !selectItem,
          //       noMoreItemsIndicatorBuilder: (context, controller) {
          //         return MessageErrorScroll.messageNotFound();
          //       },
          //       noItemsFoundIndicatorBuilder: (_, __) {
          //         return const MessageErrorScroll(
          //           icon: Iconsax.flag_2_outline,
          //           title: 'No se encontraron destinos',
          //         );
          //       },
          //     );
          //   },
          // ),
          // Positioned(
          //   bottom: 8,
          //   right: 0,
          //   child: Buttons.floatingButton(
          //     context,
          //     tag: "addFate",
          //     icon: Iconsax.add_circle_outline,
          //     onPressed: () {
          //       pushScreen(
          //         context,
          //         screen: const DestinoForm(),
          //         withNavBar: true,
          //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// SeminarWidget(BuildContext context) {
//   int count = 1;
//   List<Widget> seminarList;

//   if (seminarList == null) {
//     seminarList = [];
//   }

//   return Column(children: [
//     Expanded(
//       child: createListView(),
//     ),
//     Container(
//       alignment: Alignment.bottomRight,
//       margin: const EdgeInsets.all(20),
//       child: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () async {
//           Navigator.pushNamed(context, '/formseminar');
//           // var seminar = await navigateToEntryForm(context, null);
//           // if (seminar != null) {
//           //   //TODO 2 Panggil Fungsi untuk Insert ke DB
//           //   int result = await dbHelperSeminar.insert(seminar);
//           //   if (result > 0) {
//           //     updateListView();
//           //   }
//           // }
//         },
//       ),
//     ),
//   ]);
// }



//   ListView createListView() {
//     TextStyle textStyle = Theme.of(context).textTheme.headline5;
//     return ListView.builder(
//       itemCount: count,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           color: Colors.white,
//           elevation: 2.0,
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.red,
//               child: Icon(Icons.date_range),
//             ),
//             title: Text(
//               "Judul Seminar",
//               style: textStyle,
//             ),
//             subtitle: Text("Pembicara : " +
//                 "\nWaktu : " +
//                 "\nLokasi : " +
//                 "\nKuota  : " +
//                 "\nHarga  : "),
//             trailing: GestureDetector(
//               child: Icon(Icons.delete),
//               onTap: () async {
//                 //Memanggil Fungsi untuk Delete dari DB berdasarkan Seminar
//                 // await dbHelperSeminar.delete(seminarList[index].id);
//                 // updateListView();
//               },
//             ),
//             onTap: () async {
//               // var seminar = await navigateToEntryForm(context, this.seminarList[index]);
//               // Memanggil Fungsi untuk Edit data
//               // await dbHelperSeminar.update(seminar);
//               // updateListView();
//             },
//           ),
//         );
//       },
//     );
//   }
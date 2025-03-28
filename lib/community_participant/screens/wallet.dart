import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';

class WalletScreen extends StatelessWidget{
  const WalletScreen({super.key});
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text('Wallet')),
    body: SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
        child: Column(
             children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Token Balance', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),),
                  const SizedBox(height: 5),
                  Text('150', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(children: [
                    SizedBox(width:70,height: 25,child:  ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,  minimumSize: Size(70, 25)), child: Text('Spend', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),))),
                    const SizedBox(width:7),
                    SizedBox(width: 70,height: 25,child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,  minimumSize: Size(70, 25)), child: Text('Earn', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),))),
                  ]),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex:2,
              child: Image(image: AssetImage(TImageStrings.wallet)))
          ],
        ),
        const SizedBox(height: 40),
        Text('Wallet', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTableTheme(
            data:  DataTableThemeData(
    headingTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold, 
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white 
          : Colors.black, // Changes based on theme
    ),
    dataTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white 
          : Colors.black, // Changes based on theme
    ),
  ),
            child: DataTable(
              columnSpacing: 35,
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
              DataColumn(label: Text('Date', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Activity', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Amount', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold))),
              ],
             rows: [DataRow(cells: [
              DataCell(Text('2025-1-15')),
              DataCell(Text('Challenge')),
              DataCell(Text('+20')),
             ],
             ),
             DataRow(cells: [
              DataCell(Text('2025-1-30')),
              DataCell(Text('Dispose')),
              DataCell(Text('+100')),
             ],
             ),
             DataRow(cells: [
              DataCell(Text('2025-2-6')),
              DataCell(Text('Challenge')),
              DataCell(Text('+20')),
             ],
             ),
             DataRow(cells: [
              DataCell(Text('2025-2-10')),
              DataCell(Text('Spend')),
              DataCell(Text('-100')),
             ],
             )
             ]
             ),
          ),
        )
             ],
        ),
      ),
    ),
  );
}
}
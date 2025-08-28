import 'package:bacto_quest/components/record.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset("assets/logo.png"),
        title: Text("Tooth Brushing", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").snapshots(), 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var record = documents[index];
                        var dateTime = DateTime.parse(record["date"].toDate().toString());

                        return RecordComponent(date: DateFormat("dd MMM yyyy").format(dateTime), time: DateFormat("HH:mm").format(dateTime));
                      });
                  }
                  
                  return Center(child: CircularProgressIndicator(color: ColorsAsset.primary));
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}
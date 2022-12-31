import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/editdata.dart';
import 'package:firebase_project/tambahdata.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _deleteData(String docID) async {
    await _firestore
        .collection("mahasiswa")
        .doc()
        .delete()
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection("mahasiswa").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final datas = snapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text(
                    datas['nama'],
                  ),
                  children: [
                    ListTile(
                      title: Text(datas['nim'].toString()),
                      subtitle: Text(datas['alamat']),
                      leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditData(
                                        docid: snapshot.data!.docs[index])));
                          },
                          icon: const Icon(Icons.edit)),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      const Text('Yakin Anda Menghapus Data'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _deleteData('doc_id');
                                      },
                                      child: const Text('Hapus'),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Batal'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TambahData()));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}

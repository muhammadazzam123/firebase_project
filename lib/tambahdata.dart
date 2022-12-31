import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/homepage.dart';
import 'package:flutter/material.dart';

class TambahData extends StatefulWidget {
  const TambahData({super.key});

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nim = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _alamat = TextEditingController();

  // _addDataNormal(String nim, String nama, String alamat) async {
  //   await _firestore
  //       .collection("mahasiswa")
  //       .add({"nim": nim, "nama": nama, "alamat": alamat})
  //       .then((value) {})
  //       .onError((error, stackTrace) {});
  // }

  _addDataWithDocID(String nim, String nama, String alamat) async {
    final getDocID = _firestore.collection("mahasiswa").doc().id;
    await _firestore
        .collection("mahasiswa")
        .doc(getDocID)
        .set({
          "doc_id": getDocID,
          "nim": nim,
          "nama": nama,
          "alamat": alamat,
        })
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  @override
  void dispose() {
    _nim.dispose();
    _nama.dispose();
    _alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  controller: _nim,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'NIM',
                    labelText: 'NIM',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NIM tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _nama,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _alamat,
                  decoration: InputDecoration(
                    hintText: 'Alamat',
                    labelText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _addDataWithDocID(_nim.text, _nama.text, _alamat.text);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

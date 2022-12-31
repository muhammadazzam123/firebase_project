import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/homepage.dart';
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {
  final DocumentSnapshot docid;
  const EditData({super.key, required this.docid});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _nim = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  // _editData(String docID, String nim, String nama, String alamat) async {
  //   await _firestore
  //       .collection("mahasiswa")
  //       .doc(docID)
  //       .update({"nim": nim, "nama": nama, "alamat": alamat})
  //       .then((value) {})
  //       .onError((error, stackTrace) {});
  // }

  @override
  void initState() {
    _nim = TextEditingController(text: widget.docid.get('nim'));
    _nama = TextEditingController(text: widget.docid.get('nama'));
    _alamat = TextEditingController(text: widget.docid.get('alamat'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
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
                      widget.docid.reference.update({
                        'nim': _nim.text,
                        'nama': _nama.text,
                        'alamat': _alamat.text,
                      }).whenComplete(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      });
                    },
                    child: const Text(
                      'Update',
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

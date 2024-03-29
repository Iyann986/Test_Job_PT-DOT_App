import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:test_job_pt_dot_app/utils/const/theme.dart';
import 'package:test_job_pt_dot_app/view/screen/category/kategori.dart';
import 'package:test_job_pt_dot_app/view/screen/home/home_screen.dart';

class TambahPengeluaranBaru extends StatefulWidget {
  const TambahPengeluaranBaru({super.key});

  @override
  State<TambahPengeluaranBaru> createState() => _TambahPengeluaranBaruState();
}

class _TambahPengeluaranBaruState extends State<TambahPengeluaranBaru> {
  var formKey = GlobalKey<FormState>();

  TextEditingController namaPengeluaranController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController nominalController = TextEditingController();

  bool isFormFilled = false;

  @override
  void initState() {
    super.initState();
    namaPengeluaranController.addListener(_checkFormFilled);
    jumlahController.addListener(_checkFormFilled);
    tanggalController.addListener(_checkFormFilled);
    nominalController.addListener(_checkFormFilled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tambah Pengeluaran Baru",
            style: blackFont19,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          )),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: namaPengeluaranController,
                    decoration: InputDecoration(
                      hintText: "Nama Pengeluaran",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: jumlahController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/pizza.png',
                          width: 10,
                          height: 5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(8.0),
                        icon: Image.asset(
                          'assets/Drop.png',
                          width: 30,
                          height: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Kategori(),
                            ),
                          );
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: false,
                    controller: tanggalController,
                    decoration: InputDecoration(
                      hintText: 'Tanggal Pengeluaran',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    onTap: _selectDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nominalController,
                    decoration: InputDecoration(
                      hintText: "Nominal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Handle form submission
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(400, 55)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        isFormFilled ? const Color(0xff0A97B0) : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: whiteFont14.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkFormFilled() {
    if (namaPengeluaranController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        tanggalController.text.isNotEmpty &&
        nominalController.text.isNotEmpty) {
      setState(() {
        isFormFilled = true;
      });
    } else {
      setState(() {
        isFormFilled = false;
      });
    }
  }

  Future<void> _selectDate() async {
    await initializeDateFormatting('id_ID', null);
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (_picked != null) {
      setState(() {
        tanggalController.text =
            DateFormat('EEEE, d MMMM y', 'id').format(_picked);
      });
    }
  }
}

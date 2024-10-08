import 'package:administrador/Servicos/gerar_excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Cores/cores.dart';

class PageIndiKai extends StatefulWidget {
  const PageIndiKai({super.key});

  @override
  State<PageIndiKai> createState() => _PageIndiKaiState();
}

class _PageIndiKaiState extends State<PageIndiKai> {
  Stream<List<DadosIndikai>> leiaDadosSolictacaoCliente() =>
      FirebaseFirestore.instance
          .collection('Administrador')
          .doc("IndiKai")
          .collection('Contatos')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DadosIndikai.fromJson(doc.data()))
              .toList());

  //funcao que manda os dados do stream para gerar o excel
  void exportarExcel() {
    leiaDadosSolictacaoCliente().listen((dados) {
      String tipoRelatorio = "indikai";
      gerarArquivoExcel(dadosIndikai : dados, tipoRelatorio : tipoRelatorio);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ListTileDadosSolictacaoCliente(
            DadosIndikai dadosSolictacaoCliente) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cinza,
            ),
            child: ListTile(
              title: Text("${dadosSolictacaoCliente.oQueFaz}"),
              subtitle: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Text("${dadosSolictacaoCliente.whatsAppContato}",),
                    Text("${dadosSolictacaoCliente.data}"),
                  ],
                ),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: vermelho,
                ),
                onTap: () {
                  //Deletar no banco Local
                  final deleteBuscaLocal = FirebaseFirestore.instance
                      .collection("Administrador")
                      .doc('IndiKai')
                      .collection("Contatos")
                      .doc(dadosSolictacaoCliente.id);

                  deleteBuscaLocal.delete();
                },
              ),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: cinzaClaro,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          exportarExcel();
        },
        icon: const Icon(Icons.file_download),
        label: const Text("Gerar relatório"),
        backgroundColor: azul,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: azul,
                    ),
                    height: 40,
                    width: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: cinzaClaro,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "IndiKai",
                    style: GoogleFonts.roboto(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Aqui ficará os contato que os clientes irão recomendar",
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Lista de solictações de clientes
            Container(
              color: cinzaClaro,
              height: MediaQuery.of(context).size.height * 0.85,
              child: StreamBuilder<List<DadosIndikai>>(
                stream: leiaDadosSolictacaoCliente(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wong! ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final leiaDadosSolictacaoCliente = snapshot.data!;
                    return ListView.builder(
                      itemCount: leiaDadosSolictacaoCliente.length,
                      itemBuilder: (context, index) {
                        final dadosSolictacaoCliente =
                            leiaDadosSolictacaoCliente[index];
                        return ListTileDadosSolictacaoCliente(
                            dadosSolictacaoCliente);
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DadosIndikai {
  String id;
  final String whatsAppContato;
  final String oQueFaz;
  final String data;

  DadosIndikai({
    this.id = '',
    required this.whatsAppContato,
    required this.oQueFaz,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'WhatsAppContato': whatsAppContato,
        'OQueFaz': oQueFaz,
        'Data': data,
      };

  static DadosIndikai fromJson(Map<String, dynamic> json) =>
      DadosIndikai(
        id: json["Id"] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
        oQueFaz: json['OQueFaz'] ?? '',
        data: json['Data'] ?? '',
      );
}

import 'package:administrador/Servicos/gerar_excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Cores/cores.dart';

class PageSolicitacoes extends StatefulWidget {
  const PageSolicitacoes({super.key});

  @override
  State<PageSolicitacoes> createState() => _PageSolicitacoesState();
}

class _PageSolicitacoesState extends State<PageSolicitacoes> {
  Stream<List<DadosSolicitacao>> leiaDadosSolictacaoCliente() =>
      FirebaseFirestore.instance
          .collection('Administrador')
          .doc("Solicitações")
          .collection('Geral')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DadosSolicitacao.fromJson(doc.data()))
              .toList());

  void exportarExcel() {
    leiaDadosSolictacaoCliente().listen((dados) {
      String tipoRelatorio = "solicitacoes";
      gerarArquivoExcel(dadosSolicitacao: dados, tipoRelatorio: tipoRelatorio);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ListTileDadosSolictacaoCliente(
            DadosSolicitacao dadosSolictacaoCliente) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cinza,
            ),
            child: ListTile(
              title: SingleChildScrollView(
                child: Text(
                  dadosSolictacaoCliente.nome,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cinzaEscuro,
                  ),
                ),
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dadosSolictacaoCliente.solicitacao,
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: cinzaEscuro,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              dadosSolictacaoCliente.profissional,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cinzaClaro,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: cinzaEscuro,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              dadosSolictacaoCliente.cidadeEstado,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cinzaClaro,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dadosSolictacaoCliente.data,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul,
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: cinzaClaro,
                              ),
                              onPressed: () async {
                                Uri whatsappUrl = Uri.parse(
                                    "whatsapp://send?phone=+55${dadosSolictacaoCliente.whatsAppContato}&text=Oi");

                                if (await canLaunchUrl(whatsappUrl)) {
                                  await launchUrl(whatsappUrl);
                                } else {
                                  throw 'Could not launch $whatsappUrl';
                                }
                              },
                            ),
                          ),
                          //
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
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
        icon: Icon(Icons.file_download),
        label: Text("Gerar relatório"),
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
                    "Solicitações",
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
              "Aqui você poderá visualizar as solicitações enviadas pelos clientes para diversos profissionais",
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
              child: StreamBuilder<List<DadosSolicitacao>>(
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

class DadosSolicitacao {
  String id;
  final String profissional;
  final String cidadeEstado;
  final String solicitacao;
  final String nome;
  final String data;
  final String whatsAppContato;

  DadosSolicitacao({
    this.id = '',
    required this.profissional,
    required this.cidadeEstado,
    required this.solicitacao,
    required this.nome,
    required this.data,
    required this.whatsAppContato,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Profissional': profissional,
        'CidadeEstado': cidadeEstado,
        'Solicitação': solicitacao,
        'Nome': nome,
        'Data': data,
        'WhatsAppContato': whatsAppContato,
      };

  static DadosSolicitacao fromJson(Map<String, dynamic> json) =>
      DadosSolicitacao(
        id: json["Id"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
        solicitacao: json['Solicitação'] ?? '',
        nome: json['Nome'] ?? '',
        data: json['Data'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
      );
}

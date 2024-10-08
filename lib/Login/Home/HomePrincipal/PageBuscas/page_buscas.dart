import 'package:administrador/Servicos/gerar_excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Cores/cores.dart';

class PageBuscas extends StatefulWidget {
  const PageBuscas({super.key});

  @override
  State<PageBuscas> createState() => _PageBuscasState();
}

class _PageBuscasState extends State<PageBuscas> {
  Stream<List<DadosBusca>> leiaDadosSolictacaoCliente() =>
      FirebaseFirestore.instance
          .collection('Administrador')
          .doc("Buscas")
          .collection('Geral')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DadosBusca.fromJson(doc.data()))
              .toList());

  //funcao que manda os dados do stream para gerar o excel
  void exportarExcel() {
    leiaDadosSolictacaoCliente().listen((dados) {
      String tipoRelatorio = "buscas";
      gerarArquivoExcel(dadosBusca : dados, tipoRelatorio : tipoRelatorio);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ListTileDadosSolictacaoCliente(
            DadosBusca dadosSolictacaoCliente) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cinza,
            ),
            child: ListTile(
              title: SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 45,
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
                          dadosSolictacaoCliente.nome,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cinzaClaro,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 45,
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
                          dadosSolictacaoCliente.email,
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
              subtitle: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Busca realizada",
                      style: GoogleFonts.roboto(
                        color: azul,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dadosSolictacaoCliente.cidadeEstado,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dadosSolictacaoCliente.profissional,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Buscas",
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
            const SizedBox(
              height: 20,
            ),
            // Lista de solictações de clientes
            Container(
              color: cinzaClaro,
              height: MediaQuery.of(context).size.height * 0.85,
              child: StreamBuilder<List<DadosBusca>>(
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

class DadosBusca {
  String id;
  final String profissional;
  final String cidadeEstado;
  final String solicitacao;
  final String nome;
  final String data;
  final String whatsAppContato;
  final String email;

  DadosBusca({
    this.id = '',
    required this.profissional,
    required this.cidadeEstado,
    required this.solicitacao,
    required this.nome,
    required this.data,
    required this.whatsAppContato,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Profissional': profissional,
        'CidadeEstado': cidadeEstado,
        'Solicitação': solicitacao,
        'Nome': nome,
        'Data': data,
        'WhatsAppContato': whatsAppContato,
        'Email': email,
      };

  static DadosBusca fromJson(Map<String, dynamic> json) =>
      DadosBusca(
        id: json["Id"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
        solicitacao: json['Solicitação'] ?? '',
        nome: json['Nome'] ?? '',
        data: json['Data'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
        email: json['Email'] ?? '',
      );
}

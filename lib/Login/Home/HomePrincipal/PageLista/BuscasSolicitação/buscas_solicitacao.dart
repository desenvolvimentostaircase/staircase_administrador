import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:administrador/Cores/cores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Buscar/buscar.dart';
import '../home_adicionar.dart';
import 'AdicionarProfissional/Adicionar_profissional.dart';

class BuscasSolicitacao extends StatefulWidget {
  @override
  State<BuscasSolicitacao> createState() => _BuscasSolicitacaoState();
}

// Localização da solicitação
// Ligar para o contato

//Abrir WhatsApp
abrirWhatsApp(whatsAppContato, nomeContato) async {
  Uri whatsappUrl = Uri.parse(
      "whatsapp://send?phone=+55$whatsAppContato&text=Prazer, $nomeContato venho do app Edywasa, gostaria de saber se você está disponível para serviço?");

  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

String UID = FirebaseAuth.instance.currentUser!.uid.toString();

Stream<List<BuscarDadosGeral>> leiaBuscasProfissionais(
  profissional,
  cidadeEstado,
) => // Ler o campo determinado dentro do servidor
    FirebaseFirestore.instance
        .collection("Administrador")
        .doc(UID)
        .collection("NomeNumero")
        .doc(profissional)
        .collection(cidadeEstado)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BuscarDadosGeral.fromJson(doc.data()))
            .toList());

class _BuscasSolicitacaoState extends State<BuscasSolicitacao> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: cinzaClaro,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 35,
            right: 35,
          ),
          child: ListView(
            children: [
              //
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: azul,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                    "Profissionais",
                    style: GoogleFonts.roboto(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),

              Text(
                "Encontre os profissionais para o seu serviço",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //CidadeEstado e Profissional

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  color: cinza,
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
                  child: ListTile(
                    subtitle: Text(
                      auxCidadeEstado,
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 16,
                      ),
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        auxProfissional,
                        style: GoogleFonts.roboto(
                          color: cinzaEscuro,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: vermelho,
                      ),
                      onPressed: () {
                        popupExclusao(auxProfissional, auxCidadeEstado, auxId);
                      },
                    ),
                  ),
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: Text(
                  "Profissionais",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 25,
                  ),
                ),
              ),
              //
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<List<BuscarDadosGeral>>(
                  stream: leiaBuscasProfissionais(
                    auxProfissional,
                    auxCidadeEstado,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaBuscar = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaBuscar.length,
                        itemBuilder: (context, index) {
                          final buscar = leiaBuscar[index];
                          return columnSolicitacao(buscar);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: azul,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          label: Text(
            "Adicionar",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: cinzaClaro,
            ),
          ),
          icon: Icon(
            Icons.add,
            color: cinzaClaro,
          ),
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdicionarProfissional(),
                    ),
                  );
          },
        ),
      );
  //

  //Solicitação de clientes
  Widget columnSolicitacao(buscar) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: cinza,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
            child: ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: vermelho,
                ),
                onPressed: () {
                  popupExclusaoindividualContato(auxProfissional,
                      auxCidadeEstado, buscar.id, buscar.idGeral);
                },
              ),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${buscar.nome}",
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(
                "${buscar.whatsAppContato}",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );

  Future popupExclusao(profissionalAux, cidadeEstadoAux, idAux) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Tem certeza?",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: cinzaEscuro,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: 1,
            child: Text(
              "Deseja excluir esta busca?",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 17,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            // Botão NÃO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: azul,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                "Não",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: azul,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //Botão SIM
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: azul,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Sim",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: cinzaClaro,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                String UID = FirebaseAuth.instance.currentUser!.uid.toString();

                //Deletar no banco
                final docSolicitacao = FirebaseFirestore.instance
                    .collection("Administrador")
                    .doc(UID)
                    .collection("Adicionar")
                    .doc(idAux);

                docSolicitacao.delete();
              },
            ),
          ],
        ),
      );

  Future popupExclusaoindividualContato(
          profissionalAux, cidadeEstadoAux, id, idGeral) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Tem certeza?",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: cinzaEscuro,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: 1,
            child: Text(
              "Deseja excluir este contato?",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 17,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            // Botão NÃO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: azul,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                "Não",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: azul,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //Botão SIM
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: azul,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Sim",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: cinzaClaro,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);

                String UID = FirebaseAuth.instance.currentUser!.uid.toString();

                //Deletar no banco Local
                final deleteBuscaLocal = FirebaseFirestore.instance
                    .collection("Administrador")
                    .doc(UID)
                    .collection("NomeNumero")
                    .doc(profissionalAux)
                    .collection(cidadeEstadoAux)
                    .doc(id);

                deleteBuscaLocal.delete();

                //Deletar no banco Geral
                final deleteBuscaGeral = FirebaseFirestore.instance
                    .collection("Busca Geral")
                    .doc(profissionalAux)
                    .collection(cidadeEstadoAux)
                    .doc(idGeral);

                deleteBuscaGeral.delete();
              },
            ),
          ],
        ),
      );
}

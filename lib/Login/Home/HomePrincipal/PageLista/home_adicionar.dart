import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Cores/cores.dart';
import 'Buscar/buscar.dart' as soli;
import 'BuscasSolicitação/buscas_solicitacao.dart';

class PageLista extends StatefulWidget {
  const PageLista({super.key});

  @override
  State<PageLista> createState() => _PageListaState();
}

String auxProfissional = '';
String auxCidadeEstado = '';
String auxId = '';

class _PageListaState extends State<PageLista> {
  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  //PopUp de aviso que determina o litime de
  Future popupSolicitacaoLimite() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Limite máximo",
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: cinzaEscuro,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: 1,
            child: Text(
              "Para que possa fazer mais solicitações, terá que excluir solicitações já realizadas.",
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: cinzaEscuro,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 12,
                    bottom: 12,
                  ),
                  backgroundColor: vermelho,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Fechar",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: cinzaClaro,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );

  int? contador = 0;

  Widget ListTileBuscar(soli.BuscarDados buscar) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: cinza,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: ListTile(
              //Cidade Estado
              subtitle: Text(
                "${buscar.cidadeEstadoSelecionada}",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              //Profissional
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${buscar.profissionalSelecionada}",
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: cinzaEscuro,
                  size: 35,
                ),
                onPressed: () {
                  auxCidadeEstado = buscar.cidadeEstadoSelecionada; //Filtro
                  auxProfissional = buscar.profissionalSelecionada; //Filtro
                  auxId = buscar.id;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BuscasSolicitacao(), //Leva para a rtela onde mostra os resultados do filtro
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

  /// Le o conteudo local
  Stream<List<soli.BuscarDados>> leiaBuscar() => FirebaseFirestore.instance
      .collection('Administrador')
      .doc(UID)
      .collection("Adicionar")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => soli.BuscarDados.fromJson(doc.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Adicionar ",
                style: GoogleFonts.roboto(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                "Filtre os profissionais que deseja adicionar.",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: cinzaClaro,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder<List<soli.BuscarDados>>(
                  stream: leiaBuscar(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaBuscar = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaBuscar.length,
                        itemBuilder: (context, index) {
                          contador = leiaBuscar.length;
                          final buscar = leiaBuscar[index];
          
                          return ListTileBuscar(buscar);
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
        backgroundColor: cinzaClaro,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: azul,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          label: Text(
            "Filtro",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: cinzaClaro,
            ),
          ),
          icon: Icon(
            Icons.filter_alt_rounded,
            color: cinzaClaro,
          ),
          onPressed: () {
            if (contador! >= 100) {
              popupSolicitacaoLimite();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const soli.Buscar(),
                ),
              );
            }
          },
        ),
      
    );
  }
}

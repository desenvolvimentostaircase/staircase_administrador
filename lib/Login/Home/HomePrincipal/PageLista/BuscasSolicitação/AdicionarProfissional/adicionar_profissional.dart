import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../Cores/cores.dart';
import '../../home_adicionar.dart';

class AdicionarProfissional extends StatefulWidget {
  const AdicionarProfissional({super.key});

  @override
  State<AdicionarProfissional> createState() => _AdicionarProfissionalState();
}

class _AdicionarProfissionalState extends State<AdicionarProfissional> {
  final _nomeController = TextEditingController();
  final _whatsAppContatoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Adicionar",
                style: GoogleFonts.roboto(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                "Preencha o filtro conforme o campo abaixo para que o possa adicionar o profissional posteriormente.",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //E-mail
              Container(
                decoration: BoxDecoration(
                  color: cinza,
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
                height: 55,
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _nomeController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                          width: 2,
                        ),
                      ),
                      hintText: "Nome",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value!.length > 30) {
                        return 'Nome muito grande, abrevie !!!';
                      } else if (value.isEmpty) {
                        return 'Campo vazio';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Senha
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: cinza,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _whatsAppContatoController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                          width: 2,
                        ),
                      ),
                      hintText: "Número",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value!.length != 11) {
                        return 'Oh meu amigo, só pode 11 números';
                      }else if (value.isEmpty) {
                        return 'Eita deixa vazio não, parça';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  final isValidForm = formKey.currentState!.validate();

                  if (isValidForm) {
                    final adicionarGeral = AdicionarDadosGeral(
                      nome: _nomeController.text,
                      whatsAppContato: _whatsAppContatoController.text,
                    );

                    final adicionar = AdicionarDados(
                      nome: _nomeController.text,
                      whatsAppContato: _whatsAppContatoController.text,
                    );
                    createAdicionar(adicionar, adicionarGeral);
                    //
                    Navigator.pop(context);
                    //
                  }
                },
                child: Text(
                  "Confirmar",
                  style: GoogleFonts.roboto(
                    color: cinzaClaro,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text(
                  "Voltar",
                  style: GoogleFonts.roboto(
                    color: azul,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createAdicionar(
      AdicionarDados adicionar, AdicionarDadosGeral adicionarGeral) async {
    String UID = FirebaseAuth.instance.currentUser!.uid.toString();

    //Geral Criação
    final docAdicionarGeral = FirebaseFirestore.instance
        .collection("Busca Geral")
        .doc(auxProfissional)
        .collection(auxCidadeEstado)
        .doc();

    adicionarGeral.id = docAdicionarGeral.id;

    final jsonGeral = adicionarGeral.toJson();
    await docAdicionarGeral.set(jsonGeral);
    //
    //criação local
    final docAdicionar = FirebaseFirestore.instance
         .collection("Administrador")
        .doc(UID)
        .collection("NomeNumero")
        .doc(auxProfissional)
        .collection(auxCidadeEstado)
        .doc();

    adicionar.idGeral = adicionarGeral.id;
    adicionar.id = docAdicionar.id;

    final json = adicionar.toJson();
    await docAdicionar.set(json);
  }
}

//Solicitação Geral
class AdicionarDadosGeral {
  String id;
  final String nome;
  final String whatsAppContato;
  
  AdicionarDadosGeral({
    this.id = '',
    required this.nome,
    required this.whatsAppContato,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Nome': nome,
        'WhatsAppContato': whatsAppContato,
      };

  static AdicionarDadosGeral fromJson(Map<String, dynamic> json) =>
      AdicionarDadosGeral(
        id: json["Id"] ?? '',
        nome: json['Nome'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
      );
}

//((Local))
class AdicionarDados {
  String id;
  String idGeral;
  final String nome;
  final String whatsAppContato;
 

  AdicionarDados({
    this.id = '',
    this.idGeral = '',
    required this.nome,
    required this.whatsAppContato,
 
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'IdGeral': idGeral,
        'Nome': nome,
        'WhatsAppContato': whatsAppContato,
     
      };

  static AdicionarDados fromJson(Map<String, dynamic> json) => AdicionarDados(
        id: json["Id"] ?? '',
        idGeral: json["IdGeral"] ?? '',
        nome: json['Nome'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
  
      );
}

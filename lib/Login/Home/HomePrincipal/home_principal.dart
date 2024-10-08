import 'package:administrador/Login/Home/HomePrincipal/PageBuscas/page_buscas.dart';
import 'package:administrador/Login/Home/HomePrincipal/PageIndiKai/page_indiKai.dart';
import 'package:administrador/Login/Home/HomePrincipal/PageSolicitacoes/page_solicitacoes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Cores/cores.dart';
import 'PageLista/home_adicionar.dart';
import 'PageUsuarios/page_usuarios.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              "Home",
              style: GoogleFonts.roboto(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Aqui é o Home",
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 25,
                ),
                //Salvos
                GestureDetector(
                  child: Container(
                    height: 100,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul),
                          height: 75,
                          width: 75,
                          child: Icon(
                            Icons.bookmark,
                            color: cinzaClaro,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Lista",
                          style: GoogleFonts.roboto(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PageLista(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                //Clientes
                GestureDetector(
                  child: SizedBox(
                    height: 120,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: azul,
                          ),
                          height: 75,
                          width: 75,
                          child: Icon(
                            Icons.groups,
                            color: cinzaClaro,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "Solicitações",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PageSolicitacoes(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),

                //Clientes
                GestureDetector(
                  child: SizedBox(
                    height: 120,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul),
                          height: 75,
                          width: 75,
                          child: Icon(
                            Icons.contact_phone_rounded,
                            color: cinzaClaro,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "Buscas",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PageBuscas(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),

                //Materiais
                GestureDetector(
                  child: SizedBox(
                    height: 120,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul),
                          height: 75,
                          width: 75,
                          child: Icon(
                            Icons.newspaper,
                            color: cinzaClaro,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Usuarios",
                          style: GoogleFonts.roboto(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PageUsuarios(),
                      ),
                    );
                  },
                ),
                //Materiais
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: SizedBox(
                    height: 120,
                    width: 75,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul),
                          height: 75,
                          width: 75,
                          child: Icon(
                            Icons.phone,
                            color: cinzaClaro,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "IndiKai",
                          style: GoogleFonts.roboto(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PageIndiKai(),
                      ),
                    );
                  },
                ),
                 SizedBox(
                  width: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Cores/cores.dart';

class Buscar extends StatefulWidget {
  const Buscar({Key? key}) : super(key: key);

  @override
  State<Buscar> createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  ///
  final _cidadeEstado = [
    "Campo Grande - MS",
    "Três Lagoas - MS",
    "Dourados - MS",
  ];

  List<String> listItems = <String>[
    "Advogado",
    "Airfryer (Manutenção)",
    "Aquecedores de piscina (Manutenção e instalação)",
    "Ar condicionado (Manutenção e Instalação)",
    "Arcondicionado portatil (Manutenção)",
    "Aspirador de pó (Manutenção)",
    "Banho e Tosa",
    "Bebedouro (Manutenção)",
    "Cabeleireira",
    "Cabelereira (Domicilio)",
    "Caçamba",
    "Cafeteira eletrica (Manutenção)",
    "Calheiro",
    "Camera de segurança (Manutenção e Instalação)",
    "Carpinteiro",
    "Cerca eletrica (Manutenção e Instalação)",
    "Chapinha (Manutenção)",
    "Chaveiro",
    "Churrasqueira eletrica (Manutenção)",
    "Climatizadore (Manutenção)",
    "Confeitera",
    "Contador",
    "Costureira",
    "Cuidadora",
    "Dedetizador",
    "Dentista",
    "Depilador",
    "Designer de sobrancelha  (domicilio)",
    "Designer de sobrancelha",
    "Eletricista",
    "Encanador",
    "Extensão de cilios",
    "Faxineira",
    "Ferro de passar (Manutenção)",
    "Fogão (Manutenção)",
    "Forno eletrico (Manutenção)",
    "Forro PVC (Manutenção e Instalação)",
    "Freezer (Manutenção)",
    "Fretista (Caminhão)",
    "Fretista (Carretinha)",
    "Geladeira (Manutenção)",
    "Geladeira Comecial (Manutenção)",
    "Gesseiro",
    "Grafica",
    "Guincho",
    "Jardineiro",
    "Lavador a seco (Estofados)",
    "Limpeza terreno",
    "Manicure",
    "Manicure (Domicilio)",
    "Maquiadora",
    "Maquina de lavar roupa (Manutenção)",
    "Marceneiro",
    "Marido de aluguel",
    "Mecanico",
    "Microondas (Manutenção)",
    "Montador de móveis",
    "Motorista (Carro)",
    "Motorista (Moto)",
    "Painel solar (Manutenção e Instalação)",
    "Panela eletrica (Manutenção)",
    "Pedicure",
    "Pedicure (Domicilio)",
    "Pedreiro",
    "Pintor",
    "Podador de arvores",
    "Processador de alimentos (Manutenção)",
    "Professora de reforço escolar (1 ao 5 ano)",
    "Salgadera",
    "Sanduicheira (Manutenção)",
    "Sapateiro",
    "Secador de cabelo (Manutenção)",
    "Serralheiro",
    "Soldador",
    "Tapeceiro",
    "Tecnico de informatica",
    "Televisão (Manutenção)",
    "Motorista de van escolar",
    "Ventilador (Manutenção)",
    "Ventilador de teto (Manutenção)",
    "Vidraceiro",
  ];
  //
    String _cidadeEstadoSelecionada = "";
  String _profissionalSelecionado = "";
  String detalhesProfissional = "";
  final formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_profissionalSelecionado == "Advogado") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Resolver precessos ";
    } else if (_profissionalSelecionado == "Airfryer (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n-  manutenção do aparelho";
    } else if (_profissionalSelecionado ==
        "Aquecedores de piscina (Manutenção e instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção e instalação do aparelho";
    } else if (_profissionalSelecionado ==
        "Ar condicionado (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Limpeza\n- MAnutenção\n- Instalação";
    } else if (_profissionalSelecionado ==
        "Arcondicionado portatil (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Aspirador de pó (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Banho e Tosa") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Bebedouro (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Cabelereira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte de Cabelo\n- Coloração\n- Penteado\n- Tratamentos Capilares\n- Escovação";
    } else if (_profissionalSelecionado == "Cabelereira (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte de Cabelo\n- Coloração\n- Penteado\n- Tratamentos Capilares\n- Escovação";
    } else if (_profissionalSelecionado == "Caçamba") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fornece caçamba para entulho";
    } else if (_profissionalSelecionado == "Cafeteira eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Calheiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n Instalação";
    } else if (_profissionalSelecionado ==
        "Camera de segurança (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n- Instalação";
    } else if (_profissionalSelecionado == "Carpinteiro") {
      detalhesProfissional = "Função(Averiguar com o profissional)";
    } else if (_profissionalSelecionado ==
        "Cerca eletrica (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n- Instalação";
    } else if (_profissionalSelecionado == "Chapinha (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Chaveiro Residencial") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cópia de chaves\n- Reparação de fechaduras:\n -Instalação de fechaduras\n -Serviços de emergência\n - Chaves codificadas\n -Reparação de controles remotos";
    } else if (_profissionalSelecionado ==
        "Churrasqueira eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Climatizador (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Confeitera") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Bolos decorados\n - Cupcakes\n - Tortas\n -Biscoitos decorados\n -Doces finos\n -Sobremesas personalizadas";
    } else if (_profissionalSelecionado == "Contador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Preparação e Análise de Demonstrações Financeiras\n -Auditoria\n - Gestão de Impostos\n -Análise de Custos\n -Planejamento Financeiro";
    } else if (_profissionalSelecionado == "Costureira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Costura de roupas\n -Ajustes e reparos\n -Confecção de peças sob medida\n -Design de moda\n -Bordado e apliques:\n -Reparação de roupas danificadas";
    } else if (_profissionalSelecionado == "Cuidadora") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Assistência pessoa\n -Monitoramento da saúde\n -Apoio emocional";
    } else if (_profissionalSelecionado == "Dedetizador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Identificação das Pragas\n -Inspeção\n -Desenvolvimento de um Plano de Controle\n -Aplicação de Produtos Químicos";
    } else if (_profissionalSelecionado == "Dentista") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Exames e diagnósticos\n -Tratamento de traumas dentários\n -Restaurações estéticas\n -Procedimentos ortodônticos";
    } else if (_profissionalSelecionado == "Depilador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Seleção da técnica de depilação\n -Preparação da pele\n -";
    } else if (_profissionalSelecionado ==
        "Designer de sobrancelha (domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Designer de sobrancelha";
    } else if (_profissionalSelecionado == "Designer de sobrancelha") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Designer de sobrancelha";
    } else if (_profissionalSelecionado == "Eletricista") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação elétrica\n- Manutenção e prevenção eletrica\n- Instalação e Manutenção de paineis solares\n- Trocar resistencia de chuveiro\n- Trocar tomada\n- Leitura de plantas elétricas\n- Instalação de sistemas de iluminação\n- Aterramento e proteção contra sobrecargas";
    } else if (_profissionalSelecionado == "Encanador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de sistemas de drenagem\n- Reparos em sistemas de aquecimento\n- Manutenção preventiva\n- Inspeções de encanamento\n- Substituição de equipamentos\n- Limpeza de ralos e canos\n- Reparos de vazamentos\n- Instalação de tubulações";
    } else if (_profissionalSelecionado == "Extensão de cilios") {
      detalhesProfissional = "Função(Averiguar com o profissional)";
    } else if (_profissionalSelecionado == "Faxineira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Realiza limpezas em escritórios e residenciais.";
    } else if (_profissionalSelecionado == "Ferro de passar (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Fogão (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Forno eletrico (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado ==
        "Forro PVC (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção e instalação do equipamento";
    } else if (_profissionalSelecionado == "Freezer (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Fretista (Caminhão)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de carga em grande quantidade\n- Transporte de móveis, eletrodomesticos, etc.";
    } else if (_profissionalSelecionado == "Fretista (Carretinha)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de carga em pequena quantidade\n- Transporte de móveis, eletrodomesticos, etc.";
    } else if (_profissionalSelecionado == "Geladeira (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Geladeira Comecial (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Gesseiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de Drywall\n- Revestimento de Paredes e Tetos\n- Moldagem e Modelagem";
    } else if (_profissionalSelecionado == "Grafica") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cartões de Visita\n- Panfletos e Folhetos\n- Cartazes e Pôsteres:\n- Folders e Brochuras";
    } else if (_profissionalSelecionado == "Jardineiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Consultoria e Orientação\n- Conservação e Limpeza\n- Instalação e Manutenção de Sistemas de Irrigação\n- Manejo de Paisagismo\n- Fertilização\n- Controle de Pragas e Doenças\n- Manutenção, Irrigação, Plantio e Preparação do Solo";
    } else if (_profissionalSelecionado == "Lavador a seco (Estofados)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Limpeza de estofados e móveis\n- Desodorização\n- Tratamento de cortinas e persianas\n- Higienização de colchões\n- Limpeza de tapetes e carpetes: ";
    } else if (_profissionalSelecionado == "Manicure") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cuidados com as unhas\n- Remoção de cutículas\n- Aplicação de esmalte";
    } else if (_profissionalSelecionado == "Manicure (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cuidados com as unhas\n- Remoção de cutículas\n- Aplicação de esmalte";
    } else if (_profissionalSelecionado == "Maquiadora") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Maquiagem";
    } else if (_profissionalSelecionado ==
        "Maquina de lavar roupa (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Marceneiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Elaboração de moveis e objetos com madeira maciçam, MDF, compensado, entre outros";
    } else if (_profissionalSelecionado == "Marido de aluguel") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de Cortinas e Persianas\n- Reparos em Banheiros\n- Isolamento Térmico e Acústico\n- Reparos em Máquinas e Equipamentos\n- Limpeza de Calhas\n- Instalação de Prateleiras e Quadros\n- Manutenção de Jardins\n- Reparos em Pisos e Azulejos\n- Reparos em Portas e Janelas\n- Instalação de Eletrodomésticos\n- Pequenos reparos em carpintaria\n- Reparos em eletrodomésticos\n- Manutenção hidráulica\n- Manutenção elétrica\n- Montagem de móveis\n- Pintura";
    } else if (_profissionalSelecionado == "Mecanico de carro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Mecânicos especializados em reparar e manter carros de passeio";
    } else if (_profissionalSelecionado == "Microondas (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Montador de móveis") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Montar moveis";
    } else if (_profissionalSelecionado == "Motorista (Carro)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Motorista particular";
    } //
    else if (_profissionalSelecionado == "Motorista (Moto)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Motorista particular";
    } else if (_profissionalSelecionado ==
        "Painel solar (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e manutenção do equipamento";
    } else if (_profissionalSelecionado == "Panela eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e manutenção do equipamento";
    } else if (_profissionalSelecionado == "Pedicure (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte e modelagem das unhas\n- Esfoliação\n- Remoção de calos e calosidades";
    } else if (_profissionalSelecionado == "Pedreiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Assentamento de pisos e azulejos\n- Instalação de portas e janelas\n- Construção de lajes e vigas\n- Reboco e acabamento";
    } else if (_profissionalSelecionado == "Pintor") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Pintura de interiores\n- Pintura decorativa\n- Revestimentos industriais\n- Restauração de pinturas\n -Pintura de exteriores";
    } else if (_profissionalSelecionado == "Podador de árvores") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Podar árvores";
    } else if (_profissionalSelecionado ==
        "Processador de alimentos (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado ==
        "Professora de reforço escolar (1 ao 5 ano)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Identificação de necessidades individuais\n- Planejamento de atividades de reforço\n- Ensino individualizado\n-Língua Portuguesa, Matemática, Ciências, Artes, Ingles ";
    } else if (_profissionalSelecionado == "Salgadera") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Preparação de salgados de variados tipos, Coxinhas, Pastéis, Bolinhas de queijo, Esfihas, entre outros";
    } else if (_profissionalSelecionado == "Sanduicheira (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Sapateiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Reparação de Calçados\n- Ajustes e Alterações\n- Lustração e Polimento";
    } else if (_profissionalSelecionado == "Secador de cabelo (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Serralheiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fabricação de estruturas metálicas\n- Soldagem\n- Corte de metal\n- Dobra e moldagem";
    } else if (_profissionalSelecionado == "Soldador ") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fabricação de estruturas metálicas\n- Soldagem\n- Corte de metal\n- Dobra e moldagem";
    } else if (_profissionalSelecionado == "Tapeceiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Estofamento de móveis\n- Estofamento de veículos\n- Confecção de almofadas, travesseiros e assentos:\n- Reparos em estofamentos danificados";
    } else if (_profissionalSelecionado == "Tecnico de informatica") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e Manutenção de Hardware,\n- Backup e Recuperação de Dados:\n- Formatação\n";
    } else if (_profissionalSelecionado == "Televisão (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Motorista de van escolar") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de ida e volta para a escola";
    } else if (_profissionalSelecionado == "Ventilador (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Ventilador de teto (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Vidraceiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de janelas\n- Instalação de portas de vidro\n- Instalação de espelhos\n- Fabricação e instalação de box de banheiro";
    }

    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 35, right: 35, bottom: 35, top: 20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              Text(
                "Filtro",
                style: GoogleFonts.roboto(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
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
                height: 20,
              ),

              ///Profissional
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: cinza,
                ),
                height: 65,
                child: TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    onTap: () {
                  if (_profissionalSelecionado != "") {
                    _textEditingController.text = _profissionalSelecionado;
                  }
                },
                  
                    controller: _textEditingController,
                    decoration: InputDecoration(
                       
                        suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                        hintStyle: GoogleFonts.roboto(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: cinza,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: azul,
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: vermelho,
                            width: 3,
                          ),
                        ),
                        hintText: "Profissional"),
                  ),
                  onSaved: (value) {
                    _profissionalSelecionado = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Selecione um profisional ou serviço';
                    }
                    return null;
                  },
                  suggestionsCallback: (pattern) {
                    return listItems.where((option) =>
                        option.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _profissionalSelecionado = suggestion;
                      _textEditingController.text = suggestion;
                    });
                  },
                  
                  
                ),
              ),

              detalhesProfissional == ""? SizedBox(height: 10,)
              :Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: SizedBox(
                  height: 93,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      Text(
                        detalhesProfissional,
                        style: GoogleFonts.roboto(
                          color: cinzaEscuro,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///Localização
              Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: cinza,
                ),
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null || value != _cidadeEstadoSelecionada) {
                      return 'Seleciona uma cidade';
                    } else {
                      return null;
                    }
                  },
                  menuMaxHeight: 240,
                  items: _cidadeEstado
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e,
                              style: GoogleFonts.roboto(
                                color: cinzaEscuro,
                                fontSize: 17,
                              ),
                            ),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _cidadeEstadoSelecionada = val as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: cinzaEscuro,
                  ),
                  dropdownColor: cinzaClaro,
                  decoration: InputDecoration(
                    hintText: "Cidade e Estado",
                    hintStyle: GoogleFonts.roboto(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: cinza,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: azul,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),

              //Botão "Entrar"
              ElevatedButton(
                onPressed: () {
                  final isValidForm = formKey.currentState!.validate();

                  if (isValidForm && _profissionalSelecionado != "") {
                    final buscar = BuscarDados(
                      cidadeEstadoSelecionada: _cidadeEstadoSelecionada,
                      profissionalSelecionada: _profissionalSelecionado,
                    );
                    createBuscar(buscar);
                    Navigator.pop(context);
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
                  padding: const EdgeInsets.all(10),
                  backgroundColor: azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              //Botão "Criar conta"
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Voltar",
                  style: GoogleFonts.roboto(
                    color: azul,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createBuscar(BuscarDados buscar) async {
    String UID = FirebaseAuth.instance.currentUser!.uid.toString();

    //
    //Inserir ou criar informação no banco de dados
    final docBuscar = FirebaseFirestore.instance
        .collection("Administrador")
        .doc(UID)
        .collection("Adicionar")
        .doc();

    buscar.id = docBuscar.id;

    final json = buscar.toJson();
    await docBuscar.set(json);
  }
}
//

//Busca interna
class BuscarDados {
  String id;
  String idGeral;
  final String profissionalSelecionada;
  final String cidadeEstadoSelecionada;

  BuscarDados({
    this.id = '',
    this.idGeral = '',
    this.profissionalSelecionada = '',
    this.cidadeEstadoSelecionada = '',
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'IdGeral': idGeral,
        'Profissional': profissionalSelecionada,
        'CidadeEstado': cidadeEstadoSelecionada,
      };

  static BuscarDados fromJson(Map<String, dynamic> json) => BuscarDados(
        id: json["Id"] ?? '',
        idGeral: json["IdGeral"] ?? '',
        profissionalSelecionada: json['Profissional'] ?? '',
        cidadeEstadoSelecionada: json['CidadeEstado'] ?? '',
      );
}

//Busca Geral -- Ler
class BuscarDadosGeral {
  String id;
  String idGeral;
  final String nome;
  final String whatsAppContato;

  BuscarDadosGeral({
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

  static BuscarDadosGeral fromJson(Map<String, dynamic> json) =>
      BuscarDadosGeral(
        id: json["Id"] ?? '',
        idGeral: json["IdGeral"] ?? '',
        nome: json['Nome'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
      );
}

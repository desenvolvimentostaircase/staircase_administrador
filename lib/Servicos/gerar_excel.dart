import 'dart:io';
import 'package:administrador/Login/Home/HomePrincipal/PageIndiKai/page_indiKai.dart';
import 'package:administrador/Login/Home/HomePrincipal/PageSolicitacoes/page_solicitacoes.dart';
import 'package:administrador/Login/Home/HomePrincipal/PageUsuarios/page_usuarios.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:administrador/Login/Home/HomePrincipal/PageBuscas/page_buscas.dart';
import 'package:share_plus/share_plus.dart';

Future<void> gerarArquivoExcel({
  required String tipoRelatorio,
  List<DadosSolicitacao>? dadosSolicitacao,
  List<DadosBusca>? dadosBusca,
  List<DadosUsuario>? dadosUsuario,
  List<DadosIndikai>? dadosIndikai,
}) async {
  // Cria um novo arquivo Excel
  var excel = Excel.createExcel();

  // Acessa a primeira aba da planilha
  Sheet sheet = excel['Sheet1'];

  //Define o cabeçalho do Excel - Divido por tido de Relório(Solicitações, Busca, Usuario e Indikai)

  //Solicitacoes
  if (tipoRelatorio == "solicitacoes") {
    sheet.cell(CellIndex.indexByString("A1")).value =
        TextCellValue("Profissional");
    sheet.cell(CellIndex.indexByString("B1")).value =
        TextCellValue("Cidade-Estado");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Solicitação");
    sheet.cell(CellIndex.indexByString("D1")).value = TextCellValue("Nome");
    sheet.cell(CellIndex.indexByString("E1")).value = TextCellValue("Data");
    sheet.cell(CellIndex.indexByString("F1")).value = TextCellValue("Whatsapp");

    //Preenche o Excel com os dados recebidos
    for (int i = 0; i < dadosSolicitacao!.length; i++) {
      String profissional = dadosSolicitacao[i].profissional;
      String cidadeEstado = dadosSolicitacao[i].cidadeEstado;
      String solicitacao = dadosSolicitacao[i].solicitacao;
      String nome = dadosSolicitacao[i].nome;
      String data = dadosSolicitacao[i].data;
      String whatsapp = dadosSolicitacao[i].whatsAppContato;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(profissional);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(cidadeEstado);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(solicitacao);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(nome);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(data);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(whatsapp);
    }
  }

  //Buscas
  if (tipoRelatorio == "buscas") {
    sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Nome");
    sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue("Email");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Profissional");
    sheet.cell(CellIndex.indexByString("D1")).value =
        TextCellValue("Cidade-Estado");
    sheet.cell(CellIndex.indexByString("E1")).value = TextCellValue("Data");
    sheet.cell(CellIndex.indexByString("F1")).value = TextCellValue("Whatsapp");

    //Preenche o Excel com os dados recebidos
    for (int i = 0; i < dadosBusca!.length; i++) {
      String nome = dadosBusca[i].nome;
      String email = dadosBusca[i].email;
      String profissional = dadosBusca[i].profissional;
      String cidadeEstado = dadosBusca[i].cidadeEstado;
      String data = dadosBusca[i].data;
      String whatsapp = dadosBusca[i].whatsAppContato;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(nome);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(email);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(profissional);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(cidadeEstado);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(data);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(whatsapp);
    }
  }

  //Usuarios
  if (tipoRelatorio == "usuarios") {
    sheet.cell(CellIndex.indexByString("A1")).value =
        TextCellValue("Profissional");
    sheet.cell(CellIndex.indexByString("B1")).value =
        TextCellValue("Cidade-Estado");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Solicitação");
    sheet.cell(CellIndex.indexByString("D1")).value = TextCellValue("Nome");
    sheet.cell(CellIndex.indexByString("E1")).value = TextCellValue("Data");
    sheet.cell(CellIndex.indexByString("F1")).value = TextCellValue("Whatsapp");
    sheet.cell(CellIndex.indexByString("G1")).value =
        TextCellValue("Conta Profissional");
    sheet.cell(CellIndex.indexByString("H1")).value =
        TextCellValue("Conta Cliente");
    sheet.cell(CellIndex.indexByString("I1")).value = TextCellValue("Email");

    //Preenche o Excel com os dados recebidos
    for (int i = 0; i < dadosUsuario!.length; i++) {
      String profissional = dadosUsuario[i].profissional;
      String cidadeEstado = dadosUsuario[i].cidadeEstado;
      String solicitacao = dadosUsuario[i].solicitacao;
      String nome = dadosUsuario[i].nome;
      String data = dadosUsuario[i].data;
      String whatsapp = dadosUsuario[i].whatsAppContato;
      String contaProfissional = dadosUsuario[i].contaProfissional;
      String contaCliente = dadosUsuario[i].contaCliente;
      String email = dadosUsuario[i].email;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(profissional);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(cidadeEstado);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(solicitacao);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(nome);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(data);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(whatsapp);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
          .value = TextCellValue(contaProfissional);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
          .value = TextCellValue(contaCliente);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
          .value = TextCellValue(email);
    }
  }

  //Indikai
    if (tipoRelatorio == "indikai") {
    sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Whatsapp");
    sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue("O que faz?");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Data");
    
    //Preenche o Excel com os dados recebidos
    for (int i = 0; i < dadosIndikai!.length; i++) {
      String whatsapp = dadosIndikai[i].whatsAppContato;
      String oQueFaz = dadosIndikai[i].oQueFaz;
      String data = dadosIndikai[i].data;
      

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(whatsapp);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(oQueFaz);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(data);
    }
  }


  //Define o caminho para a pasta temporária do aplicativo
  Directory tempDir = await getTemporaryDirectory();
  String outputPath = '${tempDir.path}/relatório-$tipoRelatorio.xlsx';

  // Salva o arquivo
  var fileBytes = excel.save();
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  //Cria um file para compartilhar
  final XFile file = XFile(outputPath);

  //Usa o shareXfiles para compartilhar o arquivo
  await Share.shareXFiles([file], text: "Relatório $tipoRelatorio");
}

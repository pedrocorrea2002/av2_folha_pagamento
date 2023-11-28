import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //* VARIÁVEIS DOS CAMPOS PREENCHIVEIS DO FORMULÁRIO
  final TextEditingController matricula = TextEditingController();
  final TextEditingController salarioBruto = TextEditingController();

  //* VARIÁVEIS QUE AJUDAM A DEIXAR A IMAGEM DO FUNCIONÁRIO DINÂMICA
  int imageIndex = 0;
  List<String> imagens = [
    'https://i.pinimg.com/736x/a3/71/4b/a3714ba657487833c35ef16632f7b896.jpg',
    'https://www.diariodocentrodomundo.com.br/wp-content/uploads/2014/07/mussum-1.jpg',
    'https://s2-g1.glbimg.com/vbxlmE70yvlrZOlq0Jd0Q5FzXwQ=/0x0:730x489/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/E/6/6a7nQrT1uf8IrQjSYflQ/csm-pincel-413e3aba36.jpg'
  ];

  //* VARIÁVEIS DAS CIDADES E BAIRROS
  List<String> cidades = ["Resende", "Itatiaia", "Volta Redonda"];
  String cidadeSelecionada = "";
  Map<String, List<String>> bairros = {
    "Resende": ["Cidade alegria", "Campos Elísios", "Morada da colina"],
    "Itatiaia": ["Jardim paineiras", "Vila Odete", "Vila Pinheiro"],
    "Volta Redonda": ["São Luís", "Candelária", "Dom Bosco"]
  };
  List<String> bairrosDisponiveis = [];
  String bairroSelecionado = "";

  //* VARIÁVEIS DO CÁLCULO DA FOLHA
  double IRRF = 0;
  double INSS = 0;
  double salarioLiquido = 0;
  String INSS_str = "0,00";
  String IRRF_str = "0,00";
  String liquido_str = "0,00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Folha de pagamento",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
          child: ListView(
            children: [
              //* PARTE DA MATRÍCULA
              Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Text(
                        "Matrícula:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                          controller: matricula,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: 10)),
                          )))
                ],
              ),

              //* PARTE DO FUNCIONÁRIO
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(children: [
                    const Expanded(
                        child: Text(
                      "Funcionário:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                switch (imageIndex) {
                                  case 0:
                                    imageIndex = 1;
                                    break;
                                  case 1:
                                    imageIndex = 2;
                                    break;
                                  case 2:
                                    imageIndex = 0;
                                    break;
                                }
                              });
                            },
                            child: const Text("Clique aqui")))
                  ]),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: 250,
                      width: 180,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(imagens[imageIndex]))),
                  const SizedBox(height: 10)
                ],
              ),

              //* PARTE DAS CAIXAS COM LISTA
              const SizedBox(height: 10),
              const Text("Cidades",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                  items: cidades.map((cidade) {
                    return DropdownMenuItem(value: cidade, child: Text(cidade));
                  }).toList(),
                  onChanged: (value) => setState(() {
                        cidadeSelecionada = value ?? "";
                        bairrosDisponiveis = bairros[cidadeSelecionada]!;
                      })),
              const SizedBox(height: 10),
              const Text("Bairros",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                  items: bairrosDisponiveis.map((bairro) {
                    return DropdownMenuItem(value: bairro, child: Text(bairro));
                  }).toList(),
                  onChanged: (value) => setState(() {
                        bairroSelecionado = value ?? "";
                      })),
              const SizedBox(height: 20),

              //* PARTE DO CÁLCULO DA FOLHA
              const Text("Cálculo da Folha",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),

              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "Salário bruto:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                          controller: salarioBruto,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: 10)),
                          )))
                ],
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "IRRF:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        IRRF_str,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "INSS:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        INSS_str,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        "Salário líquido:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        liquido_str,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    double bruto = double.parse(salarioBruto.text);

                    setState(() {
                      //* CALCULANDO INSS
                      if (bruto <= 1320) {
                        INSS = bruto * 0.075;
                      } else if (bruto >= 1320 && bruto <= 2571.29) {
                        INSS = bruto * 0.09;
                      } else if (bruto >= 2571.30 && bruto <= 3856.94) {
                        INSS = bruto * 0.12;
                      } else {
                        INSS = bruto * 0.14;
                      }

                      //* CALCULANDO IRRF
                      double baseIRRF = bruto - INSS;

                      if (baseIRRF <= 2112) {
                        IRRF = 0;
                      } else if (baseIRRF >= 2112.01 && baseIRRF <= 2826.65) {
                        IRRF = baseIRRF * 0.075;
                      } else if (baseIRRF >= 2826.66 && baseIRRF <= 3751.05) {
                        IRRF = baseIRRF * 0.15;
                      } else if (baseIRRF >= 3751.06 && baseIRRF <= 4664.68) {
                        IRRF = baseIRRF * 0.22;
                      } else {
                        IRRF = baseIRRF * 27.5;
                      }

                      salarioLiquido = baseIRRF - IRRF;

                      INSS_str = INSS.toStringAsFixed(2).replaceAll(".", ",");
                      IRRF_str = IRRF.toStringAsFixed(2).replaceAll(".", ",");
                      liquido_str = salarioLiquido
                          .toStringAsFixed(2)
                          .replaceAll(".", ",");
                    });
                  },
                  child: const Text("Calcular")),
              ElevatedButton(
                onPressed: () {
                  matricula.clear();
                  salarioBruto.clear();

                  setState(() {
                    imageIndex = 0;
                    cidadeSelecionada = "";
                    bairroSelecionado = "";
                    salarioLiquido = 0;
                    INSS = 0;
                    IRRF = 0;
                    IRRF_str = "0,00";
                    INSS_str = "0,00";
                    liquido_str = "0,00";
                  });
                },
                child: const Text("Limpar"),
              ),
              ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text("Sair"))
            ],
          )
        ]);
  }
}

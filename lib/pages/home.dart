import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController matricula = TextEditingController();
  int imageIndex = 0;
  List<String> imagens = [
    'https://i.pinimg.com/736x/a3/71/4b/a3714ba657487833c35ef16632f7b896.jpg',
    'https://www.diariodocentrodomundo.com.br/wp-content/uploads/2014/07/mussum-1.jpg',
    'https://s2-g1.glbimg.com/vbxlmE70yvlrZOlq0Jd0Q5FzXwQ=/0x0:730x489/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/E/6/6a7nQrT1uf8IrQjSYflQ/csm-pincel-413e3aba36.jpg'
  ];
  List<String> cidades = ["Resende", "Itatiaia", "Volta Redonda"];
  String cidadeSelecionada = "";
  Map<String, List<String>> bairros = {
    "Resende": ["Cidade alegria", "Campos Elísios", "Morada da colina"],
    "Itatiaia": ["Jardim paineiras", "Vila Odete", "Vila Pinheiro"],
    "Volta Redonda": ["São Luís", "Candelária", "Dom Bosco"]
  };
  List<String> bairrosDisponiveis = [];
  String bairroSelecionado = "";

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
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        persistentFooterButtons: [
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // double av1Value = double.parse(av1.text);
                    // double av2Value = double.parse(av2.text);

                    // media.text = "${(av1Value + av2Value) / 2}";
                  },
                  child: const Text("Calcular")),
              ElevatedButton(
                onPressed: () {
                  matricula.clear();
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

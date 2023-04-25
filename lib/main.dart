import "package:flutter/material.dart";
import "package:slide_to_act/slide_to_act.dart";

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = "Formulário Simples";

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  bool _isOver18 = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Adicionar TextFormFields e ElevetedButton aqui
          const Text("Insira seu nome aqui:"),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Campo de texto não pode ser deixado em branco";
              }
              return null;
            },
          ),
          const Text("Insira seu sexo aqui:"),
          ListTile(
            title: const Text("Homem"),
            leading: Radio<String>(
              value: "male",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Mulher"),
            leading: Radio<String>(
              value: "female",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Outro"),
            leading: Radio<String>(
              value: "other",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Prefiro não identificar"),
            leading: Radio<String>(
              value: "not_identified",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ),
          const Text("Selecione sua idade:"),
          ToggleButtons(
            children: const <Widget>[
              Text("Maior de 18"),
              Text("Menor de 18"),
            ],
            isSelected: <bool>[_isOver18, !_isOver18],
            onPressed: (int index) {
              setState(() {
                _isOver18 = index == 0;
              });
            },
          ),
          const Text("Confirme que é maneiro:"),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SlideAction(
              onSubmit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Você é uma pessoa maneira >:)")));
              },
              child: const Text("Deslize para confirmar que você é maneiro", style: TextStyle(color: Colors.white)),
            ),
          ),
          const Text("Após preencher seus dados, pode clicar em enviar"),
          ElevatedButton(
            onPressed: () {
              if (_gender == null || _gender == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Por favor, selecione uma opção")),
                );
              } else if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Dados aceitos e enviados")),
                );
              }
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
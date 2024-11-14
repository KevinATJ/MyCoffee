import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SurveyForm extends StatefulWidget {
  const SurveyForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  Map<String, dynamic>? _surveyData;
  late List<dynamic> _usabilidad;
  late List<dynamic> _contenido;
  late List<dynamic> _compartir;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  String _userType = 'Estudiante de IDVRV (sin cursar dispositivos moviles)';

  @override
  void initState() {
    super.initState();
    _loadSurveyData();
  }

  Future<void> _loadSurveyData() async {
    final String response = await rootBundle.loadString('assets/JSON/survey.json');
    final data = json.decode(response);
    setState(() {
      _surveyData = data;
      _usabilidad = data['usabilidad'];
      _contenido = data['contenido'];
      _compartir = data['compartir'];
    });
  }

  Future<void> _sendSurveyEmail(Map<String, dynamic> responses) async {
    String formattedBody = _formatResponses(responses);
    final Email email = Email(
      body: formattedBody,
      subject: 'Encuesta de la aplicación MyCoffee',
      recipients: ['kevintjara@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  String _formatResponses(Map<String, dynamic> responses) {
    String formatSection(List<dynamic> questions, String title) {
      String sectionText = "$title:\n";
      for (var question in questions) {
        sectionText += "- ${question['titulo']}\n";
        sectionText += "  Respuesta: ${question['valor']} estrellas\n";
        sectionText += "  ${question['min']} | ${question['max']}\n";
      }
      return sectionText;
    }

    String usabilidad = formatSection(responses['usabilidad'], 'Usabilidad');
    String contenido = formatSection(responses['contenido'], 'Contenido');
    String compartir = formatSection(responses['compartir'], 'Compartir');

    return '''
    Encuesta de la aplicación MyCoffee:

    Nombre Completo: ${responses['nombreCompleto']}
    Relación con Kevin Troncoso: ${responses['relacionConKevin']}
    Tipo de Usuario: ${responses['tipoDeUsuario']}

    $usabilidad

    $contenido

    $compartir
    ''';
  }

  Widget _buildQuestions(List<dynamic> questions, String category) {
    List<Widget> questionWidgets = [];
    for (var question in questions) {
      questionWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question['titulo'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Slider(
                value: question['valor'].toDouble(),
                min: 0,
                max: 5,
                divisions: 5,
                label: '${question['valor']}',
                onChanged: (double value) {
                  setState(() {
                    question['valor'] = value.toInt();
                  });
                },
              ),
              Text('Valor: ${question['valor']}'),
              Text('Mínimo: ${question['min']}'),
              Text('Máximo: ${question['max']}'),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...questionWidgets,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_surveyData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Encuesta')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuesta de Usabilidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildQuestions(_usabilidad, 'Usabilidad'),
                const Divider(),
                _buildQuestions(_contenido, 'Contenido'),
                const Divider(),
                _buildQuestions(_compartir, 'Compartir'),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nombre Completo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(hintText: 'Introduce tu nombre completo'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre completo';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('¿Cuál es tu relación con Kevin Troncoso?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _relationController,
                        decoration: const InputDecoration(hintText: 'Escribe tu relación con Kevin Troncoso'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu relación con Kevin Troncoso';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tipo de Usuario', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        value: _userType,
                        items: const [
                          DropdownMenuItem(
                            value: 'Estudiante de IDVRV (sin cursar dispositivos moviles)',
                            child: Text('Estudiante de IDVRV (sin cursar dispositivos moviles)'),
                          ),
                          DropdownMenuItem(
                            value: 'Cursando dispositivos moviles',
                            child: Text('Cursando dispositivos moviles'),
                          ),
                          DropdownMenuItem(
                            value: 'Externo a la carrera de IDVRV',
                            child: Text('Externo a la carrera de IDVRV'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _userType = newValue!;
                          });
                        },
                        decoration: const InputDecoration(hintText: 'Selecciona tu tipo de usuario'),
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecciona tu tipo de usuario';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Map<String, dynamic> responses = {
                        'usabilidad': _usabilidad,
                        'contenido': _contenido,
                        'compartir': _compartir,
                        'nombreCompleto': _fullNameController.text,
                        'relacionConKevin': _relationController.text,
                        'tipoDeUsuario': _userType,
                      };
                      _sendSurveyEmail(responses);
                    }
                  },
                  child: const Text('Enviar Encuesta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


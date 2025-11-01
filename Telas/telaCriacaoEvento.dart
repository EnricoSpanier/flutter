// 13. Tela de Criação de Evento
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _eventType;
  bool _hasChanges = false;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _confirmCreate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento criado com sucesso!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  void _cancelCreate(BuildContext context) {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alterações não salvas'),
            content: const Text('Você tem alterações não salvas. Deseja sair mesmo assim?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Voltar a editar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text('Sair'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Evento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _cancelCreate(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: () => setState(() => _hasChanges = true),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      child: const Text('Inserir imagem do evento'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Título do Evento',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Ex.: Torneio Airsoft 2025',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Data',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    hintText: 'Ex.: 15/11/2025',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma data';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Local',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: 'Ex.: Vacaria/RS',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um local';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Descrição',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Detalhes do evento',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value != null && value.length > 200) {
                      return 'A descrição não pode exceder 200 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Tipo de Evento',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                DropdownButtonFormField<String>(
                  value: _eventType,
                  hint: const Text('Selecione o tipo'),
                  items: <String>['Público', 'Privado (Pago)', 'Privado (Gratuito)']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _eventType = newValue;
                      _hasChanges = true;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um tipo de evento';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _confirmCreate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      child: const Text('Criar Evento'),
                    ),
                    ElevatedButton(
                      onPressed: () => _cancelCreate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

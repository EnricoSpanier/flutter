// 15. Tela de Gerenciamento de Eventos
class ManageEventsScreen extends StatefulWidget {
  const ManageEventsScreen({super.key});

  @override
  State<ManageEventsScreen> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends State<ManageEventsScreen> {
  List<Map<String, String>> enrolledEvents = [
    {
      'title': 'Operação maremoto',
      'date': '24/03/2024',
      'location': 'Santiago/RS',
      'type': 'Privado (Pago)',
      'description': 'Campo competitivo.',
      'imageUrl': 'https://i.imgur.com/9bAW1CR.png',
    },
    {
      'title': 'Operação Serpente',
      'date': '20/09/2025',
      'location': 'São Luis/MA',
      'type': 'Público',
      'description': 'Competição aberta de airsoft.',
      'imageUrl': 'https://i.imgur.com/dM6Svwd.png',
    },
  ];

  List<Map<String, String>> createdEvents = [
    {
      'title': 'Comando Selva',
      'date': '05/06/2025',
      'location': 'Tabaí/RS',
      'type': 'Privado (Pago)',
      'description': 'Campo competitivo.',
      'imageUrl': 'https://i.imgur.com/5wS9K3j.png',
    },
  ];

  void _showDetailsDialog(BuildContext context, Map<String, String> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event['title']!),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Data: ${event['date']}'),
                Text('Local: ${event['location']}'),
                Text('Tipo: ${event['type']}'),
                Text('Descrição: ${event['description']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showCancelConfirmation(BuildContext context, Map<String, String> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Cancelamento'),
          content: const Text('Tem certeza que deseja cancelar a inscrição neste evento?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  enrolledEvents.remove(event);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Inscrição cancelada!')),
                );
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Eventos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Eventos Inscritos',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ...enrolledEvents.map((event) {
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      event['imageUrl']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(event['title']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Data: ${event['date']}'),
                        Text('Local: ${event['location']}'),
                        Text('Tipo: ${event['type']}'),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Ver Detalhes') {
                          _showDetailsDialog(context, event);
                        } else if (value == 'Cancelar Inscrição') {
                          _showCancelConfirmation(context, event);
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Ver Detalhes',
                          child: Text('Ver Detalhes'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Cancelar Inscrição',
                          child: Text('Cancelar Inscrição'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16.0),
              const Text(
                'Eventos Criados por Você',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ...createdEvents.map((event) {
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      event['imageUrl']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(event['title']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Data: ${event['date']}'),
                        Text('Local: ${event['location']}'),
                        Text('Tipo: ${event['type']}'),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Ver Detalhes') {
                          _showDetailsDialog(context, event);
                        } else if (value == 'Gerenciar Evento') {
                          // TODO: Navegar para tela de gerenciamento de evento
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Ver Detalhes',
                          child: Text('Ver Detalhes'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Gerenciar Evento',
                          child: Text('Gerenciar Evento'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

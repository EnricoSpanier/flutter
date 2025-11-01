// 14. Tela de Pesquisa de Eventos
class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  final _searchController = TextEditingController();
  String _selectedDate = 'Qualquer data';
  String _selectedLocation = 'Qualquer local';
  String _selectedType = 'Qualquer tipo';
  List<Map<String, String>> events = [
    {
      'title': 'OPERAÇÃO TROIA III',
      'date': '25/10/2025',
      'location': 'Vacaria/RS',
      'type': 'Privado (Pago)',
      'description': 'Treinamento avançado de táticas airsoft.',
      'imageUrl': 'https://i.imgur.com/RCRutFm.png',
    },
    {
      'title': 'Torneio Airsoft 2025',
      'date': '15/11/2025',
      'location': 'Porto Alegre/RS',
      'type': 'Público',
      'description': 'Competição aberta de airsoft.',
      'imageUrl': 'https://i.imgur.com/xNdRovc.jpeg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filterEvents(String searchTerm) {
    return events.where((event) {
      final matchesSearch = event['title']!.toLowerCase().contains(searchTerm.toLowerCase()) ||
          event['description']!.toLowerCase().contains(searchTerm.toLowerCase());
      final matchesDate = _selectedDate == 'Qualquer data' || event['date'] == _selectedDate;
      final matchesLocation = _selectedLocation == 'Qualquer local' || event['location'] == _selectedLocation;
      final matchesType = _selectedType == 'Qualquer tipo' || event['type'] == _selectedType;
      return matchesSearch && matchesDate && matchesLocation && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procurar Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar eventos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedDate,
                  hint: const Text('Qualquer data'),
                  items: <String>['Qualquer data', '25/10/2025', '15/11/2025']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDate = newValue!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _selectedLocation,
                  hint: const Text('Qualquer local'),
                  items: <String>['Qualquer local', 'Vacaria/RS', 'Porto Alegre/RS']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLocation = newValue!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _selectedType,
                  hint: const Text('Qualquer tipo'),
                  items: <String>['Qualquer tipo', 'Público', 'Privado (Pago)', 'Privado (Gratuito)']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filterEvents(_searchController.text).length,
                itemBuilder: (context, index) {
                  final event = _filterEvents(_searchController.text)[index];
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
                          Text('Descrição: ${event['description']}'),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

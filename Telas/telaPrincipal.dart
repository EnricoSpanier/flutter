// 11. Tela Principal (após login)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageData homePageData = Provider.of<HomePageData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              homePageData.siteName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            const SizedBox(width: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchEventScreen()),
                );
              },
              child: const Text(
                'Procurar evento',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(width: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageEventsScreen()),
                );
              },
              child: const Text(
                'Gerenciar eventos',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Editar Perfil') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              } else if (value == 'Criar Evento') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateEventScreen()),
                );
              } else if (value == 'Deslogar') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Editar Perfil',
                child: Text('Editar Perfil'),
              ),
              const PopupMenuItem<String>(
                value: 'Criar Evento',
                child: Text('Criar Evento'),
              ),
              const PopupMenuItem<String>(
                value: 'Deslogar',
                child: Text('Deslogar'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(homePageData.userAvatarUrl),
                radius: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(homePageData.userAvatarUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    homePageData.userName,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 400.0,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        'https://i.imgur.com/RCRutFm.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            homePageData.mainImageOverlayText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.share, size: 28),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.star_border, size: 28),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _showEventDetails(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade100,
                          foregroundColor: Colors.purple.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                        child: const Text('saber mais'),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.more_vert, size: 28),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalhes do Evento'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text('Descrição:'),
                Text('Nome do Evento: OPERAÇÃO TROIA III'),
                Text('Organizadores: EquipeHard'),
                Text('Data do evento: 25/10/2025'),
                Text('Local do evento: Vacaria/RS'),
                Text('Tipo de evento: privado (Pago)'),
                Text('Nota do organizador: Treinamento avançado de táticas airsoft.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Voltar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventRegistrationScreen(
                      event: {
                        'title': 'OPERAÇÃO TROIA III',
                        'date': '25/10/2025',
                        'location': 'Vacaria/RS',
                        'type': 'Privado (Pago)',
                        'description': 'Treinamento avançado de táticas airsoft.',
                        'imageUrl': 'https://i.imgur.com/8oL5V4K.jpeg',
                      },
                    ),
                  ),
                );
              },
              child: const Text('Inscrever-se'),
            ),
          ],
        );
      },
    );
  }
}

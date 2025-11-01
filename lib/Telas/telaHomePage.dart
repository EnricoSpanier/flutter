import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. DATA_MODEL
class HomePageData extends ChangeNotifier {
  final String siteName;
  final List<String> navLinks;
  final String userName;
  final String userAvatarUrl;
  final String mainImageUrl;
  final String mainImageOverlayText;

  HomePageData()
      : siteName = 'Organizador de Eventos',
        navLinks = const ['Procurar evento', 'Gerenciar eventos'],
        userName = 'Usuário 982',
        userAvatarUrl =
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        mainImageUrl =
            'https://i.imgur.com/xNdRovc.jpeg',
        mainImageOverlayText = '';
}

// 2. O Widget Raiz (Root Widget)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageData>(
      create: (BuildContext context) => HomePageData(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Custom UI App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

// 3. Homepage sem login
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageData homePageData = Provider.of<HomePageData>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _TopNavigationBar(homePageData: homePageData),
            _UserProfileSection(homePageData: homePageData),
            _MainContentCard(homePageData: homePageData),
            const _ActionButtonsSection(),
          ],
        ),
      ),
    );
  }
}

// 4. Widget: Barra de Navegação Superior
class _TopNavigationBar extends StatelessWidget {
  final HomePageData homePageData;

  const _TopNavigationBar({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              homePageData.siteName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: homePageData.navLinks.map<Widget>(
                  (link) {
                    return TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        link,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(width: 8.0),
            CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              radius: 18,
              child: Icon(
                Icons.person,
                color: Colors.purple.shade700,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Widget: Seção de Perfil do Usuário
class _UserProfileSection extends StatelessWidget {
  final HomePageData homePageData;

  const _UserProfileSection({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

// 6. Widget: Card de Conteúdo Principal (com imagem ajustada)
class _MainContentCard extends StatelessWidget {
  final HomePageData homePageData;

  const _MainContentCard({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                homePageData.mainImageUrl,
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
    );
  }
}

// 7. Widget: Seção de Botões de Ação
class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.timer_outlined, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.star_border, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
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
                child: const Text('Saber Mais'),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ],
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
                Text('Nome do Evento: Treinamento Básico Airsoft'),
                Text('Organizadores: EquipeHard'),
                Text('Data do evento: 18/05/2025'),
                Text('Local do evento: Vacaria/RS'),
                Text('Tipo de evento: privado (Pago)'),
                Text('Nota do organizador: ...'),
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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

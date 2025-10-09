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
        navLinks = const ['Procurar Evento', 'Gerenciar eventos'],
        userName = 'Usuário 982',
        userAvatarUrl =
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        mainImageUrl =
            'https://i.imgur.com/xNdRovc.jpeg',
        mainImageOverlayText = '';
}

void main() {
  runApp(const MyApp());
}

// 2. O Widget Raiz (Root Widget)
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

// 3. O Widget de Tela (Home Screen)
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
                children: homePageData.navLinks
                    .map<Widget>(
                      (String link) => TextButton(
                        onPressed: () {
                          // TODO: Implement navigation for page links
                        },
                        child: Text(
                          link,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            backgroundColor: Colors.transparent, // In case image fails to load
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
        clipBehavior: Clip.antiAlias, // Ensures content is clipped to card shape
        child: SizedBox(
          height: 400.0, // Increased height to accommodate the full image
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Image.network(
                homePageData.mainImageUrl,
                fit: BoxFit.cover, // Changed to BoxFit.contain to show the entire image
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
                  // TODO: Implement timer action
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, size: 28),
                onPressed: () {
                  // TODO: Implement share action
                },
              ),
              IconButton(
                icon: const Icon(Icons.star_border, size: 28),
                onPressed: () {
                  // TODO: Implement favorite action
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement "Saber Mais" action
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
                  // TODO: Implement more options action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


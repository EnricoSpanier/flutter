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

// 8. Tela de Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final HomePageData homePageData = Provider.of<HomePageData>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TopNavigationBarLogin(homePageData: homePageData),
            const SizedBox(height: 20.0),
            const Text(
              'Login',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            const Text('Nome do usuário ou email'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Usuário ou email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Senha'),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 150.0, // Botão menor
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Altura reduzida
                ),
                child: const Text('Logar'),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                const Text('lembrar de mim'),
              ],
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
              },
              child: const Text(
                'esqueci minha senha',
                style: TextStyle(color: Colors.purple),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                'não tem conta? cadastre-se',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 9. Widget: Barra de Navegação Superior para Login
class _TopNavigationBarLogin extends StatelessWidget {
  final HomePageData homePageData;

  const _TopNavigationBarLogin({required this.homePageData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              homePageData.siteName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 10. Tela de Cadastro
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
              'Cadastro',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            const Text('Nome completo'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Seu nome completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Email'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'seuemail@example.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Senha'),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Confirmar senha'),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirme sua senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Text('Completar cadastro'),
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                'Já tem uma conta? Faça login',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

// 12. Tela de Edição de Perfil
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'usuário 123');
  final _emailController = TextEditingController(text: 'usuario123@example.com');
  final _bioController = TextEditingController(text: 'Jogador de airsoft há 5 anos.');
  bool _hasChanges = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _confirmEdit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  void _cancelEdit(BuildContext context) {
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
    final HomePageData homePageData = Provider.of<HomePageData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _cancelEdit(context),
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
                const Text(
                  'Foto de perfil',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(homePageData.userAvatarUrl),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Nome',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Seu nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'seuemail@exemplo.com',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Biografia',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    hintText: 'Fale um pouco sobre você',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value != null && value.length > 150) {
                      return 'A biografia não pode exceder 150 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _confirmEdit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      child: const Text('Confirmar edição'),
                    ),
                    ElevatedButton(
                      onPressed: () => _cancelEdit(context),
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

// 13. Tela de Criação de Evento (Placeholder)
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

// 15. Tela de Gerenciamento de Eventos (Placeholder)
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

//16. Tela de Inscrição de evento
class EventRegistrationScreen extends StatefulWidget {
  final Map<String, String> event;

  const EventRegistrationScreen({super.key, required this.event});

  @override
  State<EventRegistrationScreen> createState() => _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _participantsController = TextEditingController();
  String? _paymentMethod;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  void _submitRegistration(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição realizada com sucesso!')),
      );
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
        title: Text('Inscrição - ${widget.event['title']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Detalhes do Evento',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      'https://i.imgur.com/RCRutFm.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(widget.event['title']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Data: ${widget.event['date']}'),
                        Text('Local: ${widget.event['location']}'),
                        Text('Tipo: ${widget.event['type']}'),
                        Text('Descrição: ${widget.event['description']}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Dados do Participante',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _participantsController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Participantes',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número de participantes';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Método de Pagamento',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                DropdownButtonFormField<String>(
                  value: _paymentMethod,
                  hint: const Text('Selecione o método'),
                  items: <String>['Cartão de Crédito', 'Pix', 'Boleto']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _paymentMethod = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um método de pagamento';
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
                      onPressed: () => _submitRegistration(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      child: const Text('Confirmar Inscrição'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
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

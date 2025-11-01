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

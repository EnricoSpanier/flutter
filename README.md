# flutter
https://dartpad.dev


1. Cache do Flutter (build cache)
O Flutter armazena builds em cache. Se você fez alterações no código, mas o build antigo foi reutilizado, ele mostra a versão antiga.
Solução:

flutter pub get

flutter build linux  # ou flutter run -d linux

Importante: Sempre rode flutter clean quando notar comportamentos estranhos entre plataformas.

2. Hot Reload / Hot Restart não aplicado no Linux
Se você está rodando com flutter run -d linux, o hot reload pode não estar funcionando corretamente, ou você só fez hot restart em uma plataforma.
Solução:

Pare a aplicação (Ctrl + C)
Limpe e reconstrua:

flutter clean

flutter run -d linux

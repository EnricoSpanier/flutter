
############################################################
# Etapa 1: Build do app Flutter (Web)
############################################################
FROM ubuntu:22.04 AS build

# Instala dependências do sistema
RUN apt-get update && \
	apt-get install -y curl git unzip xz-utils ca-certificates && \
	rm -rf /var/lib/apt/lists/*

# Define versão do Flutter como argumento (tag/branch)
ARG FLUTTER_VERSION=3.19.6

# Instala Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter --branch ${FLUTTER_VERSION} --depth 1
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Define diretório de trabalho
WORKDIR /app

# Otimiza cache: copie apenas o manifesto de dependências primeiro
COPY pubspec.* ./

# Habilita e prepara o alvo web e obtém dependências
RUN flutter config --enable-web && \
	flutter precache --web && \
	flutter pub get

# Agora copie o restante do código
COPY . .

# Build do app Flutter para web (release)
RUN flutter build web --release

############################################################
# Etapa 2: Imagem final com Nginx para servir estáticos
############################################################
FROM nginx:alpine

# Copia os arquivos de build da etapa anterior
COPY --from=build /app/build/web /usr/share/nginx/html

# Porta padrão do nginx
EXPOSE 80

# Comando padrão para manter o nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]


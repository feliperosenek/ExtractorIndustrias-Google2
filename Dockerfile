# Use a imagem oficial do Node.js como base
FROM node:18

# Atualizar o sistema e instalar dependências adicionais
RUN apt-get update && apt-get install -y \
  curl \
  git \
  libasound2

# Instalar nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# Configurar as variáveis de ambiente para nvm e node
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 18

# Instalar o Node.js usando nvm
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION && nvm alias default $NODE_VERSION"

# Definir o diretório de trabalho no contêiner
WORKDIR /app

# Clonar o repositório
RUN git clone https://github.com/feliperosenek/extractorindustrias-google2.git .

# Instalar as dependências do projeto
RUN npm install

# Comando para iniciar a aplicação
CMD ["npm", "start"]

# Expor a porta em que a aplicação estará rodando
EXPOSE 3000

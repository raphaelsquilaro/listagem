# 📱 Meu Feed — Flutter

Um aplicativo de feed desenvolvido com **Flutter e Dart**, inspirado em redes sociais. O projeto apresenta publicações com fotos, nomes de usuários, curtidas e botões de interação.

## ✨ Funcionalidades

- 👤 **Identificação de usuários:** exibe o nome de cada pessoa junto a um avatar.
- 🖼️ **Exibição de imagens:** apresenta fotos nas publicações.
- ❤️ **Sistema de curtidas:** permite curtir e descurtir publicações, atualizando a quantidade de curtidas em tempo real.
- 💬 **Botão de comentários:** exibe uma mensagem ao ser pressionado.
- 🔗 **Botão de compartilhamento:** exibe uma mensagem ao ser pressionado.
- ⚠️ **Tratamento de erros:** apresenta um ícone alternativo quando uma imagem não pode ser carregada.
- 📜 **Lista dinâmica:** utiliza `ListView.builder` para construir as publicações.

## 🛠️ Tecnologias utilizadas

- [Flutter](https://flutter.dev/) — framework para desenvolvimento de interfaces.
- [Dart](https://dart.dev/) — linguagem de programação utilizada pelo Flutter.
- `Material Design` — componentes visuais por meio do pacote `material.dart`.

## 📂 Estrutura e organização

O feed é implementado no widget `Feed`, que utiliza `StatefulWidget` para gerenciar as interações e atualizar a interface.

As publicações são organizadas em listas:

| Lista | Descrição |
|---|---|
| `fotos` | Caminhos ou endereços das imagens das publicações. |
| `curtidas` | Quantidade de curtidas de cada publicação. |
| `gostei` | Estado de curtida de cada publicação. |
| `nomes` | Nomes dos usuários que fizeram as publicações. |

## 🚀 Como executar o projeto

### 1. Pré-requisitos

Certifique-se de ter instalado:

- Flutter SDK
- Dart SDK (incluído na instalação do Flutter)
- Android Studio, VS Code ou outra IDE compatível
- Um emulador ou dispositivo para executar o aplicativo

### 2. Clone o repositório

```bash
git clone <URL_DO_REPOSITORIO>
```

Entre na pasta do projeto:

```bash
cd <NOME_DO_PROJETO>
```

### 3. Instale as dependências

```bash
flutter pub get
```

### 4. Execute o aplicativo

```bash
flutter run
```

## 🖼️ Imagens das publicações

O código utiliza os seguintes caminhos para as imagens:

- `../../assets/dangaronpa.jpg`
- `../../assets/jojo.jpg`
- `../../assets/madoka.jpg`

**Importante:** atualmente, as imagens são carregadas com `Image.network`, que espera URLs de rede. Se os arquivos estiverem armazenados localmente na pasta `assets`, utilize `Image.asset` e registre os arquivos no `pubspec.yaml`.

Exemplo de configuração:

```yaml
flutter:
  assets:
    - assets/dangaronpa.jpg
    - assets/jojo.jpg
    - assets/madoka.jpg
```

Nesse caso, ajuste o código para utilizar os caminhos relativos à pasta `assets`, como `assets/dangaronpa.jpg`.

## ❤️ Como funciona o sistema de curtidas?

Ao pressionar o botão de coração, o aplicativo:

1. Alterna o estado da curtida entre ativo e inativo.
2. Atualiza o ícone para indicar se a publicação foi curtida.
3. Incrementa ou decrementa a quantidade de curtidas.
4. Utiliza `setState()` para atualizar a interface.

## 🔮 Melhorias futuras

- Implementar comentários reais nas publicações.
- Adicionar compartilhamento funcional.
- Permitir criar novas publicações.
- Carregar usuários e publicações de uma API ou banco de dados.
- Salvar as curtidas para mantê-las após fechar o aplicativo.
- Adicionar autenticação de usuários.

## 📄 Licença

Este projeto foi desenvolvido para fins de estudo e prática com Flutter. Adicione uma licença ao repositório caso deseje definir formalmente as condições de uso e distribuição.

---

**Desenvolvido com Flutter 💙**

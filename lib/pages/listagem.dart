import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<String> fotos = [
    '../../assets/dangaronpa.jpg',
    '../../assets/jojo.jpg',
    '../../assets/madoka.jpg',
  ];

  final List<int> curtidas = [12, 25, 8];
  final List<bool> gostei = [false, false, false];
  final List<String> nomes = ['Raphael', 'Henzo', 'Fabricio'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Feed'),
      ),
      body: ListView.builder(
        itemCount: fotos.length,
        itemBuilder: (context, i) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(nomes[i]),
            ),
            Image.network(
              fotos[i],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 250,
                  child: Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                );
              },
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    gostei[i]
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: gostei[i] ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      gostei[i] = !gostei[i];
                      curtidas[i] += gostei[i] ? 1 : -1;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Botão comentar'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Botão compartilhar'),
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('${curtidas[i]} curtidas'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
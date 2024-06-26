import 'package:flutter/material.dart';

class MessageErrorScroll extends StatelessWidget {
  const MessageErrorScroll({
    this.title = 'Algo ha salido mal',
    this.message = 'Verifica tu conexión a internet y asegúrate de tener información sincronizada.\n'
        'Por favor vuelve a intentar más tarde.',
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Text(
              title?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (message != null)
              const SizedBox(
                height: 16,
              ),
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
              )
          ],
        ),
      ),
    );
  }
}
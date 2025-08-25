import 'dart:io';

void main() {
  print('--- Generador de QR para WiFi ---');

  stdout.write('Ingrese el nombre de la red (SSID): ');
  String ssid = stdin.readLineSync() ?? '';

  print('Seleccione el tipo de seguridad:');
  print('1. WPA/WPA2');
  print('2. WEP');
  print('3. Abierta');
  stdout.write('Opción (1-3): ');
  int? tipo = int.tryParse(stdin.readLineSync() ?? '');
  String tipoStr;
  bool requiereClave = true;
  switch (tipo) {
    case 1:
      tipoStr = 'WPA';
      break;
    case 2:
      tipoStr = 'WEP';
      break;
    case 3:
      tipoStr = 'nopass';
      requiereClave = false;
      break;
    default:
      print('Tipo de seguridad inválido.');
      return;
  }

  String password = '';
  if (requiereClave) {
    stdout.write('Ingrese la contraseña: ');
    password = stdin.readLineSync() ?? '';
    // Validación de seguridad de la contraseña
    List<String> sugerencias = [];
    if (password.length < 8) {
      sugerencias.add('Debe tener al menos 8 caracteres.');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      sugerencias.add('Agregue al menos una letra mayúscula.');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      sugerencias.add('Agregue al menos una letra minúscula.');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      sugerencias.add('Incluya al menos un número.');
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]~_\-]').hasMatch(password)) {
      sugerencias.add('Incluya al menos un carácter especial.');
    }
    if (sugerencias.isNotEmpty) {
      print('\nAdvertencia: Su contraseña no es segura. Sugerencias:');
      for (var s in sugerencias) {
        print('- $s');
      }
    } else {
      print('Contraseña segura.');
    }
  }

  // Generar string para QR WiFi
  String qrString = 'WIFI:T:$tipoStr;S:$ssid;';
  if (requiereClave) {
    qrString += 'P:$password;';
  }
  qrString += 'H:false;';

  print('\n--- Código QR WiFi generado ---');
  print(qrString);

  print('\nInstrucciones de uso:');
  print('- Android: Abra la cámara o una app de QR, escanee el código y toque "Conectar a red WiFi".');
  print('- iOS: Abra la cámara, escanee el QR y toque la notificación para conectarse.');
  print('- Otros dispositivos: Use una app de QR compatible y siga las instrucciones para conectarse a la red.');
}

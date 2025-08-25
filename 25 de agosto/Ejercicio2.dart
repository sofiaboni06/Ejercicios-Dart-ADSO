import 'dart:io';

void main() {
	print('--- Verificador de Contraseñas Seguras ---');
	stdout.write('Ingrese una contraseña: ');
	String password = stdin.readLineSync() ?? '';

	int score = 0;
	List<String> sugerencias = [];

	// Verificar longitud
	if (password.length >= 8) {
		score++;
	} else {
		sugerencias.add('Debe tener al menos 8 caracteres.');
	}

	// Verificar mayúsculas
	if (RegExp(r'[A-Z]').hasMatch(password)) {
		score++;
	} else {
		sugerencias.add('Agregue al menos una letra mayúscula.');
	}

	// Verificar minúsculas
	if (RegExp(r'[a-z]').hasMatch(password)) {
		score++;
	} else {
		sugerencias.add('Agregue al menos una letra minúscula.');
	}

	// Verificar números
	if (RegExp(r'[0-9]').hasMatch(password)) {
		score++;
	} else {
		sugerencias.add('Incluya al menos un número.');
	}

	// Verificar caracteres especiales
	if (RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]~_\-]').hasMatch(password)) {
		score++;
	} else {
		sugerencias.add('Incluya al menos un carácter especial (ej: !, @, #, etc.).');
	}

	String nivel;
	switch (score) {
		case 5:
			nivel = 'Muy fuerte';
			break;
		case 4:
			nivel = 'Fuerte';
			break;
		case 3:
			nivel = 'Media';
			break;
		default:
			nivel = 'Débil';
	}

	print('\nNivel de seguridad: $nivel');
	if (sugerencias.isNotEmpty) {
		print('Sugerencias para mejorar tu contraseña:');
		for (var s in sugerencias) {
			print('- $s');
		}
	} else {
		print('¡Tu contraseña es muy segura!');
	}
}

import 'dart:io';

void main() {
	print('--- Calculadora de Tiempo de Viaje Urbano ---');

	stdout.write('Ingrese el origen: ');
	String origen = stdin.readLineSync() ?? '';
	stdout.write('Ingrese el destino: ');
	String destino = stdin.readLineSync() ?? '';

	stdout.write('Ingrese la distancia en km: ');
	double? distancia = double.tryParse(stdin.readLineSync() ?? '');
	if (distancia == null || distancia <= 0) {
		print('Distancia inválida.');
		return;
	}

	print('Seleccione el medio de transporte:');
	print('1. A pie');
	print('2. Bicicleta');
	print('3. Carro');
	print('4. Transporte público');
	stdout.write('Opción (1-4): ');
	int? medio = int.tryParse(stdin.readLineSync() ?? '');
	String medioStr;
	double velocidad; // km/h
	double costoBase = 0;
	switch (medio) {
		case 1:
			medioStr = 'A pie';
			velocidad = 5;
			break;
		case 2:
			medioStr = 'Bicicleta';
			velocidad = 15;
			break;
		case 3:
			medioStr = 'Carro';
			velocidad = 40;
			costoBase = 3 + (distancia * 1.5); // S/3 base + S/1.5 por km
			break;
		case 4:
			medioStr = 'Transporte público';
			velocidad = 25;
			costoBase = 2.5; // tarifa plana
			break;
		default:
			print('Medio de transporte inválido.');
			return;
	}

	print('Hora del día:');
	print('1. Hora pico');
	print('2. Normal');
	stdout.write('Opción (1-2): ');
	int? hora = int.tryParse(stdin.readLineSync() ?? '');
	double factorTrafico;
	String horaStr;
	switch (hora) {
		case 1:
			horaStr = 'Hora pico';
			factorTrafico = 1.5;
			break;
		case 2:
			horaStr = 'Normal';
			factorTrafico = 1.0;
			break;
		default:
			print('Opción de hora inválida.');
			return;
	}

	double tiempo = (distancia / velocidad) * factorTrafico; // en horas
	double costo = costoBase;

	print('\nResumen del viaje:');
	print('Origen: $origen');
	print('Destino: $destino');
	print('Distancia: ${distancia.toStringAsFixed(2)} km');
	print('Medio de transporte: $medioStr');
	print('Hora del día: $horaStr');
	print('Tiempo estimado: ${(tiempo * 60).toStringAsFixed(0)} minutos');
	print('Costo total: S/ ${costo.toStringAsFixed(2)}');
}

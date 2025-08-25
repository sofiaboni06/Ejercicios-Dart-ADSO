class Archivo {
	String nombre;
	int tamano; // en KB
	String tipo; // ej: 'jpg', 'mp3', 'pdf'
	DateTime fechaCreacion;
	String ruta;

	Archivo({
		required this.nombre,
		required this.tamano,
		required this.tipo,
		DateTime? fechaCreacion,
		required this.ruta,
	}) : fechaCreacion = fechaCreacion ?? DateTime.now();

	@override
	String toString() {
		return '$nombre.$tipo [$tamano KB] - $ruta (${fechaCreacion.toString()})';
	}
}

class GestorArchivos {
	List<Archivo> archivos = [];

	void agregar(Archivo a) {
		archivos.add(a);
	}

	void listar() {
		for (var a in archivos) {
			print(a);
		}
	}

	List<Archivo> buscarPorNombre(String nombre) {
		return archivos.where((a) => a.nombre.contains(nombre)).toList();
	}

	List<Archivo> buscarPorTipo(String tipo) {
		return archivos.where((a) => a.tipo == tipo).toList();
	}

	int espacioUsado() {
		return archivos.fold(0, (sum, a) => sum + a.tamano);
	}

	void organizarPorFecha({bool asc = true}) {
		archivos.sort((a, b) => asc ? a.fechaCreacion.compareTo(b.fechaCreacion) : b.fechaCreacion.compareTo(a.fechaCreacion));
	}

	void organizarPorTamano({bool asc = true}) {
		archivos.sort((a, b) => asc ? a.tamano.compareTo(b.tamano) : b.tamano.compareTo(a.tamano));
	}

	void transferir(String nombre, String nuevaRuta) {
		for (var a in archivos) {
			if (a.nombre == nombre) {
				a.ruta = nuevaRuta;
			}
		}
	}
}

void main() {
	final gestor = GestorArchivos();
	gestor.agregar(Archivo(nombre: 'foto1', tamano: 2048, tipo: 'jpg', ruta: '/DCIM/Camara'));
	gestor.agregar(Archivo(nombre: 'musica', tamano: 5120, tipo: 'mp3', ruta: '/Music'));
	gestor.agregar(Archivo(nombre: 'documento', tamano: 300, tipo: 'pdf', ruta: '/Docs'));

	print('--- Archivos en el dispositivo ---');
	gestor.listar();

	print('\nBuscar archivos tipo mp3:');
	var mp3s = gestor.buscarPorTipo('mp3');
	for (var a in mp3s) {
		print(a);
	}

	print('\nEspacio usado: ${gestor.espacioUsado()} KB');

	print('\nOrganizando por tamaño descendente:');
	gestor.organizarPorTamano(asc: false);
	gestor.listar();

	print('\nTransfiriendo "foto1" a /Pictures...');
	gestor.transferir('foto1', '/Pictures');
	gestor.listar();
}
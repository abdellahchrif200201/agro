abstract class AppRoutes {
  const AppRoutes._();

  // Root and login routes
  static const String login = '/login';
  static const String loginNamed = 'login';

  static const String homePage = '/';
  static const String homePageNamed = 'homePage';

  // Etiquetage routes
  static const String etiquetage = '/etiquetage';
  static const String etiquetageNamed = 'etiquetage';

  static const String etiquetageCreate = 'create'; // No leading '/'
  static const String etiquetageCreateNamed = 'etiquetageCreate';

  // Traceability routes
  static const String traceability = '/traceability';
  static const String traceabilityNamed = 'traceability';

  static const String traceabilityCreate = 'create'; // No leading '/'
  static const String traceabilityCreateNamed = 'traceabilityCreate';

  // Checklist routes
  static const String checklist = '/checklist';
  static const String checklistNamed = 'checklist';

  static const String checklistCreate = 'create';
  static const String checklistCreateNamed = 'checklistCreate';
  // Temperature routes
  static const String temperature = '/temperature';
  static const String temperatureNamed = 'temperature';

  static const String temperatureCreate = 'create'; // No leading '/'
  static const String temperatureCreateNamed = 'temperatureCreate';

  // Nettoyage routes
  static const String nettoyage = '/nettoyage';
  static const String nettoyageNamed = 'nettoyage';

  static const String nettoyageCreate = 'create'; // No leading '/'
  static const String nettoyageCreateNamed = 'nettoyageCreate';

// Uncomment and adjust the following as needed
// Chambres routes
static const String chambres = '/chambres';
static const String chambresNamed = 'chambres';

static const String chambresCreate = 'create'; // No leading '/'
static const String chambresCreateNamed = 'chambresCreate';
}

# 📱 Flutter Todo App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.24.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-000000?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-6C63FF?style=for-the-badge)
![Testing](https://img.shields.io/badge/Testing-Unit%20%7C%20Widget-4CAF50?style=for-the-badge)

</div>

## 🚀 ¿Qué hace especial esta app?

Una aplicación de tareas moderna y elegante construida con Flutter que combina **funcionalidad robusta** con **experiencia de usuario excepcional**. ¡No es solo otra app de todo, es una experiencia completa de productividad!

### ✨ Características Destacadas

- **🎯 Adaptabilidad Total**: Se adapta perfectamente a iOS y Android con widgets nativos
- **💾 Persistencia Robusta**: Base de datos Hive para almacenamiento local confiable
- **🔄 CRUD Completo**: Crear, leer, actualizar y eliminar tareas con facilidad
- **📱 3 Pantallas Optimizadas**: Home, Add Task y Edit Task con navegación fluida
- **🧪 Testing Exhaustivo**: Cobertura de pruebas unitarias y de widgets
- **🏗️ Clean Architecture**: Código limpio, mantenible y escalable
- **🤖 IA Integrada**: Generación automática de descripciones con LLM
- **🎨 UI/UX Moderna**: Diseño adaptativo con Material Design 3

### 🛠️ Stack Tecnológico

- **Frontend**: Flutter 3.24.0+ con Dart
- **State Management**: Riverpod con hooks
- **Navegación**: Go Router
- **Base de Datos**: Hive (NoSQL local)
- **IA**: Integración con Hugging Face API
- **Testing**: Flutter Test + Mocktail
- **Arquitectura**: Clean Architecture con capas bien definidas

---

## 🚀 Configuración y Ejecución

### 📋 Prerrequisitos

- Flutter SDK 3.24.0 o superior
- Dart SDK 3.4.0 o superior
- Android Studio / Xcode (para emuladores)
- Git

### ⚙️ Instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/horacioduca23/flutter_todo_app.git
   cd flutter_todo_app
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Configura las variables de entorno**
   ```bash
   # Crea el archivo .env en assets/env/
   cp assets/env/.env.example assets/env/.env
   
   # Edita el archivo con tu API key de Hugging Face
   HUGGING_FACE_API_KEY=tu_api_key_aqui
   HUGGING_FACE_BASE_URL=https://router.huggingface.co/v1
   ```

4. **Genera el código necesario**
   ```bash
   flutter packages pub run build_runner build
   ```

### 🏃‍♂️ Ejecución

```bash
# Ejecuta en modo debug
flutter run

# Ejecuta en modo release
flutter run --release

# Ejecuta en un dispositivo específico
flutter run -d <device-id>
```

### 📱 Plataformas Soportadas

- **iOS**: 12.0+
- **Android**: API 21+ (Android 5.0+)

---

## 🧪 Testing

### 📊 Cobertura de Pruebas

La aplicación cuenta con una sólida suite de pruebas que incluye:

- **Pruebas Unitarias**: Controladores, repositorios y servicios
- **Pruebas de Widgets**: Interfaces de usuario y componentes
- **Pruebas de Integración**: Flujos completos de la aplicación

### 🎯 Ejecutar Pruebas

```bash
# Ejecutar todas las pruebas
flutter test

# Ejecutar pruebas con cobertura
flutter test --coverage

# Ejecutar pruebas específicas
flutter test test/unit/
flutter test test/widgets/

# Generar reporte de cobertura (debes tener lcov instalado)
genhtml coverage/lcov.info -o coverage/html
```

### 📈 Métricas de Calidad

- **Cobertura de Código**: >80% en componentes críticos
- **Pruebas Unitarias**: Controladores y lógica de negocio
- **Pruebas de Widgets**: Interfaces de usuario principales
- **Linting**: Configurado con flutter_lints

---

## 🏗️ Arquitectura

La aplicación sigue los principios de **Clean Architecture** con una estructura clara y mantenible:

```
lib/
├── src/
│   ├── constants/          # Constantes de la aplicación
│   ├── core/              # Utilidades y configuraciones
│   ├── data/              # Capa de datos (repositorios, datasources)
│   ├── domain/            # Entidades y lógica de negocio
│   ├── presentation/      # UI, controladores y widgets
│   └── routes/            # Configuración de navegación
```

### 🔄 Flujo de Datos

1. **Presentation Layer**: Widgets y controladores
2. **Domain Layer**: Entidades y casos de uso
3. **Data Layer**: Repositorios y fuentes de datos
4. **External Layer**: APIs y base de datos

---

## 🤖 Integración con IA

La aplicación incluye generación automática de descripciones usando **Large Language Models**:

- **API**: Hugging Face
- **Modelo**: MoonshotAI/Kimi-K2-Instruct
- **Funcionalidad**: Generación de descripciones basadas en título y prompt
- **Configuración**: Variables de entorno para API key

---

## 📱 Características de la UI

### 🎨 Diseño Adaptativo

- **Material Design 3**: Componentes modernos y accesibles
- **Adaptive Widgets**: Se adaptan automáticamente a iOS/Android
- **Responsive Layout**: Optimizado para diferentes tamaños de pantalla
- **Tema Consistente**: Paleta de colores y tipografía unificada

### 🎯 Experiencia de Usuario

- **Navegación Intuitiva**: Go Router para navegación fluida
- **Feedback Visual**: Indicadores de carga y estados
- **Validación en Tiempo Real**: Campos con validación instantánea

---

## 🔧 Comandos Útiles

```bash
# Limpiar y reconstruir
flutter clean
flutter pub get

# Generar código
flutter packages pub run build_runner build --delete-conflicting-outputs

# Analizar código
flutter analyze

# Formatear código
dart format lib/

# Ejecutar en modo profile
flutter run --profile

# Construir APK
flutter build apk

# Construir para iOS
flutter build ios
```


## 📞 Contact me

Si tienes alguna pregunta o necesitas ayuda:

- 📧 Email: [Horacioduca23@gmail.com]
- 💼 LinkedIn: [https://www.linkedin.com/in/horacio-duca/]

---

<div align="center">

**¡Construido con ❤️ usando Flutter!**

</div>

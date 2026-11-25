import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const ChiliLeafCareApp());
}

class ChiliLeafCareApp extends StatelessWidget {
  const ChiliLeafCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CabiCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B7A43),
          primary: const Color(0xFF1B7A43),
          surface: const Color(0xFFF6F9F7),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================================
// DATA PENYAKIT & SOLUSI (Lengkap ke-6 Kelas)
// ============================================================================
class DiseaseInfo {
  final String title;
  final String cause;
  final String solution;
  final List<String> simpleSteps;
  final bool isHealthy;

  const DiseaseInfo({
    required this.title,
    required this.cause,
    required this.solution,
    required this.simpleSteps,
    this.isHealthy = false,
  });
}

final Map<String, DiseaseInfo> diseaseDatabase = {
  'Healthy': const DiseaseInfo(
    title: 'Daun Sehat (Healthy)',
    cause: 'Tanaman mendapatkan nutrisi yang seimbang, penyiraman cukup, serta terbebas dari serangan hama maupun jamur patogen.',
    solution: 'Pertahankan pola perawatan rutin agar tanaman tetap tumbuh subur dan produktif menghasilkan buah cabai.',
    simpleSteps: [
      'Siram tanaman secara teratur pada pagi atau sore hari tanpa membuat tanah tergenang.',
      'Berikan pupuk susulan secara berkala sesuai fase pertumbuhan tanaman.',
      'Tetap pantau kondisi daun setiap beberapa hari untuk mencegah serangan hama sejak dini.',
    ],
    isHealthy: true,
  ),
  'Leaf Spot': const DiseaseInfo(
    title: 'Penyakit Bercak Daun',
    cause: 'Penyakit bercak daun (leaf spot) disebabkan oleh infeksi jamur patogen (Cercospora sp.) yang dipicu oleh kelembaban udara tinggi dan metode konvensional.',
    solution: 'Pengendalian dilakukan secara biologis menggunakan pupuk hayati mikoriza untuk meningkatkan sistem pertahanan tanaman dan menekan intensitas pathogen.',
    simpleSteps: [
      'Atur jarak tanam agar tidak terlalu rapat dan jaga kebersihan kebun untuk mencegah kelembaban udara yang terlalu tinggi di sekitar tanaman.',
      'Berikan pupuk hayati berbasis mikoriza pada area perakaran secukupnya untuk membantu penyerapan unsur hara dan memperkuat ketahanan alami tanaman.',
      'Perawatan yang tepat akan memicu pembentukan senyawa ketahanan alami pada tanaman sehingga laju penyebaran bercak daun dapat ditekan.',
    ],
  ),
  'Leaf Curl': const DiseaseInfo(
    title: 'Daun Keriting',
    cause: 'Serangan virus keriting pada tanaman cabai rawit disebabkan oleh hama vektor dari ordo/genus Oxya, Aphis, Thrips, dan Coptosoma yang didukung oleh kelembaban tinggi saat musim hujan.',
    solution: 'Pengendalian dilakukan dengan penyemprotan minyak cengkeh (Syzygium aromaticum) secara rutin untuk menekan jumlah tanaman terinfeksi dan mengusir hama vektor secara ramah lingkungan.',
    simpleSteps: [
      'Periksa tanaman secara berkala untuk mendeteksi dini keberadaan hama kecil pembawa virus (seperti kutu-kutuan atau belalang) yang sering menyerang pada musim hujan.',
      'Lakukan penyemprotan menggunakan pestisida nabati dari ekstrak daun cengkeh secara rutin setiap beberapa hari sekali pada tanaman yang terserang.',
      'Kandungan alami dalam bahan tersebut berfungsi ganda untuk menekan perkembangan virus sekaligus mengusir hama secara ramah lingkungan.',
    ],
  ),
  'Powdery Mildew': const DiseaseInfo(
    title: 'Embun Tepung',
    cause: 'Penyakit embun tepung (powdery mildew) pada tanaman cabai disebabkan oleh infeksi jamur yang ditandai dengan munculnya pertumbuhan seperti serbuk putih pada permukaan daun.',
    solution: 'Pengendalian dilakukan menggunakan perawatan terpadu, menjaga kebersihan kebun, serta memastikan sirkulasi udara di sekitar tanaman tetap optimal.',
    simpleSteps: [
      'Amati permukaan daun secara rutin untuk mendeteksi kemunculan bercak atau lapisan tipis menyerupai serbuk putih sejak dini.',
      'Gunakan bantuan sistem pemindaian atau aplikasi digital berbasis kecerdasan buatan untuk mengenali jenis penyakit daun secara cepat dan akurat.',
      'Berikan nutrisi yang seimbang serta kelola kesehatan lingkungan tanam agar daun cabai memiliki kekebalan yang kuat terhadap infeksi jamur.',
    ],
  ),
  'Whitefly': const DiseaseInfo(
    title: 'Hama Kutu Kebul',
    cause: 'Serangan kutu kebul (Bemisia tabaci) pada tanaman cabai disebabkan oleh hama polifag yang menghisap getah tanaman serta berperan sebagai vektor penyebar virus.',
    solution: 'Pengendalian hama dilakukan menggunakan minyak parafin atau ekstrak daun mimba dengan konsentrasi optimal 1% untuk menekan tingkat kerusakan secara efektif.',
    simpleSteps: [
      'Siapkan bahan pengendali hama ramah lingkungan, seperti minyak mineral khusus pertanian atau ekstrak daun mimba.',
      'Campurkan bahan tersebut dengan takaran sekitar 1% ke dalam air, lalu semprotkan secara merata ke seluruh bagian tanaman.',
      'Larutan alami tersebut akan bekerja menutupi pori-pori pernapasan hama sekaligus mengurangi nafsu makan hama, sehingga kerusakan tanaman dapat dicegah.',
    ],
  ),
  'Yellowish': const DiseaseInfo(
    title: 'Daun Kekuningan',
    cause: 'Penyakit kekuningan (yellowish) pada tanaman cabai disebabkan oleh gangguan fisiologis atau infeksi patogen yang memicu penurunan pigmentasi daun dan mengancam produktivitas hasil panen.',
    solution: 'Pengendalian dan deteksi dini dilakukan dengan pemantauan visual berkala serta perbaikan unsur hara tanah untuk mengatasi klorosis.',
    simpleSteps: [
      'Manfaatkan teknologi pengenalan citra digital untuk mendeteksi perubahan warna daun menjadi kuning secara otomatis dan presisi.',
      'Berikan tanda atau perhatian khusus pada tanaman yang menunjukkan gejala penurunan pigmen hijau atau klorosis.',
      'Segera lakukan perbaikan pemupukan untuk mengatasi kekurangan nutrisi atau lakukan pengendalian hama di sekitar area tanaman yang terindikasi kuning.',
    ],
  ),
};

// ============================================================================
// 1. HALAMAN BERANDA (HOME PAGE)
// ============================================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'CabiCare',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            tooltip: 'Tentang Kelompok',
            icon: const Icon(Icons.person_outline, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Deteksi Dini Penyakit\nDaun Cabai Berbasis AI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kenali penyakit tanaman cabai secara instan melalui foto kamera dan dapatkan panduan solusi perawatan yang tepat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manfaat & Menu Aplikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildClickableFeatureCard(
                    context: context,
                    icon: Icons.camera_alt_rounded,
                    color: const Color(0xFF1B7A43),
                    title: 'Identifikasi Cepat & Akurat',
                    subtitle: 'Klik untuk mulai foto daun cabai dan analisis kondisi kesehatan tanaman menggunakan model AI.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetectionPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildClickableFeatureCard(
                    context: context,
                    icon: Icons.medical_services_outlined,
                    color: const Color(0xFFD97706),
                    title: 'Penyebab & Solusi Tepat',
                    subtitle: 'Klik untuk melihat daftar lengkap penyebab dan solusi dari seluruh 6 jenis kondisi daun cabai.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllSolutionsPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildClickableFeatureCard(
                    context: context,
                    icon: Icons.checklist_rtl_rounded,
                    color: const Color(0xFF0284C7),
                    title: 'Langkah Perawatan Sederhana',
                    subtitle: 'Klik untuk membaca panduan langkah-langkah perawatan dan pencegahan secara menyeluruh.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllStepsPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableFeatureCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN KHUSUS: SEMUA PENYEBAB & SOLUSI TEPAT
// ============================================================================
class AllSolutionsPage extends StatelessWidget {
  const AllSolutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final allEntries = diseaseDatabase.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Penyebab & Solusi Penyakit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allEntries.length,
        itemBuilder: (context, index) {
          final item = allEntries[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: item.isHealthy
                    ? primaryColor.withValues(alpha: 0.4)
                    : Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: item.isHealthy
                          ? const Color(0xFFE6F4EA)
                          : Colors.orange.shade50,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: item.isHealthy ? primaryColor : Colors.orange.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: item.isHealthy ? primaryColor : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 22),
                const Text(
                  'Penyebab:',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.cause,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Solusi Penanganan:',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B7A43),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.solution,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// HALAMAN KHUSUS: LANGKAH PERAWATAN SEDERHANA
// ============================================================================
class AllStepsPage extends StatelessWidget {
  const AllStepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final allEntries = diseaseDatabase.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Langkah Perawatan Sederhana',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allEntries.length,
        itemBuilder: (context, index) {
          final item = allEntries[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                ...List.generate(item.simpleSteps.length, (stepIdx) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline_rounded,
                            size: 18, color: primaryColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.simpleSteps[stepIdx],
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: Color(0xFF334155),
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// 2. HALAMAN DETEKSI KAMERA & HASIL SOLUSI (DENGAN THRESHOLD ANTI-ASAL)
// ============================================================================
class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;
  File? _selectedImage;
  String? _predictedLabel;
  double _confidence = 0.0;
  bool _isProcessing = false;
  bool _isInvalidImage = false;

  final List<String> _labels = [
    'Healthy',
    'Leaf Curl',
    'Leaf Spot',
    'Powdery Mildew',
    'Whitefly',
    'Yellowish',
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model/mobilenetv2_cabai.tflite');
      setState(() {
        _isModelLoaded = true;
      });
    } catch (e) {
      debugPrint('Gagal memuat model: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;

    setState(() {
      _selectedImage = File(pickedFile.path);
      _isProcessing = true;
      _predictedLabel = null;
      _isInvalidImage = false;
    });

    await _classifyImage(_selectedImage!);
  }

  Future<void> _classifyImage(File imageFile) async {
    if (_interpreter == null) return;

    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? oriImage = img.decodeImage(bytes);
      if (oriImage == null) return;

      img.Image resizedImage = img.copyResize(oriImage, width: 224, height: 224);

      var input = List.generate(
        1,
        (_) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) {
              final pixel = resizedImage.getPixel(x, y);
              return [
                pixel.r / 255.0,
                pixel.g / 255.0,
                pixel.b / 255.0,
              ];
            },
          ),
        ),
      );

      var output = List.filled(1 * _labels.length, 0.0).reshape([1, _labels.length]);
      _interpreter!.run(input, output);

      List<double> probabilities = List<double>.from(output[0]);
      int maxIndex = 0;
      double maxProb = probabilities[0];

      for (int i = 1; i < probabilities.length; i++) {
        if (probabilities[i] > maxProb) {
          maxProb = probabilities[i];
          maxIndex = i;
        }
      }

      setState(() {
        _confidence = maxProb * 100;
        // Threshold 55% untuk menolak gambar ngawur / bukan daun cabai
        if (_confidence < 55.0) {
          _isInvalidImage = true;
          _predictedLabel = null;
        } else {
          _isInvalidImage = false;
          _predictedLabel = _labels[maxIndex];
        }
        _isProcessing = false;
      });
    } catch (e) {
      debugPrint('Error klasifikasi: $e');
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final DiseaseInfo? resultInfo =
        _predictedLabel != null ? diseaseDatabase[_predictedLabel] : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Deteksi Daun Cabai',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: _isModelLoaded
                    ? const Color(0xFFE6F4EA)
                    : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isModelLoaded
                      ? const Color(0xFF1B7A43).withValues(alpha: 0.3)
                      : Colors.orange.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isModelLoaded ? Icons.check_circle : Icons.hourglass_top,
                    color: _isModelLoaded ? primaryColor : Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isModelLoaded
                        ? 'Model AI Siap Digunakan'
                        : 'Memuat Model AI...',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isModelLoaded ? primaryColor : Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada gambar daun dipilih',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ambil foto daun cabai secara dekat & jelas',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _isModelLoaded
                          ? () => _pickImage(ImageSource.camera)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text(
                        'Kamera',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _isModelLoaded
                          ? () => _pickImage(ImageSource.gallery)
                          : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.photo_library_rounded),
                      label: const Text(
                        'Galeri',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_isProcessing)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            if (!_isProcessing && _isInvalidImage) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
                    const SizedBox(height: 10),
                    const Text(
                      'Gambar Tidak Dikenali',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Objek yang diunggah tampaknya bukan daun cabai atau kualitas foto kurang jelas. Mohon unggah foto daun cabai yang valid.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.5, color: Color(0xFF334155)),
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedImage = null;
                          _isInvalidImage = false;
                        });
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Coba Foto Lain'),
                    ),
                  ],
                ),
              ),
            ],
            if (!_isProcessing && resultInfo != null && !_isInvalidImage) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: resultInfo.isHealthy
                        ? primaryColor.withValues(alpha: 0.4)
                        : Colors.orange.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: resultInfo.isHealthy
                                  ? const Color(0xFFE6F4EA)
                                  : Colors.orange.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              resultInfo.isHealthy
                                  ? Icons.check_circle_rounded
                                  : Icons.warning_amber_rounded,
                              color: resultInfo.isHealthy
                                  ? primaryColor
                                  : Colors.orange.shade700,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'HASIL DETEKSI',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            resultInfo.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: resultInfo.isHealthy
                                  ? primaryColor
                                  : const Color(0xFFB45309),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Tingkat Keyakinan: ${_confidence.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    _buildInfoSection(
                      icon: Icons.help_outline_rounded,
                      iconColor: Colors.red.shade600,
                      title: 'Penyebab',
                      content: resultInfo.cause,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.lightbulb_outline_rounded,
                      iconColor: Colors.amber.shade700,
                      title: 'Solusi Penanganan',
                      content: resultInfo.solution,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.format_list_numbered_rounded,
                            color: primaryColor, size: 22),
                        const SizedBox(width: 8),
                        const Text(
                          'Langkah Sederhana',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(resultInfo.simpleSteps.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                resultInfo.simpleSteps[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF334155),
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedImage = null;
                            _predictedLabel = null;
                          });
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text(
                          'Deteksi Gambar Lain',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3. HALAMAN ABOUT (TENTANG KELOMPOK - TANPA NIM)
// ============================================================================
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final groupMembers = [
      {
        'name': 'Muchamad Irham Maulana',
        'role': 'Ketua / Pengembang Aplikasi',
        'email':'irhammaulana324@gmail.com'
      },
      {
        'name': 'Qinaya Herawati',
        'role': 'Anggota Kelompok',
        'email':'qinayaherawati03@gmail.com'
      },
      {
        'name': 'Fatikah Abqoriyyah',
        'role': 'Anggota Kelompok',
        'email':'abqoriyyahf@gmail.com'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    child: Icon(Icons.eco_rounded, size: 40, color: primaryColor),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'CabiCare',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Versi 1.0.0 • MobileNetV2 TFLite',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Aplikasi pintar untuk membantu petani dan pegiat tanaman cabai mendeteksi penyakit daun secara cepat menggunakan kecerdasan buatan (Deep Learning) serta memberikan panduan solusi perawatan yang praktis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tim Pengembang (Kelompok)',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...groupMembers.map((member) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: primaryColor.withValues(alpha: 0.12),
                      child: Icon(Icons.person_rounded, color: primaryColor),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            member['role']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
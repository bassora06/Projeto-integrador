import 'package:flutter/material.dart';
import 'package:onbus/edit_record.dart';
import 'package:onbus/services/servRegistro.dart';
import 'l10n/app_localizations.dart';

class RegistrosPag extends StatefulWidget {
  const RegistrosPag({super.key});

  @override
  State<RegistrosPag> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RegistrosPag> {
  final RecordsService _service = RecordsService(); 
  List<Map<String, dynamic>> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  void _fetchRecords() async {
    setState(() => _isLoading = true);
    try {
      final fetchedRecords = await _service.getAllEnterprises();
      setState(() {
        _records = fetchedRecords;
      });
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.failedToFetchRecords)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: WaveClipper(reverse: true),
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 55, 39, 166),
                            Color.fromARGB(255, 40, 8, 58),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 15,
                            bottom: 15,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.edit_note,
                            size: 120,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Text(
                            l10n.records,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  '${l10n.totalRecords} ${_records.length}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),

                  // Lista de registros
                  _isLoading
                      ? const SizedBox.shrink() // Esconde a lista enquanto carrega
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _records.length,
                          itemBuilder: (context, index) {
                            final record = _records[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 8.0,
                              ),
                              child: ListTile(
                                title: Text(record['name'] ?? 'Empresa Sem Nome'),
                                subtitle: Text('ID: ${record['id']}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditRecord(
                                        enterpriseId: record['id'].toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
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

class WaveClipper extends CustomClipper<Path> {
  final bool reverse;

  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (reverse) {
      path.moveTo(0, size.height);
      path.quadraticBezierTo(
        size.width * 0.25,
        size.height - 30,
        size.width * 0.5,
        size.height - 20,
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        size.height - 10,
        size.width,
        size.height - 30,
      );
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.25, 30, size.width * 0.5, 20);
      path.quadraticBezierTo(size.width * 0.75, 10, size.width, 30);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
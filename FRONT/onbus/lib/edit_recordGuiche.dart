import 'package:flutter/material.dart';
import 'package:onbus/services/servGuiche.dart';
import 'l10n/app_localizations.dart';

class EditRecordGuiche extends StatefulWidget {
  final String guicheId; 

  const EditRecordGuiche({super.key, required this.guicheId}); 

  @override
  State<EditRecordGuiche> createState() => _EditRecordGuicheState();
}

class _EditRecordGuicheState extends State<EditRecordGuiche> {
  final GuicheService _service = GuicheService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();
    // A tela agora SEMPRE carrega dados, pois é apenas para edição.
    _loadGuicheData(widget.guicheId);
  }

  /// Carrega os dados do guichê usando o serviço
  void _loadGuicheData(String id) async {
    try {
      final guiche = await _service.getCounterById(id);
      _nameController.text = guiche['name'] ?? '';
      _emailController.text = guiche['email'] ?? '';
      _phoneController.text = guiche['phone'] ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar os dados: $e")),
      );
    } finally {
      if(mounted){
        setState(() => _isLoading = false);
      }
    }
  }

  /// ATUALIZA os dados do guichê
  void _updateGuiche() async {
    final l10n = AppLocalizations.of(context)!;

    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final ok = await _service.updateGuiche(widget.guicheId, {
        'name': _nameController.text,
        'email': _emailController.text,
        
      });

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.counterUpdatedSuccess)),
        );
         Navigator.pop(context);
      } else {
         throw Exception(l10n.recordUpdateFailed);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.recordUpdateFailed}: $e')),
      );
    } finally {
       if(mounted){
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Image.asset('lib/assets/images/fundo_Padrao.PNG', fit: BoxFit.fill),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 40, 0, 104)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Image.asset('lib/assets/images/onbus.png', height: 120, fit: BoxFit.contain),
                        const SizedBox(height: 20),
                        Text(
                          l10n.counterEdit,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 0, 104),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField(controller: _nameController, label: "Nome do Guichê", icon: Icons.storefront),
                        const SizedBox(height: 16),
                        _buildTextField(controller: _emailController, label: l10n.email, icon: Icons.email),
                        const SizedBox(height: 16),
                        _buildTextField(controller: _phoneController, label: l10n.phone, icon: Icons.phone),
                        const SizedBox(height: 40),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.symmetric(vertical: 24.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color.fromARGB(255, 30, 0, 161), Color.fromARGB(255, 40, 0, 104)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenSize.width * 0.8, 50),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 5,
                            ),
                            onPressed: _updateGuiche,
                            child: Text(
                              l10n.saveChanges,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 40, 0, 104)),
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 40, 0, 104)),
        filled: true,
        fillColor: const Color(0xffDBCFFA).withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
      style: const TextStyle(color: Color.fromARGB(255, 40, 0, 104)),
    );
  }
}
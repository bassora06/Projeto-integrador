import 'package:flutter/material.dart';
import 'package:onbus/services/servEmpresa.dart'; // Importando o serviço atualizado

class EditRecord extends StatefulWidget {
  final String? enterpriseId; // se vier preenchido, é edição; se não, é cadastro novo

  const EditRecord({super.key, this.enterpriseId});

  @override
  State<EditRecord> createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  // Service para comunicação com o back
  final EnterpriseService _service = EnterpriseService(); // Usando o serviço atualizado

  // Controllers dos campos
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;
  bool _isEditing = false; // controle pra diferenciar cadastro de edição

  @override
  void initState() {
    super.initState();

    if (widget.enterpriseId != null) {
      _isEditing = true;
      _loadEnterpriseData(widget.enterpriseId!);
    }
  }

  /// Carrega os dados da empresa usando o serviço
  void _loadEnterpriseData(String id) async {
    setState(() => _isLoading = true);

    // Lógica do back-end para carregar dados
    /*
    try {
      final enterprise = await _service.getEnterpriseById(id);
      _nameController.text = enterprise['name'] ?? '';
      _cnpjController.text = enterprise['cnpj'] ?? '';
      _emailController.text = enterprise['email'] ?? '';
      _phoneController.text = enterprise['phone'] ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao carregar os dados: $e"),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
    */
    // MOCK (pra você testar o front)
    await Future.delayed(const Duration(seconds: 1));
    _nameController.text = "Empresa Exemplo";
    _cnpjController.text = "12.345.678/0001-90";
    _emailController.text = "empresa@email.com";
    _phoneController.text = "(11) 91234-5678";

    setState(() => _isLoading = false);
  }

  /// Salvar ou atualizar no back
  void _saveEnterprise() async {
    if (_nameController.text.isEmpty ||
        _cnpjController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos obrigatórios.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Lógica do back-end para salvar ou atualizar
    /*
    try {
      if (_isEditing) {
        await _service.updateEnterprise(widget.enterpriseId!, {
          'name': _nameController.text,
          'cnpj': _cnpjController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? "Empresa atualizada com sucesso!" : "Empresa cadastrada com sucesso!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao salvar a empresa: $e"),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
    */
    // MOCK (pra você testar o front)
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEditing
            ? "Empresa atualizada com sucesso!"
            : "Empresa cadastrada com sucesso!"),
      ),
    );

    setState(() => _isLoading = false);

    Navigator.pop(context); // volta pra tela anterior
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Fundo com gradiente
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Image.asset(
                    'lib/assets/images/fundo_Padrao.PNG',
                    fit: BoxFit.fill,
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Botão Voltar
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Color.fromARGB(255, 40, 0, 104)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Logo
                        Image.asset(
                          'lib/assets/images/onbus.png',
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),

                        // Título
                        Text(
                          _isEditing
                              ? "Editar Empresa"
                              : "Cadastrar Empresa",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 0, 104),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Campos
                        _buildTextField(
                            controller: _nameController,
                            label: "Nome da Empresa",
                            icon: Icons.business),
                        const SizedBox(height: 16),

                        _buildTextField(
                            controller: _cnpjController,
                            label: "CNPJ",
                            icon: Icons.badge),
                        const SizedBox(height: 16),

                        _buildTextField(
                            controller: _emailController,
                            label: "Email",
                            icon: Icons.email),
                        const SizedBox(height: 16),

                        _buildTextField(
                            controller: _phoneController,
                            label: "Telefone",
                            icon: Icons.phone),
                        const SizedBox(height: 40),
                      
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.symmetric(vertical: 24.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 30, 0, 161),
                                Color.fromARGB(255, 40, 0, 104),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenSize.width * 0.8, 50),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            onPressed: _saveEnterprise,
                            child: Text(
                              _isEditing
                                  ? "SALVAR ALTERAÇÕES"
                                  : "CADASTRAR",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
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
    _cnpjController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /// Função helper para criar os textfields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color.fromARGB(255, 40, 0, 104)),
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 40, 0, 104)),
        filled: true,
        fillColor: Color(0xffDBCFFA).withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Color.fromARGB(255, 40, 0, 104)),
    );
  }
}
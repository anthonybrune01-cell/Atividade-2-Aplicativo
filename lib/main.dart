import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

/// 🎨 CORES DO APP
class AppColors {
  static const cream = Color(0xFFFEFAE0);
  static const primaryGreen = Color(0xFF4B5320);
  static const secondaryGreen = Color(0xFF676F53);
  static const textDark = Color(0xFF1B1B1B);
  static const cardBorder = Color(0x33000000);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      textTheme: GoogleFonts.darkerGrotesqueTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.secondaryGreen,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: base,
      home: const LoginPage(),
    );
  }
}

/// 📄 TELA DE LOGIN
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool carregando = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> entrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => carregando = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => carregando = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login realizado com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🔐 TÍTULO
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.lock, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Entrar",
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 📧 EMAIL
                    TextFormField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Digite seu e-mail";
                        }
                        if (!v.contains("@")) {
                          return "E-mail inválido";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    /// 🔑 SENHA
                    TextFormField(
                      controller: senhaCtrl,
                      obscureText: esconderSenha,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(esconderSenha
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              esconderSenha = !esconderSenha;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Digite sua senha";
                        }
                        if (v.length < 4) {
                          return "Senha muito curta";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    /// 🔗 ESQUECI SENHA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Recuperação de senha")),
                          );
                        },
                        child: const Text("Esqueci minha senha"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// 🚀 BOTÃO
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: carregando ? null : entrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: carregando
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 👤 CADASTRO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Não tem conta? "),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Criar conta"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
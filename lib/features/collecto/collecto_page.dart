import 'package:flutter/material.dart';
import '../../shared/layout/navbar.dart';
import '../../shared/layout/footer.dart';

class CollectoPage extends StatelessWidget {
  const CollectoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            SizedBox(height: 100),
            Center(child: Text("Collecto Page Content Coming Soon")),
            SizedBox(height: 100),
            Footer(),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/firestore.dart';
import 'package:test/stateManager/stateManager.dart';

class Code extends StatefulWidget {
  Code({super.key});

  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stateManager = Provider.of<StateManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50.0),
            CodeAddSection(codeController: codeController),
            const SizedBox(height: 20.0),
            if (stateManager.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  stateManager.errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            SubmitButton(
              stateManager: stateManager,
              codeController: codeController,
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListViewDetails(firestoreService: firestoreService),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewDetails extends StatelessWidget {
  const ListViewDetails({
    super.key,
    required this.firestoreService,
  });

  final FirestoreService firestoreService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: StreamBuilder(
        stream: firestoreService.getCodes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> codeList = snapshot.data!.docs;
            print('Code list: $codeList'); // Debug print

            return ListView.builder(
              itemCount: codeList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = codeList[index];
                String docID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String noteText =
                    data['name'] ?? 'No Code Found'; // Corrected field name

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      trailing: GestureDetector(
                        onTap: () => firestoreService.deleteCode(docID),
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.orange,
                        ),
                      ),
                      title: Text(
                        noteText,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error loading codes");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.stateManager,
    required this.codeController,
  });

  final StateManager stateManager;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        await stateManager.submitCode(codeController.text);
        if (!stateManager.isLoading && stateManager.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Code submitted successfully!'),
            ),
          );
        }
        codeController.clear();
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.orange.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: stateManager.isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
        ),
      ),
    );
  }
}

class CodeAddSection extends StatelessWidget {
  const CodeAddSection({
    super.key,
    required this.codeController,
  });

  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: codeController,
      decoration: InputDecoration(
        labelText: "Enter Your Code",
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.orange.shade900),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.orange.shade900),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/firestore.dart';
import 'package:test/stateManager/stateManager.dart';

class EssentialCare extends StatelessWidget {
  EssentialCare({super.key});
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController hydrationController = TextEditingController();
  final TextEditingController nutritionController = TextEditingController();
  final TextEditingController reconstructionController =
      TextEditingController();
  final TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stateManager = Provider.of<StateManager>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Essential Care', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              ProductTextField(
                labelText: 'Hydration Product Name',
                textEditingController: hydrationController,
              ),
              SizedBox(height: 20.0),
              ProductTextField(
                labelText: 'Nutrition Product Name',
                textEditingController: nutritionController,
              ),
              SizedBox(height: 20.0),
              ProductTextField(
                labelText: 'Reconstruction Product Name',
                textEditingController: reconstructionController,
              ),
              SizedBox(height: 20.0),
              ProductTextField(
                labelText: 'Total',
                textEditingController: totalController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SubmitButton(
                  stateManager: stateManager,
                  hydrationController: hydrationController,
                  nutritionController: nutritionController,
                  reconstructionController: reconstructionController,
                  totalController: totalController,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // Adjust height as needed
                child: ListViewDetails(firestoreService: firestoreService),
              ),
            ],
          ),
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
    return StreamBuilder(
      stream: firestoreService.getEssentialCare(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List essentialCareList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: essentialCareList.length, // Ensure itemCount is set
            itemBuilder: (context, index) {
              DocumentSnapshot documents = essentialCareList[index];
              String docID = documents.id;
              Map<String, dynamic> data =
                  documents.data() as Map<String, dynamic>;

              String hydrationName = '${data['hName']}';
              String nutrationName = '${data['nName']}';
              String reconstructName = '${data['rName']}';
              String total = '${data['total']}';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    trailing: GestureDetector(
                      onTap: () => firestoreService.deleteEssentialCare(docID),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.orange,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hydrationName,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Divider(),
                        Text(
                          nutrationName,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Divider(),
                        Text(
                          reconstructName,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Divider(),
                        Text(
                          total,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Text("No Product Found");
        }
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.stateManager,
    required this.hydrationController,
    required this.nutritionController,
    required this.reconstructionController,
    required this.totalController,
  });

  final StateManager stateManager;
  final TextEditingController hydrationController;
  final TextEditingController nutritionController;
  final TextEditingController reconstructionController;
  final TextEditingController totalController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Unfocus the TextField to dismiss the keyboard
        FocusScope.of(context).unfocus();

        // Call submitEssentialCare method from StateManager
        await stateManager.submitEssentialCare(
          hydrationController.text,
          nutritionController.text,
          reconstructionController.text,
          totalController.text,
        );

        if (!stateManager.isLoading && stateManager.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Essential Care submitted successfully!'),
            ),
          );
        }
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

class ProductTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  const ProductTextField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
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
        focusColor: Colors.orange.shade900,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.orange.shade900),
        ),
      ),
    );
  }
}

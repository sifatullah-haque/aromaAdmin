import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/firestore.dart';
import 'package:test/stateManager/stateManager.dart';

class Products extends StatelessWidget {
  Products({super.key});
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController eANController = TextEditingController();
  final TextEditingController classificationsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stateManager = Provider.of<StateManager>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Product Page', style: TextStyle(color: Colors.white)),
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
              const SizedBox(height: 20.0),
              ProductTextField(
                lebelText: 'Enter Product Name',
                textEditingController: nameController,
              ),
              const SizedBox(height: 20.0),
              ProductTextField(
                lebelText: 'Enter EAN',
                textEditingController: eANController,
              ),
              const SizedBox(height: 20.0),
              ProductTextField(
                lebelText: 'Enter Classification',
                textEditingController: classificationsController,
              ),
              const SizedBox(height: 20.0),
              SubmitButton(
                  stateManager: stateManager,
                  nameController: nameController,
                  eANController: eANController,
                  classificationsController: classificationsController),
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
      stream: firestoreService.getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List productList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: productList.length, // Ensure itemCount is set
            itemBuilder: (context, index) {
              DocumentSnapshot documents = productList[index];
              String docID = documents.id;
              Map<String, dynamic> data =
                  documents.data() as Map<String, dynamic>;

              String productNameText = '${data['name']}';
              String productEANText = '${data['Ean']}';
              String productClassificationsText = '${data['classifications']}';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                      trailing: GestureDetector(
                        onTap: () => firestoreService.deleteProduct(docID),
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.orange,
                        ),
                      ),
                      title: Text(
                        productNameText,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productClassificationsText,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            productEANText,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
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
    required this.nameController,
    required this.eANController,
    required this.classificationsController,
  });

  final StateManager stateManager;
  final TextEditingController nameController;
  final TextEditingController eANController;
  final TextEditingController classificationsController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Unfocus the TextField to dismiss the keyboard
        FocusScope.of(context).unfocus();

        // Call submitCode method from StateManager
        await stateManager.submitProduct(nameController.text,
            eANController.text, classificationsController.text);

        if (!stateManager.isLoading && stateManager.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Product submitted successfully!'),
            ),
          );
        }
        nameController.clear();
        eANController.clear();
        classificationsController.clear();
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
  final String lebelText;
  final TextEditingController textEditingController;

  const ProductTextField({
    super.key,
    required this.lebelText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: lebelText,
        labelStyle: TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
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

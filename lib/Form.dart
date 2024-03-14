import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  PageController _pageController = PageController();
  String _aadhaarNumber = '';
  String _panNumber = '';
  XFile? _aadhaarFrontPhoto;
  XFile? _aadhaarBackPhoto;
  XFile? _panFrontPhoto;
  XFile? _panBackPhoto;
  XFile? _digitalSign;
  XFile? _selfPhoto;
  bool _consentGiven = false;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _dateOfBirthController =
      TextEditingController(); // Controller for the date of birth

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the page controller
    _dateOfBirthController.dispose(); // Dispose the controller
    super.dispose();
  }

  Future<void> _pickImage(
      ImageSource source, void Function(XFile?) onImageSelected) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        onImageSelected(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 6, 27, 1),
      appBar: AppBar(
        title: Text('KYC Form', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(3, 18, 42, 1),
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildPage1(),
            _buildPage2(),
            _buildPage3(),
            _buildPage4(),
            _buildPage5(),
            _buildPage6(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(0, 6, 27, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                if (_pageController.page!.toInt() > 0) {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Colors.white,
              onPressed: () {
                if (_pageController.page!.toInt() < 5) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Aadhaar Card Number',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
            onSaved: (value) => _aadhaarNumber = value!,
          ),
          SizedBox(height: 20),
          _buildPhotoSection(
              'Aadhaar Card Front Photo:',
              _aadhaarFrontPhoto,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _aadhaarFrontPhoto = xfile)),
        ],
      ),
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPhotoSection(
              'Aadhaar Card Back Photo:',
              _aadhaarBackPhoto,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _aadhaarBackPhoto = xfile)),
          SizedBox(height: 20),
          CheckboxListTile(
            title: Text(
              "I hereby agree that the above document belongs to me and voluntarily give my consent to [company name] to utilize it as my address proof for KYC purpose only",
              style: TextStyle(color: Colors.white),
            ),
            value: _consentGiven,
            onChanged: (bool? value) {
              setState(() {
                _consentGiven = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.blue,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildPage3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'PAN Card Number',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
            onSaved: (value) => _panNumber = value!,
          ),
          SizedBox(height: 20),
          _buildPhotoSection(
              'PAN Card Front Photo:',
              _panFrontPhoto,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _panFrontPhoto = xfile)),
        ],
      ),
    );
  }

  Widget _buildPage4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPhotoSection(
              'PAN Card Back Photo:',
              _panBackPhoto,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _panBackPhoto = xfile)),
        ],
      ),
    );
  }

  Widget _buildPage5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPhotoSection(
              'Digital Signature',
              _digitalSign,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _digitalSign = xfile)),
        ],
      ),
    );
  }

  Widget _buildPage6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPhotoSection(
              'Your Photo:',
              _selfPhoto,
              () => _pickImage(
                  ImageSource.camera, (xfile) => _selfPhoto = xfile)),
          SizedBox(height: 20),
          TextFormField(
            controller: _dateOfBirthController,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
            readOnly: true, // Prevent manual editing
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  _dateOfBirthController.text =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(
      String title, XFile? photo, VoidCallback onImagePick) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(height: 10),
        InkWell(
          onTap: onImagePick,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: photo != null
                ? Image.file(File(photo.path), fit: BoxFit.cover)
                : Icon(Icons.camera_alt, size: 50, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

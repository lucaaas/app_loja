import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _imageUrlFocus = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();

  void _updateImage() {
    setState(() {});
  }

  @override
  void dispose() async {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
  }

  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_priceFocus),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_descriptionFocus),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocus,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Url da imagem'),
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

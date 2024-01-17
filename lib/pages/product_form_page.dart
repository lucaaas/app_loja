import 'package:app_loja/models/product.dart';
import 'package:app_loja/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = <String, Object>{};

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

  void _submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    final Product product = Product(
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.addProduct(product);

    Navigator.of(context).pop();
  }

  String? validateRequiredTextField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.trim().length < 3) {
      return 'Campo precisa ter no mínimo 3 letras';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (String? name) => _formData['name'] = name ?? '',
                validator: validateRequiredTextField,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_descriptionFocus),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocus,
                onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
                validator: (String? value) {
                  final double price = double.parse(value ?? '0');
                  if (price <= 0) {
                    return 'O preço deve ser maior que 0';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) => _formData['description'] = description ?? '',
                validator: validateRequiredTextField,
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
                      onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      onFieldSubmitted: (_) => _submitForm(),
                      validator: validateRequiredTextField,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a url')
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

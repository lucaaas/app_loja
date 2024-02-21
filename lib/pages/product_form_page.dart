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

  bool _isLoading = false;

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

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final Product product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  void _submitForm() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();

    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);

    try {
      await productProvider.saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text('Ocorreu um erro ao salvar o produto.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok')),
          ],
        ),
      );
    }

    setState(() => _isLoading = false);
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      initialValue: _formData['name']?.toString(),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_priceFocus),
                      onSaved: (String? name) => _formData['name'] = name ?? '',
                      validator: validateRequiredTextField,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Preço'),
                      initialValue: _formData['price']?.toString(),
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
                      initialValue: _formData['description']?.toString(),
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
                              : SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(_imageUrlController.text),
                                  ),
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

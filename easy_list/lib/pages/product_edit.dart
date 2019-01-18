import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped_models/products.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;
  final Map formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        formData['title'] = value;
      },
      decoration: InputDecoration(labelText: 'Product title'),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.description,
      maxLines: 3,
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Title is required and should be 10+ characters long.';
        }
      },
      onSaved: (String desc) {
        formData['description'] = desc;
      },
      decoration: InputDecoration(labelText: 'Product description'),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      initialValue:
          product == null ? '' : product.price.toString(),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:[.]\d+)?$').hasMatch(value)) {
          return 'Title is required and should be a valid number.';
        }
      },
      onSaved: (String price) {
        formData['price'] = double.parse(price);
      },
      decoration: InputDecoration(labelText: 'Product price'),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, [int selectedProductIndex]) {
    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    Product productData = Product(
        title: formData['title'],
        description: formData['description'],
        price: formData['price'],
        image: formData['image']);

    if (selectedProductIndex == null) {
      addProduct(productData);
    } else {
      updateProduct(productData);
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  Widget _buildSubmitButton(ProductsModel model) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
      child: Text('Save'),
    );
  }

  Widget _builPageContent(BuildContext context, ProductsModel model) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 600 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final product = model.selectedProduct;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
              FocusNode()); //close the keyboard when we tap outside of input fields of the form.
        },
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding),
                  children: <Widget>[
                    _buildTitleTextField(product),
                    Text(titleValue),
                    _buildDescriptionTextField(product),
                    _buildPriceTextField(product),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSubmitButton(model)
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        final Widget pageContent = _builPageContent(context, model);

        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(title: Text('Edit Product')), body: pageContent);
      },
    );
  }
}
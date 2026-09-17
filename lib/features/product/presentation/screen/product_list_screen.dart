import 'package:code/core/route/app_routes.dart';
import 'package:code/features/detail/detail_screen.dart';
import 'package:code/features/product/data/model/product_model.dart';
import 'package:code/features/product/presentation/bloc/product_bloc.dart';
import 'package:code/features/product/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductListScreen extends StatefulWidget {
  final String productName;
  const ProductListScreen({super.key,required this.productName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme=Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title:Text(widget.productName)),
      body:BlocBuilder<ProductBloc,ProductState>(builder: (context,state){
        if(state is ProductLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is ProductError){
           return Center(
             child: Text(state.message,style: TextStyle(color: colorScheme.onSurface),),
           );
        }
        if(state is ProductSuccess){
          if(state.productList.isEmpty){
            return Center(
              child: Text('product not found'),
            );
          }
          return ListView.builder(
            itemCount: state.productList.length,
              itemBuilder: (context,index){
            final product=state.productList[index];
            print("product:${product.name}");
            return _productCard(context, product);

          });
        }
        return SizedBox();
      }),
    );
  }
}
Widget _productCard(
    BuildContext context,
    ProductModel product,
    ) {

  final colorScheme =
      Theme.of(context).colorScheme;

  return Card(
    margin: const EdgeInsets.only(bottom: 12),

    color: colorScheme.surface,

    child: ListTile(
      contentPadding:
      const EdgeInsets.all(10),

      leading: ClipRRect(
        borderRadius:
        BorderRadius.circular(10),

        child: Image.network(
          product.image,
          width: 65,
          height: 65,
          fit: BoxFit.cover,
        ),
      ),

      title: Text(
        product.name,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        product.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: Text(
        'Rs. ${product.price}',
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context,AppRoutes.detail,arguments: product);
        // Navigator.push(context, MaterialPageRoute(builder: (_){
        //   return DetailScreen(productModel: product);
        // }));
      },
    ),
  );
}
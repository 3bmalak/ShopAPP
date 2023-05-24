import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import 'package:shopapp/Shared/Components/Component.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/categories_Model.dart';
import '../../../Layout/Shop_APP/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        bool? b;
        ShopAppCubit cubit = ShopAppCubit.get(context);
        if (cubit.categoriesModel == null) {
          b = true;
        }
        else
          b = false;
        return b ? Center(child: CircularProgressIndicator()) :ListView.separated(
          itemBuilder: (context, index) => buildCatIteam(
              ShopAppCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatIteam(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.imageCategorie}'),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '${model.nameCategorie}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward,
        )
      ],
    ),
  );
}
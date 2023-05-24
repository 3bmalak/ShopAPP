import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import 'package:shopapp/Shared/Components/Component.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Favorites_Model.dart';



class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {

      },
    builder: (context, state) {
      bool? b;
      ShopAppCubit cubit = ShopAppCubit.get(context);
      if (cubit.favoritesModel == null) {
        b = true;
      }
      else
        b = false;
    return b?   Center(child: Text("No Items",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),)) :
    ListView.separated(itemBuilder: (context, index) => buildFavorite(ShopAppCubit.get(context).favoritesModel!.data.data[index],context) ,
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: ShopAppCubit.get(context).favoritesModel!.data.data.length
    );
    },
    );
  }
  Widget buildFavorite(FavouriteData model,context)=> Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(

                image: NetworkImage(
                 '${model.product!.image.toString()}',
                ),
                width: 120.0,
                height: 120.0,
                // fit: BoxFit.cover,
              ),
              // if (model.discount.toString() != '0')
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
          SizedBox( width:  8.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                     'p${model.product!.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    // if (model.discount != 0)
                      Text(
                       '${model.product!.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 10.0,
                          height: 1.3,
                          color: Colors.grey,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavouritesState(model.product!.id);
                        },
                        icon:
                        Icon(

                          Icons.favorite,
                          size: 18.0,
                          color: ShopAppCubit.get(context).favorites[model.product!.id]? Colors.red:Colors.grey,
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import 'package:shopapp/Shared/Components/Component.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Home_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/categories_Model.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoritesState){
        if(!state.changeFavoritesModel.status)
          {
            toast(
                message: state.changeFavoritesModel.message.toString(),
                color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        bool? b;
        ShopAppCubit cubit = ShopAppCubit.get(context);
        if (cubit.homeModel == null) {
          b = true;
        }
        else
          b = false;

        return b ? Center(child: CircularProgressIndicator()) :
        productsBuilder
          (cubit.homeModel,
            cubit.categoriesModel,context
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categorieModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) =>
                    Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                height: 220,
                initialPage: 0,
                aspectRatio: 16/9,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Janna'),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCategorieItem(
                              categorieModel!.data!.data![index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            width: 10,
                          ),
                      itemCount: categorieModel!.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Janna',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                  model.data!.products.length,
                      (index) =>
                      buildGridPorduct(
                        model.data!.products[index],context
                      ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategorieItem(DataModel model) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [

          Image(
            image: NetworkImage(model.imageCategorie.toString()),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text(
              '${model.nameCategorie}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            color: Colors.black.withOpacity(0.8),
            width: 100,
          ),
        ],
      );

  Widget buildGridPorduct(ProductsModel model,context) {

  var cubit=ShopAppCubit.get(context).favorites;


 return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0,),
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image.toString(),
                  ),
                  width: double.infinity,
                  height: 180.0,
                ),
                if (model.discount.toString() != '0')
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
            Padding(
              padding: const EdgeInsets.all(
                10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),


                  Row(
                    children: [
                      Text(
                        model.price.round().toString() + ' EP',
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
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.round().toString() + ' EP',
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
                          ShopAppCubit.get(context).changeFavouritesState(model.id);
                        },
                        icon:
                        Icon(
                        Icons.favorite,
                        size: 18.0,
                          color:  cubit[model.id] ?Colors.red: Colors.grey,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );}
}
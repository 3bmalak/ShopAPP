
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import '../../Modules/Shop_APP_Screens/login/Shop_Login_Screen.dart';
import '../Network/local/cache_Helper.dart';

Widget DefaultButton(
    {
      double width=double.infinity,
      Color Background=Colors.blue,
      required String text,
      required VoidCallback function,
      var fontcolor=Colors.white,

    })=> Container(
          width: width,
          color: Background,
          child:
              MaterialButton(
                  onPressed: function,
                  child: Text(
                    '$text',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: fontcolor,
                      fontWeight:FontWeight.bold,

),
),
),
);

Widget DefaultTFF(
    {
  required TextEditingController Controller,
  required TextInputType Keyboard,
  ValueChanged<String>? OnSubmit,
  ValueChanged<String>? OnChange,
  required FormFieldValidator<String> Validate,
  required IconData PrefixIcon,
  IconData? SufffixIcon ,
  required String Label,
  VoidCallback? SuffixFunction,
  bool IsPassword=false,
  GestureTapCallback? onTap,
  bool onChecked=true
})=>TextFormField(
  controller: Controller ,
  keyboardType:Keyboard,
  onFieldSubmitted: OnSubmit,
  onChanged: OnChange,
  validator: Validate,
  obscureText: IsPassword,
  onTap: onTap,
  enabled: onChecked,
  decoration: InputDecoration(
    labelText: Label,
    prefixIcon: Icon(PrefixIcon),
    suffixIcon:  IconButton(
      onPressed: SuffixFunction
      , icon: Icon(SufffixIcon)
    ),

    border:OutlineInputBorder(

    ),
  ),
);

Widget BuildArticleItem(data,context,)=>Padding(

  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 120.0,
        width: 120.0,

        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image:  NetworkImage('${data['urlToImage']}'),

              fit: BoxFit.cover,

            )

        ),

      ),

      SizedBox(

        width: 20.0,),

      Expanded(

        child: Container(

          height: 120.0,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [



              Expanded(

                child: Text('${data['title']} ',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Text('${data['publishedAt']}',
                maxLines: 3,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget MyDivider()=>Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

void navigatorTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder:(context) =>  widget,)
);

void navigatorAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(builder:(context) =>  widget,),
      (route)=>false
);



void toast({
  required String message,
  required Color color,

}) => Fluttertoast.showToast(
msg: message,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor:color,
textColor: Colors.white,
fontSize: 16.0,
);

void SignOut( context)
{
  CacheHelper.SaveData(key: 'token', value: '').then((value) {
    if(value){
      navigatorAndFinish(context, ShopLoginScreen());
      ShopAppCubit.get(context).CurrentIndix=0;
      ShopAppCubit.get(context).changeScreen(indix: 0);
    }
  });
}
void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}


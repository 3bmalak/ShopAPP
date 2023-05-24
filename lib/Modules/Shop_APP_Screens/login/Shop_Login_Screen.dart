
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import 'package:shopapp/Modules/Shop_APP_Screens/Register/Shop_Register_Screen.dart';
import '../../../Layout/Shop_APP/Shop_Layout.dart';
import '../../../Shared/Components/Component.dart';
import '../../../Shared/Network/End_Points/end_points.dart';
import '../../../Shared/Network/local/cache_Helper.dart';
import 'cubit/Shop_Login_State.dart';
import 'cubit/Shop_Login_Cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';




class ShopLoginScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    bool Loading=false;


    return BlocProvider(
      create: (context) => ShopLoginCubit(),


      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginLoadingState)
          {
          Loading=true;
          }
          else {
            Loading = false;
          }

          if(state is ShopLoginSuccessedtState)
          {
            if(state.loginModel.status){

              print(state.loginModel.message);
              print(state.loginModel.status);
              print(state.loginModel.data!.token);
             toast(message: state.loginModel.message, color: Colors.green);
             CacheHelper.SaveData(key: 'token', value:state.loginModel.data!.token ).
             then((value) {
               token=state.loginModel.data!.token;
               ShopAppCubit.get(context).getHomeData();
               ShopAppCubit.get(context).getCategoryData();
               ShopAppCubit.get(context).getFavoritesData();
               ShopAppCubit.get(context).getProfileData();
               navigatorAndFinish(context, ShopLayout());
             });

            }
            else
            { print(state.loginModel.message);

              toast(message: state.loginModel.message, color: Colors.red);
            }
          }
        },
        builder: (context, state) {

          var cubit=ShopLoginCubit.get(context);
          var formKey =GlobalKey<FormState>();

          return
            Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOGIN',style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black,),),
                          SizedBox(height: 40.0,),
                          DefaultTFF(
                            Controller: emailController,
                            Keyboard: TextInputType.emailAddress,
                            Validate: (value) {
                              bool at=false;
                              if(value!.isEmpty){
                                return 'Email Address must not be empty';
                              }
                            },
                            PrefixIcon: Icons.email_outlined,
                            Label: 'Email Address',
                          ),
                          SizedBox(height: 30.0,),

                          DefaultTFF(
                            IsPassword: cubit.isPasswordIconChecked,
                            Controller: passwordController,
                            Keyboard: TextInputType.visiblePassword,
                            OnSubmit: (value) {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password:passwordController.text
                                );
                              }
                            },
                            Validate: (value) {
                              if(value!.isEmpty){
                                return 'Password must not be empty';
                              }
                            },
                            PrefixIcon: Icons.lock,
                            Label: 'Password',
                            SufffixIcon: cubit.isPasswordIconChecked ? Icons.remove_red_eye:Icons.visibility_off_sharp,
                            SuffixFunction: ()
                            {
                              print(cubit.isPasswordIconChecked);
                              cubit.ChangePasswordVisability();
                            },

                          ),
                          SizedBox(height: 30.0,),

                          Loading? Center(child: CircularProgressIndicator()):DefaultButton(
                            text: "LOGIN",
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password:passwordController.text
                                );
                              }
                            },
                          ),

                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text('Don\'t have account?' ),
                              TextButton(
                                child: Text('REGISTER',style: TextStyle(fontSize: 18.0),),
                                onPressed: () {
                                  navigatorTo(context, RegisterScreen());
                                },)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}

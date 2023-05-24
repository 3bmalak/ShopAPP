
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../Layout/Shop_APP/Shop_Layout.dart';
import '../../../Shared/Components/Component.dart';
import '../../../Shared/Network/End_Points/end_points.dart';
import '../../../Shared/Network/local/cache_Helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cubit/Cubit.dart';
import 'cubit/State.dart';




class RegisterScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var phoneController=TextEditingController();
    var nameController=TextEditingController();
    bool Loading=false;


    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context, state) {
            if(state is ShopRegisterLoadingState)
            {
              Loading=true;
            }
            else {
              Loading = false;
            }

            if(state is ShopRegisterSuccessedtState)
            {
              // state.loginModel.data.
              if(state.loginModel.status){
                print('fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');

                toast(message: state.loginModel.message, color: Colors.green);
                CacheHelper.SaveData(key: 'token', value:state.loginModel.data!.token ).
                then((value) {
                  token=state.loginModel.data!.token;
                  navigatorAndFinish(context, ShopLayout());
                });

              }
              else
              {
                print('fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');

              print(state.loginModel.message);

              toast(message: state.loginModel.message, color: Colors.red);
              }
            }
          },
          builder: (context, state) {

            var cubit=ShopRegisterCubit.get(context);
            var formKey =GlobalKey<FormState>();

            return Scaffold(
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
                            Text('Register',
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black,),),
                            SizedBox(height: 40.0,),
                            DefaultTFF(
                              Controller: nameController,
                              Keyboard: TextInputType.name,
                              Validate: (value) {
                                bool at=false;
                                if(value!.isEmpty){
                                  return 'Name Address must not be empty';
                                }
                              },
                              PrefixIcon: Icons.email_outlined,
                              Label: 'Name Address',
                            ),
                            SizedBox(height: 30.0,),
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
                              Controller: phoneController,
                              Keyboard: TextInputType.phone,
                              Validate: (value) {
                                bool at=false;
                                if(value!.isEmpty){
                                  return 'phone Address must not be empty';
                                }
                              },
                              PrefixIcon: Icons.phone,
                              Label: 'phone',
                            ),
                            SizedBox(height: 30.0,),

                            DefaultTFF(
                              IsPassword: cubit.isPasswordIconChecked,
                              Controller: passwordController,
                              Keyboard: TextInputType.visiblePassword,
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
                              text: "REGISTER",
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
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
                                Text('Already have an account' ),
                                TextButton(
                                  child: Text('Login',style: TextStyle(fontSize: 18.0),),
                                  onPressed: () {
                                    Navigator.pop(context);
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

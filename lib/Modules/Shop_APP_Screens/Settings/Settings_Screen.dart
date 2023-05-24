import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import 'package:shopapp/Shared/Components/Component.dart';


class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    bool? b;
    ShopAppCubit c = ShopAppCubit.get(context);
    if (c.profilemodel == null)
    {
      b = true;
    }
    else
      b = false;

    return b ? Center(child: CircularProgressIndicator()) :BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model=ShopAppCubit.get(context).profilemodel;
          if(model!.data != null) {
            nameController.text = model.data!.name;
            emailController.text = model.data!.email;
            phoneController.text = model.data!.phone;
          }
          else{
          }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey=GlobalKey<FormState>(),
            child: Column(
              children: [
                DefaultTFF(
                    Controller: nameController,
                    Keyboard: TextInputType.name,
                    Validate: (value) {
                      if (value!.isEmpty){
                        return 'name must be not empty';
                      }
                    },
                    PrefixIcon: Icons.person,
                    Label: 'name'
                ),
                SizedBox(height: 15.0,),
                DefaultTFF(
                    Controller: emailController,
                    Keyboard: TextInputType.emailAddress,
                    Validate: (value) {
                      if (value!.isEmpty){
                        return 'email must be not empty';
                      }
                    },
                    PrefixIcon: Icons.email,
                    Label: 'email'
                ),
                SizedBox(height: 15.0,),
                DefaultTFF(
                    Controller: phoneController,
                    Keyboard: TextInputType.phone,
                    Validate: (value) {
                      if (value!.isEmpty){
                        return 'phone must be not empty';
                      }
                    },
                    PrefixIcon: Icons.phone,
                    Label: 'phone'
                ),
                SizedBox(height: 20.0,),
                DefaultButton(
                    text: " UPDATE",
                    function: () {
                   if(formKey.currentState!.validate()){
                     ShopAppCubit.get(context).updateProfileData
                       (
                         updateName: nameController.text,
                         updateEmail: emailController.text,
                         updatePhone: phoneController.text
                     );
                     ShopAppCubit.get(context).getProfileData();
                      }
                    }
                ),
                SizedBox(height: 15.0,),
                DefaultButton(
                    text: "LOGOUT",
                    function: () {
                      SignOut(context);
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

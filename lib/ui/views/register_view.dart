import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';


class RegisterView extends StatelessWidget {
  const RegisterView ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider(
        create: ( _ ) => RegisterFormProvider(),
        child: Builder(
          builder: (context) {
            final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
            return Container(
              margin: const EdgeInsets.only( top: 100 ),
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 370),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: registerFormProvider.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle( color: Colors.white,),
                          decoration: CustomInputs.loginInputDecoration(
                            hint: 'Enter name',
                            label: 'Name',
                            icon: Icons.supervised_user_circle_sharp
                          ),
                          validator: (value) {
                            if( value == null || value.isEmpty ) return 'Name is required';
                            if( value.length < 3 ) return 'Enter min 3 characters';
                            return null;
                          },
                          onChanged: (value) => registerFormProvider.name = value,
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          style: const TextStyle( color: Colors.white,),
                          decoration: CustomInputs.loginInputDecoration(
                            hint: 'Enter Email',
                            label: 'Email',
                            icon: Icons.email_outlined
                          ),
                          validator: (value) {
                            if ( !EmailValidator.validate( value ?? '')) return 'Invalid email';
                            return null;
                          },
                          onChanged: (value) => registerFormProvider.email = value,
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle( color: Colors.white,),
                          decoration: CustomInputs.loginInputDecoration (
                            hint: '***************',
                            label: 'Password',
                            icon: Icons.email_outlined
                          ),
                          validator: (value) {
                            if( value == null || value.isEmpty ) return 'Password is required';
                            if( value.length < 6 ) return 'Enter min 6 characters';
                            return null;
                          },
                          onChanged: (value) => registerFormProvider.password = value,
                        ),
                        const SizedBox(height: 20,),
                        CustomOutlineButton(
                          onPressed: (){
                            final isValidForm =  registerFormProvider.validateForm();
                            if( !isValidForm ) return;
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            authProvider.register(
                              registerFormProvider.name, 
                              registerFormProvider.email, 
                              registerFormProvider.password
                            );
                          }, 
                          text: 'Create account'
                        ),
                        const SizedBox(height: 20,),
                        LinkText(
                          text: 'Log in',
                          onPressed: (){
                             Navigator.pushReplacementNamed( context, CustomFluroRouter.loginRoute);
                          },
                        )
                      ],
                    )
                  ),
                )
              ),
            );
          }
        ),
      ),
    );
  }
}
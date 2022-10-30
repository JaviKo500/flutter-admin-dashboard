import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';



class LoginView extends StatelessWidget {
  const LoginView ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: ( _ ) => LoginFormProvider( ),
      child: Builder(
        builder:  ( context ) {
          final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
          return Container(
            margin: const EdgeInsets.only( top: 100 ),
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: loginFormProvider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle( color: Colors.white,),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Enter Email',
                          label: 'Email',
                          icon: Icons.email_outlined
                        ),
                        validator: (value) {
                          if( !EmailValidator.validate( value ?? '') ) return 'Invalid email';
                          return null;
                        },
                        onChanged: (value) => loginFormProvider.email =  value,
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle( color: Colors.white,),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: '***************',
                          label: 'Password',
                          icon: Icons.lock
                        ),
                        validator: (value) {
                          if ( value == null || value.isEmpty ) return 'Password is required';
                          if ( value.length < 6 ) return 'Enter min 6 characters';
                          return null;
                        },
                        onChanged: (value) => loginFormProvider.password = value,
                      ),
                      const SizedBox(height: 20,),
                      CustomOutlineButton(
                        onPressed: (){
                          final isValid = loginFormProvider.validateForm();
                          if ( isValid ) {
                            authProvider.login(loginFormProvider.email, loginFormProvider.email);
                          }
                        }, 
                        text: 'Enter'
                      ),
                      const SizedBox(height: 20,),
                      LinkText(
                        text: 'Create account',
                        onPressed: (){
                          Navigator.pushNamed( context, CustomFluroRouter.registerRoute);
                        },
                      )
                    ],
                  )
                ),
              )
            ),
          );
        },
      )
    );
  }

}
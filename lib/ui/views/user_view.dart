import 'dart:html';

import 'package:admin_dashboard/models/user.dart';
import 'package:admin_dashboard/providers/user_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserView extends StatefulWidget {
  const UserView ({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.uid);
    }
    super.initState();
    final  usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final  usersFormProvider = Provider.of<UserFormProvider>(context, listen: false);
    usersProvider.getUserById(widget.uid)
      .then(( userDB ) {
        if ( userDB != null ) {
          usersFormProvider.user = userDB;
          usersFormProvider.formKey = GlobalKey<FormState>();
          setState(() => user = userDB,); 
        } else {
          NavigationService.replaceTo('/dashboard/users');
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20,  vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'User View',
            style: CustomLabels.h1
          ),
          const SizedBox(height: 10,),
          ( user == null ) 
             ? WhiteCard(
                child: Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: const CircularProgressIndicator(),
                ),
              )
             :const _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
         columnWidths: const {
          0: FixedColumnWidth(250)
         },
         children:const  [
          TableRow(
            children: [
              _AvatarContainer(),
              _UserViewForm()
            ]
          )
         ],
      ) ,
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user;
    return WhiteCard(
      title: 'General Information ${user?.correo}',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child:  Column(
          children: [
            TextFormField(
              initialValue: user?.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'User name', 
                label: 'Name',
                icon: Icons.supervised_user_circle_outlined, 
              ),
              validator: (value) {
                if ( value == null || value.isEmpty ) return 'Name is required';
                if ( value.length < 2 ) return 'Min 2 characters';
                return null;
              },
              onChanged: (value) {
                userFormProvider.copyUserWith( nombre: value );
                // userFormProvider.updateListeners();
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: user?.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'User email', 
                label: 'Email',
                icon: Icons.mark_email_read_outlined, 
              ),
              validator: (value) {
                if ( value == null || value.isEmpty ) return 'Email is required';
                if ( EmailValidator.validate(value) == false ) return 'Invalid email';
                return null;
              },
              onChanged: (value) {
                userFormProvider.copyUserWith( correo: value );
              },
            ),
            const SizedBox(height: 20,),
            const SizedBox(height: 20,),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100),
              child: ElevatedButton(
                onPressed: () async {
                   // TODO: update user,
                  final saved = await userFormProvider.updateUser();
                  if ( saved ) {
                    NotificationService.showSnackbarOk(' Updated users');
                    Provider.of<UsersProvider>(context, listen:  false).refreshUser( user! );
                  } else {
                      NotificationService.showSnackbarError('Not save');
                  }
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shadowColor: MaterialStateProperty.all( Colors.indigo )
                ),
                child: Row(
                  children: const  [
                    Icon(Icons.save_outlined, size: 20,),
                    Text('  Save')
                  ],
                )
              ),
            )
          ],
        )
      )
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user;

    final  img = ( user?.img == null) ? const Image(
          image: AssetImage('no-image.jpg'),
        )
      : FadeInImage.assetNetwork(placeholder: 'loader.gif' , image: user!.img!);
    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Text( 'Profile', style: CustomLabels.h2,),
            const SizedBox(height: 20,),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                    child: img,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all( color: Colors.white, width: 5)
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        child: const Icon(Icons.camera_alt_outlined),
                        onPressed: () async {
                           // TODO: selected image
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'jpeg', 'png'],
                                allowMultiple: false,
                            ); 
                          if ( result != null ) {
                            NotificationService.showBusyIndiator(context);
                            PlatformFile file = result.files.first;
                            final resp = await userFormProvider.uploadImage('/uploads/usuarios/${user?.uid}', file.bytes!);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Text( 
              user?.nombre ?? 'User name',
              style: TextStyle( fontWeight: FontWeight.bold ),
            ),
          ],
        ),
      ),
    );
  }
}
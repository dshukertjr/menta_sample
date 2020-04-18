import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/bloc/pages/edit_profile/edit_profile_bloc.dart';
import 'package:sample/models/user.dart';
import 'package:sample/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  static PageRoute<dynamic> route(User user) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<EditProfileBloc>(
        create: (context) => EditProfileBloc(),
        child: EditProfilePage(
          user: user,
        ),
      ),
    );
  }

  final User user;

  const EditProfilePage({Key key, @required this.user}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController;
  TextEditingController _profileController;
  File _newProfileImageFile;

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 12, width: 12);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('プロフィール編集'),
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        condition: (oldState, state) {
          if (oldState is SavingProfileState && state is EditProfileInitial) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('プロフィールが更新されました')));
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(12),
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfileImage(
                    size: 100,
                    onTap: _changeProfileImage,
                    user: widget.user,
                    imageFile: _newProfileImageFile,
                  ),
                  spacer,
                  Expanded(
                    child: TextFormField(
                      enabled: state is EditProfileInitial,
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ユーザー名',
                      ),
                    ),
                  ),
                ],
              ),
              spacer,
              TextFormField(
                enabled: state is EditProfileInitial,
                controller: _profileController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'プロフィール',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  child: state is EditProfileInitial
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.check),
                            Text('保存'),
                          ],
                        )
                      : SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                  onPressed: state is EditProfileInitial ? _saveProfile : null,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user?.name);
    _profileController = TextEditingController(text: widget.user?.profile);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _changeProfileImage() async {
    FocusScope.of(context).unfocus(focusPrevious: true);
    _newProfileImageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
      imageQuality: 75,
    );
    setState(() {});
  }

  void _saveProfile() {
    final newUser = User(
      uid: widget.user.uid,
      name: _nameController.text,
      profile: _profileController.text,
      imageUrl: widget.user.imageUrl,
    );
    BlocProvider.of<EditProfileBloc>(context).add(
      SaveProfileEvent(
        user: newUser,
        profileImageFile: _newProfileImageFile,
      ),
    );
  }
}

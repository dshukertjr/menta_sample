import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:sample/models/user.dart';
import 'package:sample/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController;
  TextEditingController _profileController;
  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 12, width: 12);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('プロフィール編集'),
        actions: <Widget>[
          BlocBuilder<EditProfileBloc, EditProfileState>(
              builder: (context, state) {
            if (state is LoadedProfileState) {
              final user = state.user;
              return FlatButton(
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check),
                    Text('保存'),
                  ],
                ),
                onPressed: () {
                  final newUser = User(
                    uid: user.uid,
                    name: _nameController.text,
                    profile: _profileController.text,
                    imageUrl: user.imageUrl,
                  );
                  BlocProvider.of<EditProfileBloc>(context).add(
                    SaveProfileEvent(
                      user: newUser,
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        condition: (oldState, state) {
          if (oldState is SavingProfileState && state is LoadedProfileState) {
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
          if (state is EditProfileInitial) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(12),
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfileImage(
                    onTap: () {},
                    user: User(
                        name: 'aaa',
                        imageUrl: '',
                        profile: 'dfasfda',
                        uid: 'dsfadsa'),
                  ),
                  spacer,
                  Expanded(
                    child: TextFormField(
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
                controller: _profileController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'プロフィール',
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
    _nameController = TextEditingController();
    _profileController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

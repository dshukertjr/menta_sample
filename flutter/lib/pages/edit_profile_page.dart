import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:sample/models/user.dart';
import 'package:sample/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key key, @required this.user}) : super(key: key);
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
        child: ListView(
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
            Align(
              alignment: Alignment.centerLeft,
              child: BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                if (state is EditProfileInitial) {
                  return RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.check),
                        Text('保存'),
                      ],
                    ),
                    onPressed: () {
                      final newUser = User(
                        uid: widget.user.uid,
                        name: _nameController.text,
                        profile: _profileController.text,
                        imageUrl: widget.user.imageUrl,
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
            ),
          ],
        ),
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
}

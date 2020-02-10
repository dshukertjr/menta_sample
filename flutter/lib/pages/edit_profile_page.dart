import 'package:flutter/material.dart';
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
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          Row(
            children: <Widget>[
              ProfileImage(
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
            decoration: InputDecoration(
              labelText: 'プロフィール',
            ),
          ),
        ],
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

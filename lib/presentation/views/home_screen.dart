import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new1/models/post.dart';
import 'package:new1/presentation/widgets/item_widget.dart';
import 'package:new1/providers/posts_provider.dart';

import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../soruce/data_source/local_data_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DbHelper dbHelper;  
  late Future<List<Post?>?> posts;
  @override
  void initState() {
    // Provider.of<PostsProivider>(context, listen: false).getList();
    super.initState();
    dbHelper = DbHelper();
    _onStartUp();
  }

  _onStartUp() async {
    // UserModel uModel = UserModel("admin", "admin123");
    // uModel = dbHelper.getLoginUser("admin", "admin123");
    posts = dbHelper.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: posts,
        builder: (BuildContext context, AsyncSnapshot<List<Post?>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ItemWidget(
                onPressed: (() {
                  /*Provider.of<PostsProivider>(context, listen: false)
                      .onPressedLike(index);*/
                }),
                post: snapshot.data?[index],
              ),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent,
                thickness: 2,
                height: 20,
              ),
            );
          } else {
            return const Text("");
          }
        },
      ),

      /*ListView.separated(
                  itemCount: 1,
                  itemBuilder: (context, index) => ItemWidget(
                    onPressed: (() {
                      Provider.of<PostsProivider>(context, listen: false)
                          .onPressedLike(index);
                    }),
                    post: value.list[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                    thickness: 2,
                    height: 20,
                  ),
                )*/
      /*Consumer<PostsProivider>(builder: (context, value, child) {
          return value.isLoading
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  itemCount: value.list.length,
                  itemBuilder: (context, index) => ItemWidget(
                    onPressed: (() {
                      Provider.of<PostsProivider>(context, listen: false)
                          .onPressedLike(index);
                    }),
                    post: value.list[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                    thickness: 2,
                    height: 20,
                  ),
                );
        })*/
    );
  }
}

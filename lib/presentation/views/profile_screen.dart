import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new1/presentation/widgets/profile_item.dart';
import 'package:new1/providers/posts_provider.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../../soruce/data_source/local_data_source.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final DbHelper dbHelper;
  late Future<List<Post?>?> posts;
  @override
  void initState() {
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
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const CircleAvatar(
            foregroundImage: AssetImage("assets/images.png"),
            radius: 50,
          ),
          const SizedBox(height: 10),
          const Text("WAEL alaya"),
          const SizedBox(height: 30),
          FutureBuilder(
              future: posts,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post?>?> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileItem(
                            title: "Posts", value: snapshot.data!.length),
                        ProfileItem(
                            title: "Likes",
                            value: snapshot.data?.map((e) => e?.isLike).reduce(
                                    (value, element) => value! + element!) ??
                                0),
                        const ProfileItem(title: "Following", value: 200)
                      ]);
                } else {
                  return const Text("");
                }
              }),
          /*Consumer<PostsProivider>(builder: (context, value, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileItem(title: "Posts", value: value.list.length),
                      ProfileItem(title: "Likes", value: value.likesNumber),
                      const ProfileItem(title: "Following", value: 200)
                    ]);
              }),*/
          const SizedBox(height: 30),
          Flexible(
              fit: FlexFit.tight,
              child: FutureBuilder(
                  future: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post?>?> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: snapshot.data?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent: 150),
                          itemBuilder: ((context, index) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: snapshot.data?[index]?.isFile == 0
                                          ? Image.file(File(
                                              snapshot.data?[index]?.image ??
                                                  ""))
                                          : Image.network(
                                              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAAD1BMVEX+/v7////Z2dnc3Ny6urpCvU+4AAABU0lEQVR4nO3QQQHEIBAAMWDxr/nu2XYsJBKy7hye5q7ZvM06e/G0j5MvJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSflpJyUk3JSTspJOSkn5aSclJNyUk7KSTkpJ+WknJSTclJOykk5KSf1P5nN26w7h6e5P2aaCrlKyIulAAAAAElFTkSuQmCC",
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        /*Provider.of<PostsProivider>(context,
                                                listen: false)
                                            .onPressedLike(index);*/
                                      },
                                      icon: Icon(
                                        snapshot.data?[index]?.isLike == 0
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            );
                          }));
                    } else {
                      return const Text("");
                    }
                  })),

          /*Consumer<PostsProivider>(builder: (context, value, child) {
                  return value.isLoading
                      ? const CupertinoActivityIndicator()
                      : GridView.builder(
                          itemCount: value.list.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent: 150),
                          itemBuilder: ((context, index) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: value.list[index].isFile == 0
                                          ? Image.file(
                                              File(value.list[index].image?))
                                          : Image.network(
                                              value.list[index].image?,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        Provider.of<PostsProivider>(context,
                                                listen: false)
                                            .onPressedLike(index);
                                      },
                                      icon: Icon(
                                        value.list[index].isLike == 0
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            );
                          }));
                }),*/
        ]),
      ),
    );
  }
}

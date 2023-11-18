import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/music_service/music_service.dart';
import 'package:glad/preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_router.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => HomeBloc(
                    RepositoryProvider.of<MusicService>(context),
                    RepositoryProvider.of<SharedPreferencesService>(context))
                  ..add(OnLoadHomeEvent())),
          ],
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/infinitylogo.png",
                        height: 150,
                        width: 150,
                      ),
                      Text("glad",
                          style: GoogleFonts.imperialScript(
                            fontWeight: FontWeight.w400,
                            fontSize: 75,
                            height: 1.21,
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: (){
                          context.push("/${Routes.dailyEntry}",extra: "");
                        },
                        child: Container(
                          // autogrouparibH3m (56TWL9yQgcB5sfp16HArib)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                          width:  double.infinity,
                          height:  55,
                          decoration:  BoxDecoration (
                            color:  const Color(0xff4caf50),
                            borderRadius:  BorderRadius.circular(50),
                            boxShadow:  const [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'Record Daily Entry',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.arimo (

                                fontSize:  22,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,
                                color:  const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: (){
                          context.push("/${Routes.search}",extra: "");
                        },
                        child: Container(
                          // autogrouparibH3m (56TWL9yQgcB5sfp16HArib)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                          width:  double.infinity,
                          height:  55,
                          decoration:  BoxDecoration (
                            color:  const Color(0xff2196f3),
                            borderRadius:  BorderRadius.circular(50),
                            boxShadow:  const [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'Search',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.arimo (

                                fontSize:  22,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,
                                color:  const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: (){
                          context.push("/${Routes.settings}",extra: "");
                        },
                        child: Container(
                          // autogrouparibH3m (56TWL9yQgcB5sfp16HArib)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                          width:  double.infinity,
                          height:  55,
                          decoration:  BoxDecoration (
                            color:  const Color(0xff9c27b0),
                            borderRadius:  BorderRadius.circular(50),
                            boxShadow:  const [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'Settings',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.arimo (

                                fontSize:  22,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,
                                color:  const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: (){
                          context.push("/${Routes.help}",extra: "");
                        },
                        child: Container(
                          // autogrouparibH3m (56TWL9yQgcB5sfp16HArib)
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                          width:  double.infinity,
                          height:  55,
                          decoration:  BoxDecoration (
                            color:  const   Color(0xfff44336),
                            borderRadius:  BorderRadius.circular(50),
                            boxShadow:  const [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'Help',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.arimo (

                                fontSize:  22,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,
                                color:  const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/${Routes.about}", extra: "");
                        },
                        child: Container(

                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                          width:  double.infinity,
                          height: 55,
                          decoration:  BoxDecoration (
                            color:  const   Color(0xfff9a825),
                            borderRadius:  BorderRadius.circular(50),
                            boxShadow:  const [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'About',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.arimo (

                                fontSize:  22,
                                fontWeight:  FontWeight.w400,
                                height:  1.2575,
                                color:  const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

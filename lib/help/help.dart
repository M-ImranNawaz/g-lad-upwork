import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:glad/components/app_bar.dart';
import 'package:glad/help/help_bloc.dart';
import 'package:glad/help/image_preview.dart';
import 'package:glad/music_service/music_service.dart';
import 'package:glad/preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_router.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Text:
    const String text =
        "If you or someone you love is in crises, you can contact the sucide & crises lifeline ";

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const GladAppBar(titleOfPage: "Help")
          ];
        },
        body: Material(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => HelpBloc(
                      RepositoryProvider.of<MusicService>(context),
                      RepositoryProvider.of<SharedPreferencesService>(context))
                    ..add(OnLoadHelpEvent())),
            ],
            child: BlocBuilder<HelpBloc, HelpState>(builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(

                    children: <Widget>[
                      const SizedBox(height: 20,),
                      Text("Feelings wheel", style: GoogleFonts.actor(

                        fontSize:  20,
                        fontWeight:  FontWeight.w700,
                        height:  1.235,

                      ),),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ImagePreview(image: "assets/wheel.jpg"),
                              ));
                        },
                        child: Image.asset(
                          "assets/wheel.jpg",
                          height: 400,
                          width: 400,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 1, 9),
                        child:
                        Text(
                          'Crises Help',
                          style:  GoogleFonts.actor(
                            fontSize:  20,
                            fontWeight:  FontWeight.w700,
                            height:  1.235,
                          ),
                        ),
                      ),
                      const Flexible(
                        child: Text(
                          text, // Declared above
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          FlutterPhoneDirectCaller.callNumber('988');
                        },
                        icon: const Icon(Icons.call),
                        label: const Text('988'),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

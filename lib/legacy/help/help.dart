import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_bar.dart';
import '../music_service/music_service.dart';
import '../preferences/shared_preferences.dart';
import 'help_bloc.dart';
import 'image_preview.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Text:
    const String helpText =
        "If you or someone you love is in crisis, you can contact the ";
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;


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
                          'Crisis Help',
                          style:  GoogleFonts.actor(
                            fontSize:  20,
                            fontWeight:  FontWeight.w700,
                            height:  1.235,
                          ),
                        ),
                      ),
                      RichText(
                        text:  TextSpan(
                           children: [
                            TextSpan(
                              text: helpText,
                              style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black, fontSize: 18),
                            ),
                             TextSpan(
                               text: "Suicide & Crisis lifeline",
                               style: const TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline,),
                               recognizer: TapGestureRecognizer()
                                 ..onTap = () { launchUrl(Uri(scheme: "https", path: "www.988lifeline.org"));
                                 },
                             ),
                           ]
                        ) ,
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

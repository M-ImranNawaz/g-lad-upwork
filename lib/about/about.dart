import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/about/about_bloc.dart';
import 'package:glad/about/constants.dart';
import 'package:glad/components/app_bar.dart';
import 'package:glad/music_service/music_service.dart';
import 'package:glad/preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child:
      NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
             const GladAppBar(titleOfPage: "About")
          ];
        },
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AboutBloc(
                    RepositoryProvider.of<MusicService>(context),
                    RepositoryProvider.of<SharedPreferencesService>(context))
                  ..add(OnLoadHelpEvent())),
          ],
          child: BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
            return Material(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: ListView(

                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'What Glad means?',
                      style: GoogleFonts.actor(

                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.26,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(text1), // Text 1,2,3 are above
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Purpose of this App',
                      style: GoogleFonts.actor(

                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.26,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(text2),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Origination Story?',
                      style: GoogleFonts.actor(

                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.26,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(text3),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

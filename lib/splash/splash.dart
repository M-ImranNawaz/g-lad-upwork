import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/splash/splash_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget{
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (context) => SplashBloc(),
       child: BlocBuilder<SplashBloc, SplashState>(
         builder: (context, state){

         if(state is NavigateToHomeScreenState){
           WidgetsBinding.instance.addPostFrameCallback(
                 (_) => context.go('/home'),
           );
         }

         return Scaffold(
           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Column(
                   children: [
                     SizedBox(
                       height: 50,
                       child: OverflowBox(
                         minHeight: 200,
                         maxHeight: 200,
                         child: Lottie.asset("assets/infinity.json"),
                       ),
                     ),

                      Text("glad",style:  GoogleFonts.caveat(
                        fontSize: 120,
                     )),
                     const SizedBox(height: 20,),
                      Text("Focusing on positive", style:  GoogleFonts.caveat(
                       fontSize: 30,
                     )),
                      Text("daily experiences", style:  GoogleFonts.caveat(
                        fontSize: 30,
                      ))
                   ],
                 ),
               ],
             ),
           ),
         );
       }),
     );
  }

}
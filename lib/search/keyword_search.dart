import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/components/app_bar.dart';
import 'package:glad/daily_entry/models/daily_record_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../app_router.dart';
import '../daily_entry/repository/main_repository.dart';
import '../preferences/shared_preferences.dart';
import 'keyword_search_bloc.dart';
import 'dart:math';
import 'package:string_similarity/string_similarity.dart';

class KeywordSearch extends StatefulWidget {
  const KeywordSearch({super.key});

  @override
  State<KeywordSearch> createState() => _KeywordSearchState();
}

class _KeywordSearchState extends State<KeywordSearch> {

  final TextEditingController _searchController = TextEditingController();

  Color getColor(){
    final _random = Random();

// from MIN(inclusive), to MAX(inclusive).
    int randomBetweenIncInc(int min, int max) => min + _random.nextInt((max + 1) - min);
    List<Color> palletColors = [Color(0xffffb8d1), Color(0xffe4b4c2), Color(0xffe7cee3), Color(0xffddfdfe)];
    return palletColors[randomBetweenIncInc(0, palletColors.length - 1)];
  }


  String formatDate(String date){
    print(date);
    var inputFormat = DateFormat('yyyy-mm-dd');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('mm/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }


  String getClosestString(DailyRecordModel model, String keyword){
    String grateful = model.grateful;
    String learned = model.learned;
    String appreciated = model.appreciated;
    String delighted = model.delighted;

    List<String> closestStringArr = [];

    closestStringArr.add(grateful);
    closestStringArr.add(learned);
    closestStringArr.add(appreciated);
    closestStringArr.add(delighted);


    final bestMatch = keyword.bestMatch(closestStringArr);

    switch (bestMatch.bestMatchIndex){
      case 0:
        return "I am grateful ${closestStringArr[bestMatch.bestMatchIndex]}";

       case 1:
         return "I learned ${closestStringArr[bestMatch.bestMatchIndex]}";
      case 2:
        return "I appreciate ${closestStringArr[bestMatch.bestMatchIndex]}";
      case 3:
        return "I am delighted ${closestStringArr[bestMatch.bestMatchIndex]}";
    }

    return "";
  }

  String getText(DailyRecordModel model, String keyword){

    return getClosestString(model, keyword);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            const GladAppBar(titleOfPage: "Keyword Search", previousPage: "Search",)
          ];
        },
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => KeywordSearchBloc(
                    RepositoryProvider.of<RecordRepository>(context),
                    RepositoryProvider.of<SharedPreferencesService>(context))
                  ..add(OnLoadSearchEvent())),
          ],
          child: BlocBuilder<KeywordSearchBloc, KeywordResultListState>(
              builder: (context,state) {
                return Material(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (text) {
                            BlocProvider.of<KeywordSearchBloc>(context).add(OnKeywordSearchBeginEvent(text));
                          },
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            // Add a clear button to the search bar
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  BlocProvider.of<KeywordSearchBloc>(context).add(OnKeywordSearchBeginEvent(""));
                                }
                            ),
                            // Add a search icon or button to the search bar
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                // Perform the search here
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListView.builder(

                                itemCount: state.list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap:(){

                                          context.push('/${Routes.dailyEntry}', extra: state.list[index].date);
                                        },
                                        child: Container(
                                          height: 100,

                                          decoration: BoxDecoration(
                                              color:   MediaQuery.of(context).platformBrightness == Brightness.dark? Colors.deepPurpleAccent : const Color(0xfff7f1fb),
                                              boxShadow:  const [
                                                BoxShadow(
                                                  color:  Color(0x3f000000),
                                                  offset:  Offset(0, 4),
                                                  blurRadius:  2,
                                                ),
                                              ],
                                              border: Border.all(
                                                color: const Color(0xff7145c1)
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                //#E4B4C2
                                                Container(
                                                  height:75,
                                                  width:75,
                                                  decoration:  BoxDecoration (

                                                    color:getColor(),
                                                    //color:  const Color(0xffE4B4C2),
                                                    borderRadius:  BorderRadius.circular(50),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        formatDate( state.list[index].date),



                                                        style: GoogleFonts.actor(
                                                          fontSize:  12,
                                                          fontWeight:  FontWeight.w400,
                                                          height:  1.235,
                                                          color: const Color(0xff000000),

                                                      ),),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 30,),
                                                Flexible(
                                                  child: Text(
                                                      getText(state.list[index],state.keyword),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.actor(
                                                        fontSize: 18,)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                    ],
                                  );
                                }),
                          ),
                        ),
                        // state.count != 0 ? Text("${state.count}") : Container()



                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),);
 
  }
}
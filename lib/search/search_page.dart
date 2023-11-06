import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/components/app_bar.dart';
import 'package:glad/daily_entry/repository/main_repository.dart';
import 'package:glad/daily_entry/services/main_service.dart';
import 'package:glad/music_service/music_service.dart';
import 'package:glad/preferences/shared_preferences.dart';
import 'package:glad/search/search_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app_router.dart';
import 'event_model.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();


  List<Event> getEventsForDay(DateTime day) {

    return [];
    //return BlocProvider.of<SearchBloc>(context).add(OnKeywordSearchBeginEvent(""));;
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
             const GladAppBar(titleOfPage: "Search"),
          ];
        },
        body:  Material(

          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => SearchBloc(
                      RepositoryProvider.of<RecordRepository>(context),
                      RepositoryProvider.of<SharedPreferencesService>(context))
                    ..add(OnLoadSearchEvent())),
            ],
            child: BlocBuilder<SearchBloc, GetEventsForDateState>
              (builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      TableCalendar<Event>(
                          onPageChanged: (focusedDay) {
                            _focusedDate = focusedDay;
                            BlocProvider.of<SearchBloc>(context)
                                .add(OnPageChangedEvent(focusedDay));
                          },


                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (BuildContext context, date, events) {
                              if (events.isEmpty) return const SizedBox();
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: events.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.all(1),
                                      child: Container (
                                        // height: 7, // for vertical axis
                                        width: 5,    //for horizontal axis
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.red : Colors.deepPurpleAccent
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          headerVisible: true,
                          headerStyle: const HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible : false,

                          ),
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDate,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDate, day);
                          },

                          onDaySelected: (selectedDay, focusedDay) {

                            setState(() {
                              _selectedDate = selectedDay;
                              _focusedDate = focusedDay;
                            });

                            var date = state.data[selectedDay]?[0].date;
                            if(date != null){
                              context.push('/${Routes.dailyEntry}', extra: state.data[selectedDay]?[0].date);
                            }


                          },

                          eventLoader: (day){
                            return state.data[day] ?? [];
                          }
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                       Text("You can see which dates you recorded an entry", style: GoogleFonts.actor(
                        fontSize:  18,
                        fontWeight:  FontWeight.w400,
                        height:  1.2575,

                      ),),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Or", style: GoogleFonts.actor(
                        fontSize:  18,
                        fontWeight:  FontWeight.w400,
                        height:  1.2575,

                      ),),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: (){
                          context.push("/${Routes.keywordsSearch}");
                        },
                        child: Container(
                          decoration:   BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.deepPurpleAccent : const Color(0xfff7f1fb),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.search),
                                    const SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Text("Search", style: GoogleFonts.actor(
                                          fontSize:  18.5963916779,
                                          fontWeight:  FontWeight.w400,
                                          height:  1.2575,
                                          color:  Theme.of(context).colorScheme.primary,
                                        ),),
                                        Text("Search your records by keywords", style: TextStyle(
                                          color:  Theme.of(context).colorScheme.secondary,
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right))

                            ],
                          ),
                        ),
                      ),


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

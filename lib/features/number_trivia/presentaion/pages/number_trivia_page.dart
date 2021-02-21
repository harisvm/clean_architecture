import 'package:clean_architecture_tdd/features/number_trivia/presentaion/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height/3,
              child: Placeholder(),

            ),

            SizedBox(height: 20,),

            Column(children: [

              Placeholder(fallbackHeight: 40,),

              SizedBox(height: 10,),
              Row(children: [
                Expanded(child: Placeholder(fallbackHeight: 30,)),
                SizedBox(width: 10,),

                Expanded(child: Placeholder(fallbackHeight: 30,)),

              ],)

            ],)

          ],
        ),
      ),
    );
  }
}

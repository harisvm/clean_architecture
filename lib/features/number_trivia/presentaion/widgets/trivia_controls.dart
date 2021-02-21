import 'package:clean_architecture_tdd/features/number_trivia/presentaion/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputString;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Input a number'),
          onChanged: (value) {
            inputString = value;
          },
          onSubmitted: (_){

            dispatchConcrete(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: RaisedButton(
                  child: Text('Search'),
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {
                    dispatchConcrete(context);
                  },
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: RaisedButton(
                  child: Text('Get Random Trivia'),
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {
                    dispatchRandom(context);
                  },
                )),
          ],
        )
      ],
    );
  }

  void dispatchConcrete(BuildContext context) {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputString));
  }

  void dispatchRandom(BuildContext context) {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumber());
  }
}
import 'package:clean_architecture_tdd/features/number_trivia/presentaion/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentaion/widgets/common_widgets.dart';
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
      body: SingleChildScrollView(child: buildBody(context)),

    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start Searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                }),
              ),
              SizedBox(
                height: 20,
              ),
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}



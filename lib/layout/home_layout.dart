import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) { },
        builder: (context, states) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.search),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: NewsCubit.get(context).currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}

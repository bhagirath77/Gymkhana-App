import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/Blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/constants.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          '${context.repository<AuthenticationRepository>().currentCustomUser.photoUrl}',
                          height: 50,
                        )),
                    IconButton(
                      icon: currentTheme == 'light'? Icon(Icons.nightlight_round,color: Colors.black ,) : Icon(Icons.brightness_7,color: Colors.white,),
                      onPressed: () async {
                        if (context.bloc<ThemeBloc>().state ==
                            ThemeStates.light()) {
                          await setThemePreference(currentValue: 'dark');
                          context.bloc<ThemeBloc>().add(ThemeChange.dark);
                        } else {
                          context.bloc<ThemeBloc>().add(ThemeChange.light);
                          await setThemePreference(currentValue: 'light');
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  context
                      .repository<AuthenticationRepository>()
                      .currentCustomUser
                      .name,
                  style: theme.textTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  context
                      .repository<AuthenticationRepository>()
                      .currentCustomUser
                      .email,
                  style: theme.textTheme.subtitle1,
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,color:currentTheme == 'light'? Colors.black :Colors.white,) ,
            title:  Text('Home',style: theme.textTheme.subtitle2,),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
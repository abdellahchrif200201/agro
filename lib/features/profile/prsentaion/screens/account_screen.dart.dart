import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/config/theme/bloc/theme_event.dart';
import 'package:devti_agro/core/utils/user_info_service.dart';
import 'package:devti_agro/core/widgets/custom_icon_back/icon_back.dart';
import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
// import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
// import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/full_user_information.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/forward_button.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/setting_item.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/setting_switch.dart';
import 'package:devti_agro/features/test/langage.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  Map<String, dynamic>? _userInfo;
  final UserInfoService _userInfoService = UserInfoService();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final userInfo = await _userInfoService.getUserInfo();
    setState(() {
      _userInfo = userInfo;
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("auth_token");
    prefs.remove("name");

    // Navigate to login or another screen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final theme = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Scaffold(
      // backgroundColor: theme ? Color(0xff212121) : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const IconBack(),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).settings,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                S.of(context).account,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/avatar.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (_userInfo != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userInfo!['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Youtube Channel",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    else
                      const CircularProgressIndicator(),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        if (_userInfo != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullUserInformation(
                                user: User(
                                  id: _userInfo!['id'],
                                  name: _userInfo!['name'],
                                  entrepriseId: _userInfo!['EntrepriseId'],
                                  adresse: _userInfo!['Adresse'],
                                  email: _userInfo!['email'],
                                  image: _userInfo!['Image'],
                                  pays: _userInfo!['name'],
                                  telephone: _userInfo!['Telephone'],
                                  ville: _userInfo!['Ville'],
                                ),
                              ),
                            ),
                          );
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: S.of(context).login,
                            desc: S.of(context).not_login,
                            titleTextStyle: Theme.of(context).textTheme.titleMedium,
                            descTextStyle: Theme.of(context).textTheme.titleMedium,
                            btnOkText: S.of(context).login,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            ),
                          ).show();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                S.of(context).settings,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: S.of(context).add_user,
                icon: Ionicons.add_circle,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  if (_userInfo != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddUserScreen()),
                    );
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'login',
                      desc: 'you are not logged in?',
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      descTextStyle: Theme.of(context).textTheme.titleMedium,
                      btnOkText: 'connexion',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      ),
                    ).show();
                  }
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: S.of(context).all_user,
                icon: Ionicons.people,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  if (_userInfo != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllUsersScreen()),
                    );
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'login',
                      desc: 'you are not logged in?',
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      descTextStyle: Theme.of(context).textTheme.titleMedium,
                      btnOkText: 'connexion',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      ),
                    ).show();
                  }
                },
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: S.of(context).theme,
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: themeBloc.state.isDarkMode,
                onTap: (value) {
                  setState(() {
                    themeBloc.add(ToggleDarkMode(isDarkMode: value));
                  });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: S.of(context).language,
                icon: Ionicons.language,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => LanguageDropdown()));
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: S.of(context).logout,
                icon: Ionicons.log_out,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: S.of(context).logout,
                    desc: S.of(context).are_you_sure,
                    titleTextStyle: Theme.of(context).textTheme.titleMedium,
                    descTextStyle: Theme.of(context).textTheme.titleMedium,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () => _logout(context),
                  ).show();
                },
              ),
              const SizedBox(height: 20),
              // LanguageDropdown()
            ],
          ),
        ),
      ),
    );
  }
}

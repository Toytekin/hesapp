import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/constant/path.dart';
import 'package:hesapp/cubit/theme.dart';
import 'package:hesapp/widget/card_s.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    double sizeWidth = MediaQuery.of(context).size.height - 200;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: sizeWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                image: AssetImage(
                  SbtPath.ALTIN,
                ),
                fit: BoxFit
                    .cover, // Görseli tam olarak sayfayı kaplayacak şekilde ölçekler
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SbtCard(
                    onTap: () {},
                    icon: Icons.money_off,
                    yazi: 'Borç',
                    color: false,
                    sizeWidth: sizeWidth),
                SbtCard(
                    onTap: () {},
                    icon: Icons.attach_money,
                    yazi: 'Alınacak',
                    color: true,
                    sizeWidth: sizeWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<ThemeBloc, bool> themeConvertButton() {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<ThemeBloc>().thmeConvert();
          },
          icon: state
              ? const Icon(Icons.light_mode)
              : const Icon(Icons.dark_mode),
        );
      },
    );
  }
}

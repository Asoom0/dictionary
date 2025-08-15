import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/color.dart';
import '../controller/controller.dart';
import '../core/sizes.dart';
import '../core/strings.dart';
import 'widget/info_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DictionaryCubit>();
    final favorites = cubit.favorites;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.lightBlue ,
        centerTitle: true,
        title: Text(Strings.favorites,
        style: GoogleFonts.cairo(
          fontSize: Sizes.s27,
          fontWeight: FontWeight.w800,
          color: MyColor.textColor,
        ),),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          Strings.noFavorites,
          style: GoogleFonts.cairo(),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final wordData = favorites[index];
          return Padding(
            padding:  EdgeInsets.all(Sizes.s12),
            child: Stack(
              children: [
                InfoCard(
                  title: wordData.word,
                  value: wordData.meaning,
                  backgroundColor: MyColor.favoriteCard,
                ),
                Positioned(
                  top: Sizes.s8,
                  right: Sizes.s8,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        cubit.removeFromFavorites(wordData);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Strings.removedFromFavorites),
                        backgroundColor: MyColor.SoftRed,),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}

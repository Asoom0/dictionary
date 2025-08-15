import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/color.dart';
import '../core/sizes.dart';
import '../core/strings.dart';
import 'favorites_view.dart';
import '../controller/controller.dart';
import 'widget/info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  late DictionaryCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<DictionaryCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.pageBackground,
      appBar: AppBar(
        backgroundColor: MyColor.lightBlue ,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.cairo(
                  fontSize: Sizes.s27,
                  fontWeight: FontWeight.w800,
                  color: MyColor.textColor,
                ),
                children:[
                  TextSpan(
                    text: Strings.wordAppBar,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: Strings.dictionary,
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritePage()),
                    );
                  },
                  icon: Icon(Icons.favorite,
                    size: Sizes.s33,
                    color: MyColor.heartRed,)),
            ),
          ],
        ),
      ),
      body: Padding(padding:
       EdgeInsets.all(Sizes.s20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) => cubit.search(value.trim()),
                    decoration: InputDecoration(
                      hintText: Strings.searchFieldHintText,
                      filled: true,
                      fillColor: MyColor.softWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.s14,),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: Sizes.s16, vertical: Sizes.s14),
                    ),
                  ),
                ),
                SizedBox(width: Sizes.s8),
                Container(
                  width: Sizes.s50,
                  height: Sizes.s50,
                  decoration: BoxDecoration(
                    color: MyColor.lightBlue,
                    borderRadius: BorderRadius.circular(Sizes.s14),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search,
                      size: Sizes.s30),
                    onPressed: (){
                      final value = _controller.text.trim();
                      cubit.search(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizes.s20),
            Expanded(
              child:BlocBuilder<DictionaryCubit, BaseState>(
                builder: (context, state){
                  if (state is LoadingState){
                    return const Center(child: CircularProgressIndicator());
                  }else if (state is FailureState){
                    return Center(
                      child: Text(state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }else if (state is SuccessState){
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          InfoCard(
                            title: Strings.word,
                            value: state.word,
                            backgroundColor: MyColor.gradientStart,
                          ),
                          SizedBox(height: Sizes.s16),
                          InfoCard(
                            title: Strings.meaning,
                            value: state.meaning,
                            backgroundColor: MyColor.lightPurple,
                          ),
                          SizedBox(height: Sizes.s16),
                          InfoCard(
                            title: Strings.example,
                            value: state.example,
                            backgroundColor: MyColor.highlightYellow,
                          ),
                          SizedBox(height: Sizes.s16),
                          ElevatedButton(onPressed:(){
                            if (state is SuccessState) {
                              cubit.addToFavorites(state);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(Strings.addedToFavorites),
                                backgroundColor: MyColor.mintGreen),
                              );
                            }
                          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.lightBlue,
                              //foregroundColor: MyColor.lightBlue,
                            ),
                            child: Text(Strings.addToFavorites,
                              style: GoogleFonts.cairo(
                                color: MyColor.softText,
                                fontSize: Sizes.s15,
                                fontWeight: FontWeight.w700,
                              ),),
                          ),
                        ],
                      ),
                    );
                  }else {
                    return Center(
                      child: Text(
                        Strings.searchWord,
                        style: TextStyle(color: MyColor.grey),
                      ),
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

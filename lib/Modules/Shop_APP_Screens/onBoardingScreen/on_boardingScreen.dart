
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:shopapp/Shared/Components/Component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../Shared/Network/local/cache_Helper.dart';
import '../login/Shop_Login_Screen.dart';



class BoardingModel
{
  final   String image;
  final String title;
  final String body;
  BoardingModel({
    required  this.image,
    required  this.title,
    required  this.body,
});
}


class onBoardingScreen extends StatefulWidget {

  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var cont=PageController();

List<BoardingModel> page=[
  BoardingModel(image: 'assets/images/1st_image.jpg', title: 'PURCHASE ONLINE ', body: 'Have A good day with TOT APP'),
  BoardingModel(image: 'assets/images/2nd_image.jpg', title: 'CHOOSE AND CHECKOUT', body: 'body'),
  BoardingModel(image: 'assets/images/3rd_image.jpg', title: 'GET YOUR ORDER', body: 'body'),
];

bool lastPaage=false;

void onSubmit(){
  CacheHelper.SaveData(
      key: 'onBoarding',
      value: true).
  then((value) {
    if(value){
    navigatorAndFinish(
        context,
        ShopLoginScreen()
    );
  }
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            setState(() {
            onSubmit();
            });
          },child:Text('SKIP',style: TextStyle(color: Colors.deepOrange),) ,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context, index) {

                return BuildOnBoardingScreen(page[index]);
              },
                physics: BouncingScrollPhysics(),
                controller: cont,
                onPageChanged:(value) {
                  if(value==page.length-1){
                    print('sfsdfsdfsdfsdfsdf');
                    lastPaage=true;
                  }
                } ,
                itemCount: page.length,),
            ),
            SizedBox(
              height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: cont,
                  count:page.length ,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4.0,
                    activeDotColor: Colors.deepOrange,
                    spacing: 5.0
                  ),

                ),
                Spacer(),
                FloatingActionButton(onPressed: () {
                  if(lastPaage==false)
                  {
                    cont.nextPage(duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                  else{
                    setState(() {
                     onSubmit();
                    });
                  }
                },
                child: Icon(Icons.arrow_forward_outlined),)
            ],)

          ],
        ),
      ),

    );
  }

  Widget BuildOnBoardingScreen(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      //SizedBox(height: 20.0,),
      Center(
        child: Text(
          '${model.title}',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: HexColor('005bff')),
        ),
      ),
      SizedBox(height: 70.0,),
      Text(
        '${model.body}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20.0,),
    ],
  );
}

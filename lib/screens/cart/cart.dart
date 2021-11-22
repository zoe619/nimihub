import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/models/cartItem.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/order.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/models/Product.dart';
import 'package:nimihub_online/screens/payment.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';
import 'models/Cart.dart';


class CartScreenMain extends StatefulWidget
{
  final cart;
  final int sum;

  final String routName = "/cart";

  CartScreenMain({this.cart, this.sum});
  @override
  _CartScreenMainState createState() => _CartScreenMainState();
}

class _CartScreenMainState extends State<CartScreenMain>
{

  int total = 0;
  int quantity = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    total = widget.sum;
  }

  List<int> number = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,
    26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50];


  @override
  Widget build(BuildContext context)
  {

    final cart = Provider.of<CartMain>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      body: Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
      itemCount: cart.items.length,
       itemBuilder: (ctx, i) => CartPdt(
           cart.items.values.toList()[i].id,
           cart.items.keys.toList()[i],
           cart.items.values.toList()[i].price,
           cart.items.values.toList()[i].quantity,
           cart.items.values.toList()[i].name),

      ),
      ),
      bottomNavigationBar:  Container(
          padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
          ),
          // height: 174,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          ),
          boxShadow: [
          BoxShadow(
          offset: Offset(0, -15),
          blurRadius: 20,
          color: Color(0xFFDADADA).withOpacity(0.15),
          )
          ],
          ),
          child: SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        children: [
        Container(
        padding: EdgeInsets.all(10),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset("assets/icons/receipt.svg"),
        ),
        Spacer(),
        Text("Add voucher code"),
        const SizedBox(width: 10),
        Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: kTextColor,
        )
        ],
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text.rich(
        TextSpan(
        text: "Total:\n",
        children: [
        TextSpan(
        text: "\NGN${cart.totalAmount}",
        style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        ],
        ),
        ),
          CheckoutButton(
            cart: cart,
          ),
        ],
        ),
        ],
        ),
        ),
        ),
    );
  }


  AppBar buildAppBar(BuildContext context)
  {
    final cart = Provider.of<CartMain>(context);
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          cart.items.length > 1 ? Text(
            "${cart.items.length} items",
            style: Theme.of(context).textTheme.caption,
          ) : Text(
           "${cart.items.length} item",
           style: Theme.of(context).textTheme.caption,
         )
        ],
      ),
    );
  }


}

class CheckoutButton extends StatefulWidget
{
  final CartMain cart;

  const CheckoutButton({@required this.cart});
  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton>
{
  String name, email;
  _setupProfileUser() async
  {
    Users user  = await Provider.of<DatabaseService>(context, listen: false).getUserWithId(
        Provider.of<UserData>(context, listen: false).currentUserId
    );
    setState(() {

      name = user.name;
      email = user.email;


    });
  }

  @override
  initState()
  {
    super.initState();
    _setupProfileUser();


  }

  _showErrorDialog(String errMessage, String status)
  {
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text(status),
            content: Text(errMessage),
            actions: <Widget>[
              Platform.isIOS
                  ? new CupertinoButton(
                child: Text('Ok'),
                onPressed: ()=>Navigator.pop(context),
              ) : FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);

                  }
              )
            ],
          );
        }
    );

  }
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: getProportionateScreenWidth(190),
      child: DefaultButton1(
          text: "Check Out",
          press: widget.cart.totalAmount <= 0
            ? null
            : () async
          {


            Navigator.push(context, MaterialPageRoute(builder: (_)=>Payment()));
//          String res = await Provider.of<Orders>(context, listen: false).addOrder(
//              widget.cart.items.values.toList(), widget.cart.totalAmount, name, email);
//          if(res == "success"){
//            widget.cart.clear();
//            _showErrorDialog('Order sent', 'success');
//          }
//          else{
//            _showErrorDialog('Error processing order', 'error');
//          }

        },
      ),
    );
  }
}

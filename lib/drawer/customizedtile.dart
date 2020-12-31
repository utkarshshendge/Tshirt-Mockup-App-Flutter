import 'package:flutter/material.dart'; 

// ignore: must_be_immutable
class Customizedtile extends StatelessWidget {
  IconData icons;
  String text;
  Function ontap;
  Customizedtile(this.icons,this.text,this.ontap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        //color: Colors.white,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child: InkWell(
        
        onTap: ontap ,
        child: Container(
        
          height: 50.0,
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: <Widget>[
              Row(
                children: <Widget>[
                  
                  Icon(icons,color:  Color(0xff9B9BAF),),
                  Padding(
                    
                    padding: EdgeInsets.all(8.0),
                    child: Text(text,style: TextStyle(fontSize: 16.0,color: Colors.white),
                    ),
                    )

              ],
              ),
              Icon(Icons.arrow_right,)
            ],
            ),
          
          
            ),
            
            ),
            
      ),
      
      
    );
    
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('vinay'),
      
    );
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('vay'),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('vin'),
    );
  }
}

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('sirsal'),
    );
  }
}


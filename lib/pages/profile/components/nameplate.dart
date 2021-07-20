import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operations.dart';
import 'package:geeklibrary/screens/login/provider/login_provider.dart';

class NamePlate extends StatefulWidget {
  const NamePlate(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  _NamePlateState createState() => _NamePlateState();
}

class _NamePlateState extends State<NamePlate> {
  bool editName = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var isDarkMode = watch(themeProvider).isDarkMode;
        var _name = watch(nameProvider);
        return Container(
          height: R.h(widget.info, 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: R.w(widget.info, 5)),
                width: R.w(widget.info, 75),
                child: Container(
                  child: TextField(
                    readOnly: !editName,
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Theme.of(context).brightness,
                    onChanged: (value) => _name.setname(value),
                    style: TextStyle(
                      fontSize: R.f(widget.info, 14),
                      color: isDarkMode
                          ? XColors.darkGray
                          : XColors.darkColor.withOpacity(0.75),
                    ),
                    decoration: InputDecoration(
                      hintText: _name.name.text,
                      hintStyle: TextStyle(
                        fontSize: R.f(widget.info, 14),
                        color: isDarkMode
                            ? XColors.darkGray.withOpacity(0.5)
                            : XColors.darkColor.withOpacity(0.2),
                      ),
                      icon: Icon(Typicons.user_outline),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: R.w(widget.info, 5)),
                child: KClickable(
                  onPressed: () => setState(() => editName = !editName),
                  width: R.w(widget.info, 10),
                  height: R.w(widget.info, 10),
                  child: Icon(
                    !editName ? EvaIcons.edit : EvaIcons.checkmark,
                    size: R.f(widget.info, 15),
                  ),
                  topDeco: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [XColors.grayColor, XColors.grayColor]),
                      borderRadius: BorderRadius.circular(10)),
                  bottomDeco: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.black, Colors.black]),
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        );
      },
    );
  }




  _setName(String name)async{
    
    await FirestoreOperations.saveAccountDetails(user, _accountDetails)
  }

}

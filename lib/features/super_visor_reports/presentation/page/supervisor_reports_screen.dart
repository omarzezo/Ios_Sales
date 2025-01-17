import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/super_visor_reports/data/datasources/reports_datasource.dart';
import 'package:sales/features/super_visor_reports/data/models/product_response_model.dart';
import 'package:sales/features/super_visor_reports/data/models/reports_response_model.dart';
import 'package:sales/features/super_visor_reports/data/models/supervisor_invoices_response_model.dart';
import 'package:sales/injection.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SupervisorReportsScreen extends StatefulWidget {
  @override
  SupervisorReportsScreenState createState() => SupervisorReportsScreenState();
}

class SupervisorReportsScreenState extends State<SupervisorReportsScreen> {

  String? _fromdate ;
  DateTime? _fromDateInt;
  String _todate = "اختر";
  DateTime? _toDateInt;
  var date = DateTime.now();
  int userId = 0;
  int? connectionId ;
  int? mandopId ;
  static TextEditingController controllerQuantity = new TextEditingController();
  static TextEditingController controllerDesc = new TextEditingController();
  List<ProductModel>myProductsList =[];
  String empPic='';

  final List<DropdownMenuItem> items = [];

  String txt = 'Click Here';
  TextEditingController editingController = TextEditingController();
  List<SupervisorData> supervisorDataList = [];
  int? prounchID;
  List<SupervisorData> _results = [];
  void _handleSearch(String input) {
    _results.clear();
    _results = supervisorDataList.where((e) =>
        e.mandopName!.toLowerCase().contains(input.toLowerCase())).toList();
    setState(() {});
    calculateTotal();
  }


  Future<void> getAllList() async {
    print("__________________");
    SupervisorInvoicesRequestModel model =SupervisorInvoicesRequestModel(
        prounchID: prounchID,connectionId: connectionId,boxid: 0,all: true,
        fromDate: _fromdate,toDate: _todate,tafsily:3,userID: userId,
        mandopID: mandopId
    );
    SupervisorInvoicesResponseModel  supervisorInvoicesResponseModel =
    await ReportsDatasourceImpl(dio:dio).getSupervisorInvoices(model: model);
    supervisorDataList = supervisorInvoicesResponseModel.data??[];
    setState(() {});
    calculateTotal();
  }

  Future<void> printPdf() async {
    SupervisorInvoicesRequestModel model =SupervisorInvoicesRequestModel(
        prounchID: prounchID,connectionId: connectionId,boxid: 0,all: true,
        fromDate: _fromdate,toDate: _todate,tafsily:3,userID: userId,
        mandopID: mandopId,searchKey:editingController.text
    );
    ReportResponseModel  reportModel =
    await ReportsDatasourceImpl(dio:dio).getPdfReport(model: model);
    if(reportModel.data!=null){
      launchUrl(Uri.parse(reportModel.data??''));
    }
  }

  Widget _appBar() {
    return Container(color:AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal:0),
      child: Padding(
        padding: const EdgeInsets.only(top:24),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(AppLocalizations.of(context)!.total_sales ,
                    style: const TextStyle(
                        fontSize: 22,color:Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'regular'
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            if(supervisorDataList.isNotEmpty || _results.isNotEmpty)InkWell(
              onTap:() {
                printPdf();
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: Container(
                    decoration: BoxDecoration(
                      // color: Theme.of(context).backgroundColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xfff8f8f8),
                            blurRadius: 10,
                            spreadRadius: 10),
                      ],
                    ),
                    child:IconButton(onPressed:() {
                      print('object');
                      printPdf();
                      // captureAndGeneratePdf();
                      // generatePdfWithStretchedImage();
                    },icon:Icon(Icons.picture_as_pdf_outlined,color:AppColors.primary,),)
                ),
              ),
            ),

            InkWell(onTap:() {
              Navigator.pop(context);
            },child:Icon(AppLocalizations.of(context)!.localeName=='en'?
            Icons.keyboard_arrow_right_sharp:Icons.keyboard_arrow_left_sharp,color:Colors.white,size:50,),),

          ],
        ),
      ),
    );
  }
  double invTotal=0;
  double discountTotal=0;
  double mardodTotal=0;
  double salesTotal=0;
  calculateTotal(){
    // Calculate totals
    invTotal = (_results.isNotEmpty?_results:supervisorDataList).
    fold(0, (sum, item) => sum + (item.aTotal!=null?item.aTotal:0.0) as double);

    discountTotal = (_results.isNotEmpty?_results:supervisorDataList).
    fold(0, (sum, item) => sum + (item.descountValue!=null?item.descountValue:0.0) as double);

    mardodTotal = (_results.isNotEmpty?_results:supervisorDataList).
    fold(0, (sum, item) => sum + (item.aTotalRturn!=null?item.aTotalRturn:0.0) as double);

    salesTotal = (_results.isNotEmpty?_results:supervisorDataList).
    fold(0, (sum, item) => sum + (item.net!=null?item.net:0.0) as double);
    setState(() {});
  }

  bool selected =false;
  double textSize = 14;

  Widget bodyData() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(width:textSize==14?null:MediaQuery.of(context).size.width*0.99,
      child: DataTable(
          sortColumnIndex: 1,
          sortAscending: true,columnSpacing:0,
          horizontalMargin:0,
          checkboxHorizontalMargin: 0,
          dividerThickness:0,
          showCheckboxColumn: false,
          headingRowColor: WidgetStateProperty.all<Color>(textSize==14?Color(0xE6292D2C).withOpacity(0.7):
          Colors.transparent),
          border:TableBorder(verticalInside:BorderSide(color:Colors.black,width:0.5),
              horizontalInside:BorderSide(color:Colors.black,width:0.5),
              bottom: BorderSide(color:Colors.black,width:0.5),
              top:BorderSide(color:Colors.black,width:0.5),
              left:BorderSide(color:Colors.black,width:0.5),
              right:BorderSide(color:Colors.black,width:0.5)),
          columns: <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(textSize!=14?
                  AppLocalizations.of(context)!.mandop_name.split(" ").
                  sublist(1,AppLocalizations.of(context)!.mandop_name.split(" ").length).join("")
                      :AppLocalizations.of(context)!.mandop_name,
                      style: TextStyle(
                          color:textSize==14?AppColors.white:AppColors.black,
                          fontFamily: 'regular',
                          fontSize:textSize,
                          fontWeight: FontWeight.bold
                      )),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:4),
                    child: Text(textSize!=14?
                    AppLocalizations.of(context)!.inv_total.split(" ").
                    sublist(1,AppLocalizations.of(context)!.inv_total.split(" ").length).join("")
                        :AppLocalizations.of(context)!.inv_total,
                        style: TextStyle(
                            color:textSize==14?AppColors.white:AppColors.black,
                            fontFamily: 'regular',
                            fontSize:textSize,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:4),
                    child: Text(textSize!=14?
                    AppLocalizations.of(context)!.discount_total.split(" ").
                    sublist(1,AppLocalizations.of(context)!.discount_total.split(" ").length).join("")
                        :AppLocalizations.of(context)!.discount_total,
                        style: TextStyle(
                            color: textSize==14?AppColors.white:AppColors.black,
                            fontFamily: 'regular',
                            fontSize:textSize,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:4),
                    child: Text(textSize!=14?
                    AppLocalizations.of(context)!.mardod_value.split(" ").
                    sublist(1,AppLocalizations.of(context)!.mardod_value.split(" ").length).join("")
                        :AppLocalizations.of(context)!.mardod_value,
                        style: TextStyle(
                            color: textSize==14?AppColors.white:AppColors.black,
                            fontFamily: 'regular',
                            fontSize:textSize,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:4),
                    child: Text(textSize!=14?
                    AppLocalizations.of(context)!.total_sales.split(" ").
                    sublist(1,AppLocalizations.of(context)!.total_sales.split(" ").length).join("")
                        :AppLocalizations.of(context)!.total_sales,
                        style: TextStyle(
                            color: textSize==14?AppColors.white:AppColors.black,
                            fontFamily: 'regular',
                            fontSize:textSize,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ),
            ),
          ], rows: [
            ...(_results.isNotEmpty?_results:supervisorDataList).map((row) => DataRow(
              onSelectChanged: (value) {
                if (value??false) {}
              },
              cells: [
                DataCell(
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(row.mandopName!=null?row.mandopName.toString():"",
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    )
                ),
                DataCell(
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(row.aTotal!=null?formatNumber(row.aTotal):"",
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    )
                ),
                DataCell(
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4),
                      child: Text(
                          row.descountValue!=null?formatNumber(row.descountValue):"",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.normal,
                            fontSize:textSize,
                          )),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4),
                      child: Text(row.aTotalRturn!=null?formatNumber(row.aTotalRturn):"",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'regular',
                              fontSize:textSize,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4),
                      child: Text(row.net!=null?formatNumber(row.net):"",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'regular',
                              fontSize:textSize,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                  ),
                ),
              ],
            ),).toList(),
            DataRow(cells:[
              DataCell(
                Container(color:AppColors.black,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4),
                      child: Text(AppLocalizations.of(context)!.total_sales,
                          style: TextStyle(
                              color:AppColors.white,
                              fontFamily: 'regular',
                              fontSize:textSize,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                  ),
                ),
              ),
              DataCell(
                  Container(color:Colors.black12,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(formatNumber(invTotal),
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                  )
              ),
              DataCell(
                  Container(color:Colors.black12,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(formatNumber(discountTotal),
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                  )
              ),
              DataCell(
                  Container(color:Colors.black12,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(formatNumber(mardodTotal),
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                  )
              ),
              DataCell(
                  Container(color:Colors.black12,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:4),
                        child: Text(formatNumber(salesTotal),
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'regular',
                                fontSize:textSize,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                  )
              ),
            ])
          ]),
    ),
  );

  final GlobalKey _repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    setState(() {
      _fromdate  = _todate = getFormattedDate(DateTime.now());
      connectionId=SharedPrefHelper.sp.getInt('connectionId')??0;
      mandopId=SharedPrefHelper.sp.getInt('mandopId')??0;
      prounchID=SharedPrefHelper.sp.getInt('prounchID')??0;
      userId=SharedPrefHelper.sp.getInt('userId')??0;
      getAllList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:const Size(0,70),
      child:_appBar(),),
        resizeToAvoidBottomInset: false,
        backgroundColor:Colors.white,
        body: Column(
          children: [
            const SizedBox(height:20,),
            Flexible(child: RepaintBoundary(
              key: _repaintKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:700, // Adjust according to your needs
                  maxWidth:MediaQuery.of(context).size.width,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.only(top: 0,right:textSize==14?16:0,left:textSize==14?16:0,bottom: 30),
                        child:Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(children: [
                                Column(mainAxisSize:MainAxisSize.min,mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.start,children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.from} :  ',
                                      style: TextStyle(
                                          fontFamily: 'regular',
                                          fontSize: 16.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    const SizedBox(height:30,),
                                    Text(AppLocalizations.of(context)!.language=='en'?
                                    '${AppLocalizations.of(context)!.to}:':
                                    '${AppLocalizations.of(context)!.to} :',
                                      style: const TextStyle(
                                          fontFamily: 'regular',
                                          fontSize: 16.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],),
                                Column(mainAxisSize:MainAxisSize.min,mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.start,children: [
                                    SizedBox(width:MediaQuery.sizeOf(context).width*0.70,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 4,
                                              padding:EdgeInsets.symmetric(horizontal: 4),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  side: BorderSide(color: AppColors.primary))
                                          ),
                                          onPressed: () async {
                                            DateTime? startPickedDate = await showDatePicker(
                                                context: context,
                                                initialDate:DateTime.now(),
                                                firstDate:DateTime(2000),
                                                lastDate: DateTime(2100),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(
                                                      colorScheme: ColorScheme.light(
                                                        primary:AppColors.primary, // header background color
                                                        onPrimary: Colors.white, // header text color
                                                        // onSurface: Colors.green, // body text color
                                                      ),
                                                      textButtonTheme: TextButtonThemeData(
                                                        style: TextButton.styleFrom(
                                                          foregroundColor:AppColors.primary, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                });
                                            if(startPickedDate!= null){
                                              _fromdate = getFormattedDate(startPickedDate);
                                              setState(() {});
                                              // print('date>>'+date.toString());
                                            }
                                          },
                                          child: Container(padding:EdgeInsets.only(top:8,bottom:4),
                                            alignment: Alignment.center,
                                            child: Text(
                                              _fromdate ??AppLocalizations.of(context)!.select,
                                              style: TextStyle(color:
                                              Colors.black,
                                                fontFamily: 'regular',
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height:10,),
                                    SizedBox(width:MediaQuery.sizeOf(context).width*0.70,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 4,
                                              padding:EdgeInsets.symmetric(horizontal: 4),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  side: BorderSide(color: AppColors.primary))
                                          ),
                                          onPressed: () async {
                                            DateTime? startPickedDate = await showDatePicker(
                                                context: context,
                                                initialDate:DateTime.now(),
                                                firstDate:DateTime(2000),
                                                lastDate: DateTime(2100),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(
                                                      colorScheme: ColorScheme.light(
                                                        primary:AppColors.primary, // header background color
                                                        onPrimary: Colors.white, // header text color
                                                        // onSurface: Colors.green, // body text color
                                                      ),
                                                      textButtonTheme: TextButtonThemeData(
                                                        style: TextButton.styleFrom(
                                                          foregroundColor:AppColors.primary, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                });
                                            if(startPickedDate!= null){
                                              _todate = getFormattedDate(startPickedDate);
                                              setState(() {});
                                              // print('date>>'+date.toString());
                                            }
                                          },
                                          child: Container(padding:EdgeInsets.only(top:8,bottom:4),
                                              alignment: Alignment.center,
                                              child: Container(
                                                child: Text(
                                                  "$_todate",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'regular',
                                                      fontSize: 16.0),
                                                ),
                                              )
                                          ),
                                        )),
                                  ],),
                              ],),


                              if(textSize==14) Padding(
                                padding: const EdgeInsets.only(top:0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 4,
                                      padding:EdgeInsets.symmetric(horizontal:40,vertical:10),
                                      backgroundColor:AppColors.primary,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          side: BorderSide(color:AppColors.primary))
                                  ),
                                  onPressed: () {
                                    if(_fromdate!=null&&_todate!=null){
                                      getAllList();
                                    }else{
                                      showMessage(context,"يرجي اكمال البيانات",isFail:true);
                                    }

                                  },
                                  child:Text(AppLocalizations.of(context)!.search,style: TextStyle(
                                      fontFamily:'regular',fontSize:13.0,color:Colors.white)),
                                ),
                              ),
                              if(textSize==14)Divider(color: Colors.white,thickness: 0.4,),
                              if(textSize==14) SizedBox(
                                height:55,
                                child: TextField(enableSuggestions:true,
                                  textAlign:TextAlign.center,
                                  controller:editingController,
                                  style:TextStyle(
                                      fontFamily: 'regular', fontSize: 16,
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold),
                                  onChanged:_handleSearch,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xfff1f1f1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText:AppLocalizations.of(context)!.mandop_name,
                                    hintStyle:TextStyle(
                                        fontFamily: 'regular', fontSize: 16,
                                        fontWeight: FontWeight.w100),
                                    prefixIcon: const Icon(Icons.search),
                                    prefixIconColor: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              supervisorDataList!=null&&supervisorDataList.isNotEmpty? bodyData():
                              Container(child:Center(child: Padding(
                                padding: const EdgeInsets.only(top:100),
                                child: Text('لا توجد تقارير',   style: TextStyle(
                                    fontSize:16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'regular'),
                                ),
                              ),),),
                              if(textSize==14)const SizedBox(height:400,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        )

    );
  }


  String getNum(double number){
    String formattedNumber = NumberFormat('#,##0.00', 'en_US').format(number);
    return formattedNumber;
  }

  String formatNumber(dynamic number) {
    // Convert the input to a double
    double value;
    if (number is int) {
      value = number.toDouble();
    } else if (number is double) {
      value = number;
    } else {
      throw ArgumentError('Input must be an int or a double.');
    }

    // Split the number into integer and decimal parts
    List<String> parts = value.toStringAsFixed(2).split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];

    // Format the integer part with commas
    String formattedIntegerPart = integerPart.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    );

    // Combine the formatted integer part with the decimal part
    return '$formattedIntegerPart.$decimalPart';
  }
}


class ImagePreview extends StatelessWidget {
  ImagePreview(this.bytes);
  Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.white,
      body: Image.memory(bytes),);
  }
}

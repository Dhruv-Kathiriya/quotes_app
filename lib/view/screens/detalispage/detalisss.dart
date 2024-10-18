/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:quotes_app/models/quotes_model.dart';
import 'package:quotes_app/utills/fonts_utills.dart';
import 'package:share_extend/share_extend.dart';
import 'dart:ui' as ui;

import '../../../utilis/fontlist.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color containerBGColor = Colors.white;
  double opacity = 1;
  String font = Fonts.lionKing.name;
  Color fontColor = Colors.black;

  GlobalKey widgetKey = GlobalKey();

  Future<void> copyQuote({
    required QuotesModel quote,
  }) async {
    await Clipboard.setData(
      ClipboardData(
        text: "${quote.quotes}\n${quote.author}",
      ),
    ).then(
          (value) {
        SnackBar snackBar = const SnackBar(
          content: Text("Quote copy successfully... "),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    QuotesModel quote =
    ModalRoute.of(context)!.settings.arguments as QuotesModel;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(quote.category),
        backgroundColor: Colors.white70,
        actions: [
          IconButton(
            onPressed: () {
              containerBGColor = Colors.white;
              opacity = 1;
              font = Fonts.lionKing.name;
              fontColor = Colors.black;
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: widgetKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: containerBGColor.withOpacity(opacity),
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SelectableText(
                      quote.quotes,
                      cursorWidth: 2,
                      cursorColor: Colors.red,
                      cursorRadius: const Radius.circular(20),
                      showCursor: false,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: false,
                        selectAll: true,
                      ),
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 25.sp,
                        fontFamily: font,
                      ),
                    ),
                    Text(
                      "~ ${quote.author}",
                      style: TextStyle(
                        fontFamily: font,
                        color: fontColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BackGround Color : ",
                    style: GoogleFonts.nobile(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 18,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            containerBGColor = Colors.primaries[index];
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 30.w,
                            backgroundColor: Colors.primaries[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Color Opacity : ",
                    style: GoogleFonts.nobile(
                      fontSize: 14.sp,
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: 1,
                    activeColor: containerBGColor.withOpacity(opacity),
                    value: opacity,
                    onChanged: (val) {
                      opacity = val;
                      setState(() {});
                    },
                  ),
                  Text(
                    "Fonts : ",
                    style: GoogleFonts.nobile(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Fonts.values.length,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              font = Fonts.values[index].name;
                              setState(() {});
                            },
                            child: Text(
                              "Abc",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: Fonts.values[index].name,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Fonts Color : ",
                        style: GoogleFonts.nobile(
                          fontSize: 14.sp,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Pick a color!',
                                  style: GoogleFonts.roboto(),
                                ),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: containerBGColor,
                                    onColorChanged: (value) {
                                      fontColor = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.color_lens_outlined,
                            color: fontColor,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => copyQuote(
                            quote: quote,
                          ),
                          icon: const Icon(Icons.copy),
                          label: Text(
                            "Copy",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            RenderRepaintBoundary boundary =
                            widgetKey.currentContext?.findRenderObject()
                            as RenderRepaintBoundary;

                            ui.Image image = await boundary.toImage();

                            ByteData? byteData = await image.toByteData(
                              format: ui.ImageByteFormat.png,
                            );

                            Uint8List list = byteData!.buffer.asUint8List();

                            var result = await ImageGallerySaver.saveImage(
                              list,
                              quality: 60,
                              name: quote.category,
                            );

                            if (result['isSuccess']) {
                              SnackBar snackBar = const SnackBar(
                                content: Text("Image Save Successfully"),
                                backgroundColor: Colors.green,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              SnackBar snackBar = const SnackBar(
                                content: Text("Image Save Fail"),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            log("Image Result : $result");
                            log("Image Result : ${result['isSuccess']}");
                          },
                          icon: const Icon(Icons.download),
                          label: Text(
                            "Save Gallery",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                   */
/*   Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            widgetKey.currentContext.findRenderObject();
                            ShareExtend.share(, "image");
                          },
                          icon: const Icon(Icons.share),
                          label: Text(
                            "Share",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),*/ /*

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

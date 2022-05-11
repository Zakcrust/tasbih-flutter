import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasbih_flutter/consts.dart';
import 'package:tasbih_flutter/hive_objects/list_dzikir.dart';
import 'package:tasbih_flutter/utils/general_tool.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListDzikir dzikir = ListDzikir(dzikir: []);
  late String dzikirDropdown;
  late Dzikir selectedDzikir;

  String ADD = 'add';
  String EDIT = 'edit';

  @override
  void initState() {
    dzikir = GeneralTool.currentListDzikr;
    dzikirDropdown = dzikir.dzikir.first.name;
    selectedDzikir = dzikir.dzikir.first;
    super.initState();
  }

  void saveDzikrData() async {
    GeneralTool().saveData('dzikr_list', jsonEncode(dzikir));
  }

  void profileDialog(String option) async {
    String? nama = option == ADD ? "" : selectedDzikir.name;
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = option == ADD ? "" : nama;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.01),
                  child: Text(
                    option == ADD
                        ? "Tambah Profil Bacaan"
                        : "Edit Profil Bacaan",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Bacaan : ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Container(
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        controller: textEditingController,
                        onChanged: (value) {
                          nama = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: const Center(
                            child: Text("Batal",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          if (option == ADD) {
                            setState(() {
                              dzikir.dzikir.add(Dzikir(name: nama!, count: 0));
                            });
                          }
                          if (option == EDIT) {
                            dzikirDropdown = nama!;
                            setState(() {
                              selectedDzikir.name = nama!;
                            });
                          }
                          saveDzikrData();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: const Center(
                            child: Text("Simpan",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: backgroundColor),
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.05),
                        // width: MediaQuery.of(context).size.width * 0.6,
                        // height: MediaQuery.of(context).size.height * 0.06,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        // child: Text(selectedDzikir.name,
                        //     softWrap: true,
                        //     style: const TextStyle(color: Colors.white)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            alignment: Alignment.centerLeft,
                            icon: Image.asset(
                                "assets/images/dropdown_pointer.png"),
                            dropdownColor: backgroundColor,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            // underline: Container(),
                            value: dzikirDropdown,
                            items: dzikir.dzikir
                                .map((e) => DropdownMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Text(e.name,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                                onPressed: () {
                                                  profileDialog(EDIT);
                                                },
                                                icon: SvgPicture.asset(
                                                    "assets/images/edit_icon.svg")),
                                          )
                                        ],
                                      ),
                                      value: e.name,
                                    ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dzikirDropdown = value!;
                              });
                              for (Dzikir item in dzikir.dzikir) {
                                if (item.name == value) {
                                  setState(() {
                                    selectedDzikir = item;
                                  });
                                  break;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: MediaQuery.of(context).size.width * 0.1,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: () {
                              profileDialog(ADD);
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        selectedDzikir.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Text(
                      selectedDzikir.count.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.6),
                child: SizedBox(
                  height: 84,
                  width: 84,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedDzikir.count = 0;
                        });
                      },
                      icon: Image.asset("assets/images/reset-button.png")),
                ),
              ),
              SizedBox(
                height: 194,
                width: 194,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedDzikir.count++;
                        saveDzikrData();
                      });
                    },
                    icon: Image.asset("assets/images/button-tasbih.png")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

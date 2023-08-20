import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? dropdownvalueh = "ft";
  String? dropdownvaluew = "kg";
  TextEditingController heightController = TextEditingController();
  TextEditingController footController = TextEditingController();
  TextEditingController inchController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Queue<String> queue = Queue<String>();
  Queue<String> heiq = Queue<String>();
  Queue<String> weiq = Queue<String>();
  Queue<String> bmiq = Queue<String>();
  Queue<String> catq = Queue<String>();
  List dep = List.empty();
  Color hisc = Color.fromARGB(0, 0, 0, 0);
  double? height,
      foot = 0.0,
      inch = 0.0,
      weight,
      bmi,
      diffCalc,
      pwq,
      foop,
      heigp;
  String? res, category, difference;
  bool showChart = false,
      showHist = false,
      youAreSUnderW = false,
      youAreUWeight = false,
      youAreNormal = false,
      youAreOWeight = false,
      youAreObese = false;
  void calc(value) {
    height == null ? height = 0 : height = height;
    weight == null ? weight = 0 : weight = weight;

    setState(() {
      bmi = double.parse((weight! / height!).toStringAsPrecision(2));

      if (bmi! <= 16.9) {
        youAreSUnderW = true;
        youAreUWeight = youAreNormal = youAreOWeight = youAreObese = false;
        category = "Severly Under Weight";

        difference = "Gain more weight";
      } else if (bmi! >= 17.0 && bmi! <= 18.4) {
        youAreUWeight = true;
        youAreSUnderW = youAreNormal = youAreOWeight = youAreObese = false;
        category = "Under Weight";
        difference = "Gain some weight";
      } else if (bmi! >= 18.5 && bmi! <= 24.9) {
        youAreNormal = true;
        youAreSUnderW = youAreUWeight = youAreOWeight = youAreObese = false;
        category = "Normal";
        difference = "✓ You're Perfect";
      } else if (bmi! >= 25.0 && bmi! <= 29.9) {
        youAreOWeight = true;
        youAreSUnderW = youAreUWeight = youAreNormal = youAreObese = false;
        category = "Over Weight";
        difference = "Get on a diet";
      } else if (bmi! >= 30.0) {
        category = "Obese";
        difference = "Loose Your Weight";
        youAreObese = true;
        youAreSUnderW = youAreUWeight = youAreNormal = youAreOWeight = false;
      } else {
        youAreSUnderW =
            youAreUWeight = youAreNormal = youAreOWeight = youAreObese = false;
        category = "...";
        difference = "...";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    category == null ? category = "..." : category = category;
    difference == null ? difference = "..." : difference = difference;
    bmi == null ? bmi = 0 : bmi = bmi;
    double bmiPointer = bmi!;
    if (bmiPointer > 40) bmiPointer = 40.0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'static/humanheight.png',
                  height: 35,
                  width: 35,
                ),
                dropdownvalueh == "ft"
                    ? SizedBox(
                        width: 165,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: footController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    footController.text.isEmpty
                                        ? foot = 0.0
                                        : foot =
                                            double?.parse(footController.text);
                                    height = foot! / 3.2808;
                                    height = height! * height!;
                                    // calc(value);
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Foot(')",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.blue),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              const Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 5.0)),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: inchController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    double? oldValue = inch;
                                    inchController.text.isEmpty
                                        ? inch = 0.0
                                        : inch =
                                            double.parse(inchController.text);
                                    foop = foot;
                                    foot = foot! + inch! / 12 - oldValue! / 12;
                                    height = foot! / 3.2808;
                                    height = height! * height!;
                                    // calc(value);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Inch(")',
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.blue),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              )
                            ]),
                      )
                    : SizedBox(
                        width: 130,
                        child: TextField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            heightController.text.isEmpty
                                ? height = 0.0
                                : height = double?.parse(heightController.text);
                            heigp = height;
                            dropdownvalueh == "cm"
                                ? height = height! / 100
                                : height = height;
                            height = height! * height!;
                            // calc(value);
                          },
                          decoration: InputDecoration(
                              labelText: dropdownvalueh == "m"
                                  ? 'Height(m)'
                                  : 'Height(cm)',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 32, 31, 31),
                  value: dropdownvalueh,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ["ft", "cm", "m"].map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalueh = newValue;
                      bmi = null;
                      heightController.text =
                          footController.text = inchController.text = "";
                    });
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'static/weight.png',
                  height: 35,
                  width: 35,
                ),
                dropdownvaluew == "kg"
                    ? SizedBox(
                        width: 130,
                        child: TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Weight(kg)",
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) {
                            weightController.text.isEmpty
                                ? weight = 0.0
                                : weight = double.parse(weightController.text);
                            pwq = weight;
                            // calc(value);
                          },
                        ),
                      )
                    : SizedBox(
                        width: 130,
                        child: TextField(
                          controller: weightController,
                          onChanged: (value) {
                            weightController.text.isEmpty
                                ? weight = 0.0
                                : weight = double.parse(weightController.text);
                            pwq = weight;
                            weight = weight! / 2.2046;
                            // calc(value);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Weight(lb)',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 32, 31, 31),
                  value: dropdownvaluew,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ["kg", "lb"].map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvaluew = newValue;
                      weightController.text = "";
                      bmi = null;
                    });
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(12.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      calc(1);
                      queue.add("$height $weight $bmi $category");
                      if (dropdownvalueh == "ft")
                        heiq.add("$foop" + '"' + " $inch'");
                      else if (dropdownvalueh == "cm")
                        heiq.add("$heigp cm");
                      else
                        heiq.add("$heigp m");

                      if (dropdownvaluew == "kg")
                        weiq.add("$pwq kg");
                      else
                        weiq.add("$pwq lb");

                      bmiq.add("$bmi");
                      catq.add("$category");
                      if (queue.length == 11) {
                        queue.removeFirst();
                        heiq.removeFirst();
                        weiq.removeFirst();
                        bmiq.removeFirst();
                        catq.removeFirst();
                      }
                    },
                    child: const Text("Calculate"))
              ],
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  height: 20.0,
                  indent: 5.0,
                  color: Color.fromARGB(255, 32, 31, 31),
                )),
            SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  minimum: 0,
                  maximum: 40,
                  axisLineStyle: const AxisLineStyle(
                      thickness: 20, cornerStyle: CornerStyle.bothCurve),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: 18.5,
                      color: Colors.blue.shade200,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 25,
                      color: Colors.green.shade200,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                    GaugeRange(
                      startValue: 25,
                      endValue: 40,
                      color: Colors.red.shade200,
                      startWidth: 20,
                      endWidth: 20,
                    )
                  ],
                  pointers: <GaugePointer>[
                    bmiPointer <= 18.5
                        ? RangePointer(
                            color: Colors.blue.shade900,
                            value: bmiPointer,
                            width: 20,
                          )
                        : bmiPointer <= 25.0
                            ? RangePointer(
                                color: Colors.green.shade900,
                                value: bmiPointer,
                                width: 20,
                              )
                            : RangePointer(
                                color: Colors.red.shade900,
                                value: bmiPointer,
                                width: 20,
                              ),
                    bmiPointer <= 18.5
                        ? MarkerPointer(
                            value: bmiPointer,
                            color: Colors.blue.shade900,
                            offsetUnit: GaugeSizeUnit.factor,
                            markerType: MarkerType.circle,
                            markerHeight: 20,
                            markerWidth: 20,
                          )
                        : bmiPointer <= 25.0
                            ? MarkerPointer(
                                value: bmiPointer,
                                color: Colors.green.shade900,
                                offsetUnit: GaugeSizeUnit.factor,
                                markerType: MarkerType.circle,
                                markerHeight: 20,
                                markerWidth: 20,
                              )
                            : MarkerPointer(
                                value: bmiPointer,
                                color: Colors.red.shade900,
                                offsetUnit: GaugeSizeUnit.factor,
                                markerType: MarkerType.circle,
                                markerHeight: 20,
                                markerWidth: 20,
                              ),
                    bmiPointer <= 18.5
                        ? MarkerPointer(
                            value: 0,
                            color: Colors.blue.shade900,
                            offsetUnit: GaugeSizeUnit.factor,
                            markerType: MarkerType.circle,
                            markerHeight: 20,
                            markerWidth: 20,
                          )
                        : bmiPointer <= 25.0
                            ? MarkerPointer(
                                value: 0,
                                color: Colors.green.shade900,
                                offsetUnit: GaugeSizeUnit.factor,
                                markerType: MarkerType.circle,
                                markerHeight: 20,
                                markerWidth: 20,
                              )
                            : MarkerPointer(
                                value: 0,
                                color: Colors.red.shade900,
                                offsetUnit: GaugeSizeUnit.factor,
                                markerType: MarkerType.circle,
                                markerHeight: 20,
                                markerWidth: 20,
                              ),
                    bmiPointer == 40.0
                        ? const MarkerPointer(
                            value: 40,
                            color: Colors.red,
                            offsetUnit: GaugeSizeUnit.factor,
                            markerType: MarkerType.circle,
                            markerHeight: 20,
                            markerWidth: 20,
                          )
                        : MarkerPointer(
                            value: 40,
                            color: Colors.red.shade200,
                            offsetUnit: GaugeSizeUnit.factor,
                            markerType: MarkerType.circle,
                            markerHeight: 20,
                            markerWidth: 20,
                          ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Column(children: [
                          const Padding(
                              padding: EdgeInsetsDirectional.only(top: 150)),
                          const Text('Bmi:', style: TextStyle(fontSize: 13)),
                          const Padding(
                              padding: EdgeInsetsDirectional.only(top: 3)),
                          Text('$bmi',
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ]),
                        angle: 90,
                        positionFactor: 0.1)
                  ])
            ]),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  height: 20.0,
                  indent: 5.0,
                  color: Color.fromARGB(255, 32, 31, 31),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Suggestion",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Padding(padding: EdgeInsetsDirectional.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$category",
                ),
                Text(
                  "$difference",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  height: 20.0,
                  indent: 5.0,
                  color: Color.fromARGB(255, 32, 31, 31),
                )),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (showChart) {
                  showChart = false;
                } else {
                  showChart = true;
                }
                setState(() {
                  showChart;
                });
              },
              child: Row(
                children: [
                  showChart == true
                      ? const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                        ),
                  const Text("BMI Chart")
                ],
              ),
            ),
            Visibility(
              visible: showChart,
              child: Row(
                children: [
                  const Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(""),
                      Text(
                        "Severly Underweight",
                        style: youAreSUnderW
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "UnderWeight",
                        style: youAreUWeight
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "Normal",
                        style: youAreNormal
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "Overweight",
                        style: youAreOWeight
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "Obese",
                        style: youAreObese
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsetsDirectional.only(start: 160.0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(""),
                      Text(
                        "<=16.9",
                        style: youAreSUnderW
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "17.0-18.4",
                        style: youAreUWeight
                            ? const TextStyle(color: Colors.blueAccent)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "18.5-24.9",
                        style: youAreNormal
                            ? const TextStyle(color: Colors.greenAccent)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "25.0-29.9",
                        style: youAreOWeight
                            ? const TextStyle(color: Colors.redAccent)
                            : const TextStyle(color: Colors.white),
                      ),
                      const Text(""),
                      Text(
                        "≥30.0",
                        style: youAreObese
                            ? const TextStyle(color: Colors.red)
                            : const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  height: 20.0,
                  indent: 5.0,
                  color: Color.fromARGB(255, 32, 31, 31),
                )),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (showHist) {
                  showHist = false;
                } else {
                  showHist = true;
                }
                setState(() {
                  showHist;
                });
              },
              child: Row(
                children: [
                  showHist == true
                      ? const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                        ),
                  const Text("History")
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Visibility(
              visible: showHist,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.0)),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: const Color.fromRGBO(255, 163, 26, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              "Height",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "Weight",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "Bmi",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "  ",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "Condition",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "  ",
                              style: TextStyle(fontSize: 21.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: queue.length,
                      itemBuilder: (BuildContext context, int index) {
                        final hist = queue.toList().reversed.toList();
                        final hiep = heiq.toList().reversed.toList();
                        final weip = weiq.toList().reversed.toList();
                        final bmip = bmiq.toList().reversed.toList();
                        final catp = catq.toList().reversed.toList();
                        return ListTile(
                            title: Container(
                          padding: EdgeInsets.all(10.0),
                          color: catp[index] == "Severly Under Weight"
                              ? Colors.blue
                              : catp[index] == "Normal"
                                  ? Colors.green
                                  : catp[index] == "Under Weight"
                                      ? Colors.blueAccent
                                      : catp[index] == "Over Weight"
                                          ? Colors.redAccent
                                          : catp[index] == "Obese"
                                              ? Colors.red
                                              : Colors.orange,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [Text("${hiep[index]}")],
                                ),
                                Column(
                                  children: [Text("${weip[index]}")],
                                ),
                                Column(
                                  children: [Text("${bmip[index]}")],
                                ),
                                Column(
                                  children: [Text("${catp[index]}")],
                                )
                              ]),
                        ));
                      }),
                  const Padding(padding: EdgeInsets.all(12.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

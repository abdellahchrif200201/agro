import 'package:devti_agro/features/tracability/presontaion/screens/colieData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    Key? key,
    required this.colieDataItem,
    required this.outputDate,
    this.givenMarg,
    this.fromSource,
  }) : super(key: key);

  final String? fromSource;
  final ColieData colieDataItem;
  final EdgeInsetsGeometry? givenMarg;
  final String outputDate;

  @override
  Widget build(BuildContext context) {
    // bool isLocaleSetToArabic = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: givenMarg ?? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      // height: 100,
      alignment: Alignment.center,
      // height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 145, 145, 145),
            offset: Offset(
              0.0,
              4.0,
            ),
            blurRadius: 8.0, // Adjust the blur radius for a softer or sharper shadow
            spreadRadius: 0.0, // Adjust the spread radius if needed
          ), //BoxShadow
        ],
        color: Colors.white,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          
          child: Row(
            children: [
              SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colieDataItem.etat == 'In'
                                        ? Colors.green
                                        : colieDataItem.etat == 'Out'
                                            ? Colors.red
                                            : Colors.blue,
                                    width: 2.0,
                                  ),
                                  // color: Colors.green[50], //Theme.of(context).primaryColor,

                                  color: (colieDataItem.etat == 'In'
                                      ? Colors.green
                                      : colieDataItem.etat == 'Out'
                                          ? Colors.red
                                          : Colors.blue)[50],
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  colieDataItem.etat == 'In'
                                      ? Icons.arrow_upward
                                      : colieDataItem.etat == 'Out'
                                          ? Icons.arrow_downward
                                          : Icons.loop,
                                  color: colieDataItem.etat == 'In'
                                      ? Colors.green
                                      : colieDataItem.etat == 'Out'
                                          ? Colors.red
                                          : Colors.blue,
                                  size: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  colieDataItem.etat == 'In'
                                      ? "In".tr
                                      : colieDataItem.etat == 'Out'
                                          ? "Out".tr
                                          : "Returned".tr,
                                  style: TextStyle(
                                    color: colieDataItem.etat == 'In'
                                        ? Colors.green
                                        : colieDataItem.etat == 'Out'
                                            ? Colors.red
                                            : Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 2.0,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Product".tr),
                                const TextSpan(text: " - "),
                                TextSpan(
                                  text: colieDataItem.referenceColie,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12.0,
                            ),
                          ),
                          if (colieDataItem.prix != null)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Price".tr),
                                  const TextSpan(text: " - "),
                                  TextSpan(
                                    text: "${(colieDataItem.prix! ~/ 1).toString()} DH",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 12.0,
                              ),
                            ),
                          if (colieDataItem.fournisseur != null)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Supplier".tr),
                                  const TextSpan(text: " - "),
                                  TextSpan(
                                    text: colieDataItem.fournisseur!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (colieDataItem.quantiteRetour != null)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "quantite".tr),
                                  const TextSpan(text: " - "),
                                  TextSpan(
                                    text: colieDataItem.quantiteRetour.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${'Date added'.tr} $outputDate",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w800,
                            color: Colors.grey,
                            fontSize: 11.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

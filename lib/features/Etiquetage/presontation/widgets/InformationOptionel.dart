
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:flutter/material.dart';



class Informationoptionel extends StatefulWidget {
  const Informationoptionel({super.key});

  @override
  State<Informationoptionel> createState() => _InformationoptionelState();
}

class _InformationoptionelState extends State<Informationoptionel> {
  bool showDLC = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          ' information optionel',
          style:  Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color(0xffedede9),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                // Adjusts the row's width to the content's width
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showDLC = true;
                      });
                    },
                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),

                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("DLC",  style:  Theme.of(context).textTheme.titleSmall,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showDLC = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child:  Text("DDM", style:  Theme.of(context).textTheme.titleSmall,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        showDLC ?  Column(
          children: [
            const FormElement(hint: "N de lot",label: "N de lot",),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 2, // Adjusts the width ratio of the label text
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Stockage",
                      style:  Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.add),
                    Text("choisiessez un  emplacment" ,  style:  Theme.of(context).textTheme.titleSmall,)
                  ],
                )                   ],
            ),
          ],
        ): const Text("data"),

      ],
    );
  }
}

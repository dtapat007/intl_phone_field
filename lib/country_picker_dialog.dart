import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/helpers.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final String languageCode;

  const CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    // final width = widget.style?.width ?? mediaWidth;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 24.0;
    return Dialog(

      insetPadding: const EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: 16,),
          // horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
          //     ? (mediaWidth - width) / 2
          //     : defaultHorizontalPadding),

      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ///search field
            // Padding(
            //   padding: widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
            //   child: TextField(
            //     cursorColor: widget.style?.searchFieldCursorColor,
            //     decoration: widget.style?.searchFieldInputDecoration ??
            //         InputDecoration(
            //           suffixIcon: IconButton(
            //             onPressed: () {
            //               // Handle suffix icon button press
            //             },
            //             icon: Image.asset(
            //               'assets/test/search.png',
            //               // width: 20, // Adjust the width as per your requirement
            //               // height: 20, // Adjust the height as per your requirement
            //             ),
            //           ),
            //           // suffixIcon: const Icon(Icons.search),
            //           // labelText: widget.searchText,
            //           hintText: widget.searchText,
            //         ),
            //     onChanged: (value) {
            //       _filteredCountries = widget.countryList.stringSearch(value)
            //         ..sort(
            //           (a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
            //         );
            //       if (mounted) setState(() {});
            //     },
            //   ),
            // ),
            // const SizedBox(height: 5),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: _filteredCountries.length,
            //     itemBuilder: (ctx, index) => Column(
            //       children: <Widget>[
            //         // ListTile(
            //         //   leading: kIsWeb
            //         //       ? Image.asset(
            //         //           'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
            //         //           package: 'intl_phone_field',
            //         //           width: 32,
            //         //         )
            //         //       : Text(
            //         //           _filteredCountries[index].flag,
            //         //           style: const TextStyle(fontSize: 18),
            //         //         ),
            //         //   contentPadding: widget.style?.listTilePadding,
            //         //   title: RichText(
            //         //     text: TextSpan(
            //         //       style: DefaultTextStyle.of(context).style,
            //         //       children: [
            //         //         TextSpan(
            //         //           text: '${_filteredCountries[index].localizedName(widget.languageCode)} ',
            //         //           style: const TextStyle(
            //         //             fontWeight: FontWeight.w400,
            //         //             fontSize: 14,
            //         //             fontFamily: 'Futura LT Pro Book',
            //         //           ),
            //         //         ),
            //         //         TextSpan(
            //         //           text: '  +${_filteredCountries[index].dialCode}',
            //         //           style: const TextStyle(
            //         //             fontWeight: FontWeight.w300,
            //         //             fontSize: 13,
            //         //             color: Color(0xFF999999),
            //         //             fontFamily: 'Futura LT Pro Book',
            //         //           ),
            //         //         ),
            //         //       ],
            //         //     ),
            //         //   ),
            //         //   //
            //         //   // title: Text(
            //         //   //   '${_filteredCountries[index].localizedName(widget.languageCode)}  +${_filteredCountries[index].dialCode}',
            //         //   //   style: widget.style?.countryNameStyle ?? const TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Futura LT Pro Book,Helvetica',),
            //         //   // ),
            //         //   // trailing: Text(
            //         //   //   '+${_filteredCountries[index].dialCode}',
            //         //   //   style: widget.style?.countryCodeStyle ?? const TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Futura LT Pro Book,Helvetica',),
            //         //   // ),
            //         //   onTap: () {
            //         //     _selectedCountry = _filteredCountries[index];
            //         //     widget.onCountryChanged(_selectedCountry);
            //         //     Navigator.of(context).pop();
            //         //   },
            //         // ),
            //         // removed divider
            //         // widget.style?.listTileDivider ?? const Divider(thickness: 1),
            //         ListTile(
            //           contentPadding: const EdgeInsets.only(left: 10.0),
            //           title: RichText(
            //             text: TextSpan(
            //               style: DefaultTextStyle.of(context).style,
            //               children: [
            //                 WidgetSpan(
            //                   child: kIsWeb
            //                       ? Image.asset(
            //                     'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
            //                     package: 'intl_phone_field',
            //                     width: 32,
            //                   )
            //                       : Text(
            //                     _filteredCountries[index].flag,
            //                     style: const TextStyle(fontSize: 18),
            //                   ),
            //                 ),
            //                 TextSpan(
            //                   text: ' ${_filteredCountries[index].localizedName(widget.languageCode)} ',
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 14,
            //                     fontFamily: 'Futura LT Pro Book',
            //                   ),
            //                 ),
            //                 TextSpan(
            //                   text: ' +${_filteredCountries[index].dialCode}',
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.w300,
            //                     fontSize: 13,
            //                     color: Color(0xFF999999),
            //                     fontFamily: 'Futura LT Pro Book',
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           onTap: () {
            //             _selectedCountry = _filteredCountries[index];
            //             widget.onCountryChanged(_selectedCountry);
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    // Removed commented-out code
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _selectedCountry = _filteredCountries[index];
                          widget.onCountryChanged(_selectedCountry);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: <Widget>[
                            // Country Flag
                            kIsWeb
                                ? Image.asset(
                              'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                              package: 'intl_phone_field',
                              width: 32,
                            )
                                : Text(
                              _filteredCountries[index].flag,
                              style: const TextStyle(fontSize: 18),
                            ),
                            // Country Name
                            Text(
                              ' ${_filteredCountries[index].localizedName(widget.languageCode)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: 'Futura LT Pro Book,Helvetica',
                              ),
                            ),
                            // Dial Code
                            Text(
                              '  +${_filteredCountries[index].dialCode}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: Color(0xFF999999),
                                fontFamily: 'Futura LT Pro Book,Helvetica',
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

          ],
        ),
      ),
    );
  }
}

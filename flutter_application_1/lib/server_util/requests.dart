import 'package:flutter_application_1/server_util/classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var adres = "http://192.168.137.120:8080/api/";

Future<List<Doktor>> doktorGetRequest() async {
  //replace your restFull API here.
  var url = "$adres/doktorlar";
  final response = await http.get(Uri.parse(url));

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<Doktor> doktorlar = [];
  for (var singleDoktor in responseData) {
    Doktor doktor = Doktor(
        doktor_SIFRE: singleDoktor["doktor_SIFRE"],
        doktor_ID: singleDoktor["doktor_ID"],
        doktor_ISIM: singleDoktor["doktor_ISIM"],
        doktor_SOYISIM: singleDoktor["doktor_SOYISIM"],
        doktor_MAIL: singleDoktor["doktor_MAIL"],
        doktor_AnaBilim: singleDoktor['doktor_AnaBilim'],
        doktor_calistigiKurum: singleDoktor['doktor_calistigiKurum'],
        doktor_mezunOkul: singleDoktor['doktor_mezunOkul'],
        doktor_uzmanliklar: singleDoktor['doktor_uzmanliklar']);
    //Adding user to the list.
    doktorlar.add(doktor);
  }
  return doktorlar;
}

Future<List<Hasta>> hastaGetRequest() async {
  //replace your restFull API here.
  var url = "$adres/hastalar";
  final response = await http.get(Uri.parse(url));

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<Hasta> hastalar = [];
  for (var singleHasta in responseData) {
    Hasta hasta = Hasta(
        hasta_SIFRE: singleHasta["hasta_SIFRE"],
        hasta_ID: singleHasta["hasta_ID"],
        hasta_ISIM: singleHasta["hasta_ISIM"],
        hasta_SOYISIM: singleHasta["hasta_SOYISIM"],
        hasta_MAIL: singleHasta["hasta_MAIL"]);
    hastalar.add(hasta);
    //Hastalar listeye eklendi.
  }
  return hastalar;
}

Future<List<Mesaj>> mesajGetRequest() async {
  //replace your restFull API here.
  var url = "$adres/mesajlar";
  final response = await http.get(Uri.parse(url));

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<Mesaj> mesajlar = [];
  for (var singleMesaj in responseData) {
    Mesaj mesaj = Mesaj(
        mesaj_ID: singleMesaj['mesaj_ID'],
        doktor_ID: singleMesaj["doktor_ID"],
        hasta_ID: singleMesaj['hasta_ID'],
        mesaj: singleMesaj['mesaj'],
        eklenti_path: singleMesaj['eklenti_path'],
        tarih: singleMesaj['tarih'],
        yon: singleMesaj['yon']);
    //Adding user to the list.
    mesajlar.add(mesaj);
  }
  return mesajlar;
}

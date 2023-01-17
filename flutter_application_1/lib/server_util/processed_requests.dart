import 'package:flutter_application_1/server_util/classes.dart';
import 'package:flutter_application_1/server_util/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var adres = "http://192.168.137.120:8080/api/";
Future<http.Response> mesajGonderme(
    int doktor_ID, int hasta_ID, String mesaj, int gonderen) async {
  return await http.post(Uri.parse("$adres/mesajlar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'doktor_ID': doktor_ID,
        'hasta_ID': hasta_ID,
        'mesaj': mesaj,
        'yon': gonderen,
        'tarih': DateTime.now().toString()
      }));
}

Future<http.Response> doktorGonder(
    String doktorISIM,
    String doktor_SOYISIM,
    String doktor_MAIL,
    String doktor_SIFRE,
    String doktor_AnaBilim,
    String doktor_mezunOkul,
    String doktor_uzmanliklar,
    String doktor_calistigiKurum) async {
  return await http.post(
      // servere hasta verisi gondermek icin kullanilir
      // kendi basina kullanma, hastaKayit fonksiyonu ile kullan
      Uri.parse("$adres/doktorlar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'doktor_ISIM': doktorISIM,
        'doktor_SOYISIM': doktor_SOYISIM,
        'doktor_SIFRE': doktor_SIFRE,
        'doktor_MAIL': doktor_MAIL,
        'doktor_AnaBilim': doktor_AnaBilim,
        'doktor_mezunOkul': doktor_mezunOkul,
        'doktor_uzmanliklar': doktor_uzmanliklar,
        'doktor_calistigiKurum': doktor_calistigiKurum,
      }));
}

Future<int> doktorKayit(
    {required String doktor_ISIM,
    required String doktor_SOYISIM,
    required String doktor_MAIL,
    required String doktor_SIFRE,
    required String doktor_AnaBilim,
    required String doktor_mezunOkul,
    required String doktor_uzmanliklar,
    required String doktor_calistigiKurum}) async {
  List<Doktor> doktorList = await doktorGetRequest();
  for (var item in doktorList) {
    if (item.doktor_MAIL == doktor_MAIL) {
      return 2;
    }
  }
  await doktorGonder(
      doktor_ISIM,
      doktor_SOYISIM,
      doktor_MAIL,
      doktor_SIFRE,
      doktor_AnaBilim,
      doktor_mezunOkul,
      doktor_uzmanliklar,
      doktor_calistigiKurum);
  return 0;
}

//Hasta ayni maille kayit olurken uyari vermeli
Future<int> hastaKayit(String hastaISIM, String hasta_SOYISIM, String hastaMAIL,
    String hasta_SIFRE) async {
  List<Hasta> hastaList = await hastaGetRequest();
  for (var item in hastaList) {
    if (item.hasta_MAIL == hastaMAIL) {
      return 2;
    }
  }
  await hastaGonder(hastaISIM, hasta_SOYISIM, hastaMAIL, hasta_SIFRE);
  return 0;
}

Future<http.Response> hastaGonder(String hastaISIM, String hastaSOYISIM,
    String hastaMAIL, String hastaSIFRE) async {
  return await http.post(
      // servere hasta verisi gondermek icin kullanilir
      // kendi basina kullanma, hastaKayit fonksiyonu ile kullan
      Uri.parse("$adres/hastalar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'hasta_ISIM': hastaISIM,
        'hasta_SOYISIM': hastaSOYISIM,
        'hasta_SIFRE': hastaSIFRE,
        'hasta_MAIL': hastaMAIL
      }));
}

doktorAyarGorunumu(int doktorID) async {
  List<Doktor> doktorList = await doktorGetRequest();
  var doktor = new Map<dynamic, dynamic>();
  for (var item in doktorList) {
    if (item.doktor_ID == doktorID) {
      return item;
    }
  }
}

hastaAyarGorunumu(int hasta_ID) async {
  List<Hasta> hastaList = await hastaGetRequest();
  for (var item in hastaList) {
    if (item.hasta_ID == hasta_ID) {
      return item;
    }
  }
  throw {"Bu ID de hasta bulunmamaktadir"};
}

Future<http.Response> hastaAyarDegisimi(
    {required int hasta_ID,
    String? hasta_ISIM,
    String? hasta_SOYISIM,
    String? hasta_SIFRE,
    String? hasta_FOTO}) async {
  // hasta girdilerdeki isim soyisim sifre alanlarini bos biraktiysa bu fonksiyonu cagirirken oraya null yaz
  Hasta hasta = await hastaAyarGorunumu(hasta_ID);
  if (hasta_SIFRE == null) {
    hasta_SIFRE = hasta.hasta_SIFRE;
  }
  if (hasta_ISIM == null) {
    hasta_ISIM = hasta.hasta_ISIM;
  }
  if (hasta_SOYISIM == null) {
    hasta_SOYISIM = hasta.hasta_SOYISIM;
  }
  if (hasta_FOTO == null) {
    hasta_FOTO = hasta.hasta_FOTO;
  }
  return http.put(Uri.parse("$adres/hastalar/$hasta_ID"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'hasta_ID': hasta.hasta_ID,
        'hasta_ISIM': hasta_ISIM,
        'hasta_SOYISIM': hasta_SOYISIM,
        'hasta_MAIL': hasta.hasta_MAIL,
        'hasta_SIFRE': hasta_SIFRE,
        'hasta_FOTO': hasta_FOTO
      }));
}

// // yapmayi unutma
Future<http.Response> doktorAyarDegisim(
    {required int doktorID,
    String? doktor_ISIM,
    String? doktor_SOYISIM,
    String? doktor_MAIL,
    String? doktor_SIFRE,
    required String doktor_AnaBilim,
    required String doktor_uzmanliklar,
    required String doktor_calistigiKurum,
    String? doktor_mezunOkul}) async {
  Doktor doktor = await doktorAyarGorunumu(doktorID);

  if (doktor_ISIM == null) {
    doktor_ISIM = doktor.doktor_ISIM;
  }
  if (doktor_SOYISIM == null) {
    doktor_SOYISIM = doktor.doktor_SOYISIM;
  }
  if (doktor_mezunOkul == null) {
    doktor_mezunOkul = doktor.doktor_mezunOkul;
  }
  return http.put(Uri.parse("$adres/doktorlar/$doktorID"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'doktor_ISIM': doktor_ISIM,
        'doktor_SOYISIM': doktor_SOYISIM,
        'doktor_MAIL': doktor_MAIL,
        'doktor_SIFRE': doktor_SIFRE,
        'doktor_mezunOkul': doktor_mezunOkul,
        'doktor_AnaBilim': doktor_AnaBilim,
        'doktor_uzmanliklar':
            doktor.doktor_uzmanliklar + ',' + doktor_uzmanliklar,
        'doktor_calistigiKurum': doktor_calistigiKurum,
      }));
}

Future<List<Mesaj>> mesajEkraniSorgusu(int doktor_ID, int hasta_ID) async {
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
        tarih: singleMesaj['mesaj_tarihi'],
        yon: singleMesaj['yon']);
    //Adding user to the list.
    if (doktor_ID == mesaj.doktor_ID && hasta_ID == mesaj.hasta_ID) {
      mesajlar.add(mesaj);
    }
  }

  return mesajlar;
}

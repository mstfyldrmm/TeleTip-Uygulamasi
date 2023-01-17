import 'package:flutter/material.dart';

import '../../server_util/classes.dart';

class DoctorBox extends StatefulWidget {
  DoctorBox(
      {Key? key,
      required this.index,
      required this.doctor,
      required this.onTap})
      : super(key: key);
  final int index;
  final Doktor doctor;
  final GestureTapCallback onTap;

  @override
  State<DoctorBox> createState() => _DoctorBoxState();
}

class _DoctorBoxState extends State<DoctorBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    height: widget.index.isEven ? 100 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://media.istockphoto.com/id/846700900/tr/vekt%C3%B6r/gen%C3%A7-doktor-stetoskop-ile-izole-vekt%C3%B6r-profesyonel-karakter-vekt%C3%B6rel-%C3%A7izimler.jpg?s=2048x2048&w=is&k=20&c=NZ_PGq8d2Q2VG_nVK8xMTknpVoTbYVUlv2xRis0z5s4="),
                          fit: BoxFit.cover),
                    )),
              ),
              SizedBox(height: 10),
              Text(
                widget.doctor.doktor_ISIM,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                widget.doctor.doktor_SOYISIM,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
              SizedBox(height: 3),
            ],
          )),
    );
  }
}

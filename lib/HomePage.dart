import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'Objeto.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String answer = "";
  TextEditingController _trackingCodeController = TextEditingController();
  void _track() async {

    //ex.: AB123456789BR
    String codigo = "lo457016692cn";

    String envelope =
        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" "
            +"xmlns:res=\"http://resource.webservice.correios.com.br/\"> "
            +"   <soapenv:Header/> "
            +"   <soapenv:Body>  "
            +"      <res:buscaEventosLista> "
            +"         <usuario>ECT</usuario> "
            +"         <senha>SRO</senha>  "
            +"         <tipo>L</tipo>  "
            +"         <resultado>T</resultado>  "
            +"         <lingua>101</lingua> "
            +"         <objetos>"+codigo+"</objetos> "
            +"      </res:buscaEventosLista>  "
            +"   </soapenv:Body> "
            +"</soapenv:Envelope>"
    ;

    final response =
    await http.post("http://webservice.correios.com.br:80/service/rastro",
      headers: {"Content-Type": "text/xml",
      },body: envelope,);

    Objeto objeto = Objeto(xml.parse(response.body).findAllElements("objeto"));


    setState(() {
      if(objeto.erro!=null){
        answer ="Erro: "+objeto.erro;
      }else{
        answer =
            "Número:"+objeto.numero+"\n"
                +"Categoria:"+objeto.categoria+"\n"
                +"Descrição:"+objeto.descricao+"\n"
                +"Data:"+objeto.data+"\n"
                +"Hora:"+objeto.hora+"\n";
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Order",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: SingleChildScrollView(

        child: Container(
          child: Padding(padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Padding(padding: EdgeInsets.only( bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Insert your tracking code',
                  ),
                  enabled: true,
                  // maxLength: 16,
                  //maxLengthEnforced: true,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red

                  ),
                  controller: _trackingCodeController,
                ),
              ),
              ButtonTheme(
                minWidth: double.infinity,

                child:RaisedButton(
                  child: Text(
                    "TRACK",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.amberAccent,

                  onPressed: _track,
                ),
              ),
                Text(answer)
              ],
            ),
          ),
        )
      ),
      ),
    );
  }
}

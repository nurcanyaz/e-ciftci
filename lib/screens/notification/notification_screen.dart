import 'package:flutter/material.dart';
import 'package:e_ciftcim/models/Notification.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirimler"),
      ),
      body: ListView.builder(
        itemCount: 5, // Bildirim sayısı
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications), // Bildirim simgesi
            title: Text("Bildirim Başlığı"), // Bildirim başlığı
            subtitle: Text("Bildirim İçeriği"), // Bildirim içeriği
            trailing: Icon(Icons.arrow_forward_ios), // Detaylar için ileri simgesi
            onTap: () {
              // Bildirim tıklandığında yapılacak işlemler
              // Örneğin, bildirimi görüldü olarak işaretleme veya bildirimi detay sayfasına yönlendirme
            },
          );
        },
      ),
    );
  }
}

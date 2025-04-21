import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KHEN SHOP'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextField(
              // controller: txtSearch,
              decoration: InputDecoration(
                labelText: 'ຄົ້ນຫາ',
                contentPadding: EdgeInsets.symmetric(
                    vertical: 6, horizontal: 12), // Padding ของ TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18), // ขอบมน
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                filled: true, // เปิดการเติมสีพื้นหลัง
                fillColor: Colors.white, // สีพื้นหลังของ TextField
              ),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black), // ขนาดฟอนต์ที่สามารถปรับได้
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Stack(
                children: [
                  Container(
                    color: Colors.amber,
                    height: 400,
                    width: 300,
                    child: Center(
                      child: Text('Video here'),
                    ),
                  ),
                  // ເປີດຄອມເມັ້ນ
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.tealAccent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => CommentSheet(),
                        );
                      },
                      child: Icon(Icons.comment),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Text(
              "100 comments",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text("User $index"),
                  subtitle: Text("This is a comment"),
                ),
              ),
            ),
            // Emoji row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('😃'),Text('😂'),Text('❤️'),Text('😊'),Text('👍'),
              ],
            ),
            // comment input
            Row(
              children: [
                CircleAvatar(radius: 18, backgroundColor: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Add comment...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.send,size: 28,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

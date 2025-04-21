import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KHEN SHOP'),
      ),
      body: Stack(
        children: [
          // วิดีโอหรือภาพพื้นหลัง
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                'Video Here',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),

          // เวลาที่มุมบนซ้าย
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              '22:05',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          // ปุ่มแสดงคอมเมนต์
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 58,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(),
                        title: Text('User $index'),
                        subtitle: Text('Comment $index'),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // แถบ emoji และ input ด้านล่าง
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  CircleAvatar(radius: 15),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.emoji_emotions_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
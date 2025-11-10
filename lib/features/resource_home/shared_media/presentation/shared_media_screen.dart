
import 'package:flutter/material.dart';

class SharedMediaScreen extends StatelessWidget {
  final List<MediaItem> mediaItems = [
    // Today
    MediaItem('assets/art1.jpg', 'ART', 'Today'),
    MediaItem('assets/story1.jpg', 'Story', 'Today'),
    MediaItem('assets/lunch1.jpg', 'Lunch', 'Today'),
    MediaItem('assets/art2.jpg', 'ART', 'Today'),
    MediaItem('assets/art3.jpg', 'ART', 'Today'),
    // Yesterday
    MediaItem('assets/outdoor1.jpg', 'Outdoor', 'Yesterday'),
    MediaItem('assets/art4.jpg', 'ART', 'Yesterday'),
    MediaItem('assets/game1.jpg', 'Game', 'Yesterday'),
    MediaItem('assets/art5.jpg', 'ART', 'Yesterday'),
    MediaItem('assets/story2.jpg', 'Story', 'Yesterday'),
    MediaItem('assets/art6.jpg', 'ART', 'Yesterday'),
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, List<MediaItem>> groupedItems = {};
    for (var item in mediaItems) {
      groupedItems.putIfAbsent(item.date, () => []).add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Media'),
        leading: BackButton(),
        actions: [TextButton(onPressed: () {}, child: Text('Select'))],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search + Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search option...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.filter_list),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Media Grid
            Expanded(
              child: ListView(
                children: groupedItems.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: entry.value.length,
                        itemBuilder: (context, index) {
                          return MediaGridItem(item: entry.value[index]);
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaItem {
  final String imagePath;
  final String tag;
  final String date;

  MediaItem(this.imagePath, this.tag, this.date);
}

class MediaGridItem extends StatelessWidget {
  final MediaItem item;

  const MediaGridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.play_circle_outline,
              size: 16,
              color: Colors.black54,
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          left: 6,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.tag,
              style: TextStyle(
                fontSize: 12,
                color: Colors.purple[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

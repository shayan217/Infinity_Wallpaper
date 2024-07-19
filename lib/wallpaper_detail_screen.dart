// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class WallpaperDetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String photographer;

//   const WallpaperDetailScreen({
//     Key? key,
//     required this.imageUrl,
//     required this.photographer,
//   }) : super(key: key);

//   Future<void> _setWallpaper(BuildContext context, int location) async {
//     try {
//       var file = await DefaultCacheManager().getSingleFile(imageUrl);
//       await WallpaperManager.setWallpaperFromFile(file.path, location);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Wallpaper set successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to set wallpaper: $e')),
//       );
//     }
//   }

//   void _showSetWallpaperOptions(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Set Wallpaper'),
//           content: Text('Where would you like to set this wallpaper?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _setWallpaper(context, WallpaperManager.HOME_SCREEN);
//               },
//               child: Text('Home Screen'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _setWallpaper(context, WallpaperManager.LOCK_SCREEN);
//               },
//               child: Text('Lock Screen'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _setWallpaper(context, WallpaperManager.BOTH_SCREEN);
//               },
//               child: Text('Both'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(photographer),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CachedNetworkImage(
//               imageUrl: imageUrl,
//               placeholder: (context, url) => Center(
//                 child: CircularProgressIndicator(),
//               ),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 300.0,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => _showSetWallpaperOptions(context),
//               icon: Icon(Icons.wallpaper),
//               label: Text('Set as Wallpaper'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 textStyle: TextStyle(fontSize: 18.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class WallpaperDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String photographer;

  const WallpaperDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.photographer,
  }) : super(key: key);

  Future<void> _setWallpaper(BuildContext context, int location) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(imageUrl);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper set successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set wallpaper: $e')),
      );
    }
  }

  // void _showSetWallpaperOptions(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Set Wallpaper', style: TextStyle(fontWeight: FontWeight.bold)),
  //         content: Text('Where would you like to set this wallpaper?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _setWallpaper(context, WallpaperManager.HOME_SCREEN);
  //             },
  //             child: Text('Home Screen'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _setWallpaper(context, WallpaperManager.LOCK_SCREEN);
  //             },
  //             child: Text('Lock Screen'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _setWallpaper(context, WallpaperManager.BOTH_SCREEN);
  //             },
  //             child: Text('Both'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showSetWallpaperOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.wallpaper, color: Colors.deepPurple),
            SizedBox(width: 10),
            Text(
              'Set Wallpaper',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: Text(
          'Where would you like to set this wallpaper?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setWallpaper(context, WallpaperManager.HOME_SCREEN);
            },
            child: Row(
              children: [
                Icon(Icons.home, color: Colors.deepPurple),
                SizedBox(width: 5),
                Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setWallpaper(context, WallpaperManager.LOCK_SCREEN);
            },
            child: Row(
              children: [
                Icon(Icons.lock, color: Colors.deepPurple),
                SizedBox(width: 5),
                Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setWallpaper(context, WallpaperManager.BOTH_SCREEN);
            },
            child: Row(
              children: [
                Icon(Icons.smartphone, color: Colors.deepPurple),
                SizedBox(width: 5),
                Text(
                  'Both',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text(photographer,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(

        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                width: double.infinity,
                // height: 300.0,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _showSetWallpaperOptions(context),
              icon: Icon(Icons.wallpaper,color: Colors.white,),
              label: Text('Set as Wallpaper',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                textStyle: TextStyle(fontSize: 18.0),
                backgroundColor: Colors.deepPurple,
                shadowColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

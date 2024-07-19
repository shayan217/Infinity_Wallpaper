// import 'package:apis_integration/conntroller.dart';
// import 'package:apis_integration/model.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'wallpaper_detail_screen.dart'; // Import the new screen

// class WallpaperScreen extends StatefulWidget {
//   const WallpaperScreen({super.key});

//   @override
//   _WallpaperScreenState createState() => _WallpaperScreenState();
// }

// class _WallpaperScreenState extends State<WallpaperScreen> {
//   List<Wallpaper> _wallpapers = [];
//   int _currentPage = 1;
//   bool _isLoading = false;
//   bool _hasMore = true;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchWallpapers();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         _fetchWallpapers();
//       }
//     });
//   }

//   Future<void> _fetchWallpapers() async {
//     if (_isLoading || !_hasMore) return;
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final List<Wallpaper> newWallpapers =
//           await ApiService.fetchWallpapers(_currentPage);
//       setState(() {
//         _currentPage++;
//         _wallpapers.addAll(newWallpapers);
//         _hasMore = newWallpapers.length == 30;
//       });
//     } catch (e) {
//       // Handle error
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wallpaper App'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: _wallpapers.isEmpty && _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 controller: _scrollController,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: _wallpapers.length + (_hasMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == _wallpapers.length) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   final wallpaper = _wallpapers[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => WallpaperDetailScreen(
//                             imageUrl: wallpaper.src,
//                             photographer: wallpaper.photographer,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       elevation: 4,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: CachedNetworkImage(
//                                 imageUrl: wallpaper.src,
//                                 placeholder: (context, url) =>
//                                     const Center(child: CircularProgressIndicator()),
//                                 errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 wallpaper.photographer,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }






import 'package:apis_integration/conntroller.dart';
import 'package:apis_integration/model.dart';
import 'package:apis_integration/wallpaper_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'wallpaper_detail_screen.dart';
import 'package:apis_integration/conntroller.dart';
import 'package:apis_integration/model.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  List<Wallpaper> _wallpapers = [];
  List<Wallpaper> _filteredWallpapers = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isSearching = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWallpapers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchWallpapers();
      }
    });
    _searchController.addListener(() {
      _filterWallpapers(_searchController.text);
    });
  }

  Future<void> _fetchWallpapers() async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final List<Wallpaper> newWallpapers =
          await ApiService.fetchWallpapers(_currentPage);
      setState(() {
        _currentPage++;
        _wallpapers.addAll(newWallpapers);
        _filteredWallpapers = _wallpapers;
        _hasMore = newWallpapers.length == 30;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterWallpapers(String query) {
    final filtered = _wallpapers.where((wallpaper) {
      final nameLower = wallpaper.photographer.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredWallpapers = filtered;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
  title: !_isSearching
      ? const Text(
          'Wallpaper App...',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        )
      : TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
  // centerTitle: true,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
  actions: !_isSearching
      ? [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              // Add favorite functionality
            },
          ),
        ]
      : [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _filteredWallpapers = _wallpapers;
              });
            },
          ),
        ],
),

      body: _filteredWallpapers.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredWallpapers.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _filteredWallpapers.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final wallpaper = _filteredWallpapers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperDetailScreen(
                            imageUrl: wallpaper.src,
                            photographer: wallpaper.photographer,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: wallpaper.src,
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                wallpaper.photographer,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

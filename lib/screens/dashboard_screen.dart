import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Define a list of data for your dashboard grid items
  final List<Map<String, dynamic>> _dashboardItems = [
    {
      'label': 'Your Profile',
      'imagePath': 'assets/images/bottom_profile.jpg', // Path is correct as per screenshot
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Matrimonial',
      'imagePath': 'assets/images/matrimonial_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Hanti',
      'imagePath': 'assets/images/hanti_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'News Update',
      'imagePath': 'assets/images/news_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Notification',
      'imagePath': 'assets/images/notification_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Hanti',
      'imagePath': 'assets/images/hanti_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'News Update',
      'imagePath': 'assets/images/news_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Notification',
      'imagePath': 'assets/images/notification_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
    {
      'label': 'Hanti',
      'imagePath': 'assets/images/hanti_placeholder.jpg',
      'iconBgColor': Colors.white.withOpacity(0.8),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Container
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF89655), // Top Orange
                  Color(0xFFCC5500), // Mid-darker orange/brown
                  Color(0xFF8B4513), // Bottom Sienna/saddle brown
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main content area, excluding the bottom navigation
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0), // Removed bottom padding, bottom bar handles its own space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('View All clicked! (Implement navigation here)')),
                        );
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 20),

                // Grid View for Dashboard Items
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: _dashboardItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 0.9, // Adjust further if needed
                    ),
                    itemBuilder: (context, index) {
                      final item = _dashboardItems[index];
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['label']} clicked!')),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 90, // Size of the circular background
                              height: 90, // Size of the circular background
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item['iconBgColor'],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval( // Clip the image to a perfect circle
                                child: Image.asset(
                                  item['imagePath'],
                                  width: 80, // Adjust image size inside the circle (slightly smaller than container)
                                  height: 80, // Adjust image size inside the circle
                                  fit: BoxFit.cover, // Use BoxFit.cover to fill the circle
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['label'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // --- START OF REFINED BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Container(
        height: 70, // Height of the bottom bar
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), // Slightly transparent white
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)), // Rounded top corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3), // Shadow at the top
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding from sides
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between items
          children: [
            // Left spacer (to push center item towards center)
            const Spacer(),
            // Centered Profile Image
            CircleAvatar(
              radius: 25, // Size of the bottom profile image
              // The `backgroundImage` will handle fitting the image into the circle.
              // `bottom_profile.jpg` is a high-quality image, it should look good.
              backgroundImage: const AssetImage('assets/images/bottom_profile.jpg'),
              backgroundColor: Colors.grey.shade200, // Fallback/background for the avatar
            ),
            // Right spacer (to push center item towards center and More to the right)
            const Spacer(),
            // "More" text button with three dots icon
            GestureDetector( // Using GestureDetector for tap feedback, like in the screenshot
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('More options clicked!')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Add some padding for tap area
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Make column take minimum space
                  children: const [
                    Icon(Icons.more_horiz, color: Colors.black54, size: 28), // Three dots icon
                    Text(
                      "More",
                      style: TextStyle(color: Colors.black54, fontSize: 12), // "More" text
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // --- END OF REFINED BOTTOM NAVIGATION BAR ---
    );
  }
}
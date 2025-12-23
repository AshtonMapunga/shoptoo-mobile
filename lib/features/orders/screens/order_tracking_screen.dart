import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoptoo/features/chat/screens/chat_screen.dart';
import 'package:shoptoo/features/orders/screens/order_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';


class TrackOrderScreen extends StatefulWidget {
  final Order order;

  const TrackOrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late MapController _mapController;
  late LatLng _deliveryLocation;
  late LatLng _currentLocation;
  late List<DeliveryStep> _deliverySteps;
  int _currentStep = 2; // Simulating order is out for delivery

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    
    // Set delivery location based on the city in the address
    _setDeliveryLocation();
    _currentLocation = LatLng(-24.6282, 25.9231); // Gaborone coordinates
    
    // Initialize delivery steps
    _deliverySteps = [
      DeliveryStep(
        title: 'Order Placed',
        description: 'Your order has been confirmed',
        time: '10:30 AM',
        isCompleted: true,
      ),
      DeliveryStep(
        title: 'Order Processed',
        description: 'Items are being prepared for shipment',
        time: '11:45 AM',
        isCompleted: true,
      ),
      DeliveryStep(
        title: 'Out for Delivery',
        description: 'Your order is on the way',
        time: '2:15 PM',
        isCompleted: true,
        isCurrent: true,
      ),
      DeliveryStep(
        title: 'Delivered',
        description: 'Order delivered successfully',
        time: 'Estimated 4:30 PM',
        isCompleted: false,
      ),
    ];
  }

  void _setDeliveryLocation() {
    final address = widget.order.deliveryAddress.toLowerCase();
    
    // Set coordinates based on the city mentioned in the address
    if (address.contains('gaborone')) {
      _deliveryLocation = LatLng(-24.6282, 25.9231); // Gaborone
    } else if (address.contains('francistown')) {
      _deliveryLocation = LatLng(-21.1700, 27.5070); // Francistown
    } else if (address.contains('maun')) {
      _deliveryLocation = LatLng(-19.9833, 23.4167); // Maun
    } else if (address.contains('molepolole')) {
      _deliveryLocation = LatLng(-24.4060, 25.4950); // Molepolole
    } else if (address.contains('serowe')) {
      _deliveryLocation = LatLng(-22.3833, 26.7167); // Serowe
    } else {
      // Default to Gaborone
      _deliveryLocation = LatLng(-24.6282, 25.9231);
    }
  }

  void _launchMaps() async {
 

        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen(orderId: '123', driverName: 'Ashton Mapunga', driverImage: 'yu', vehicleNumber: 'ABC 123',)),
      );
  }

  void _callDeliveryDriver() {
    // Simulate calling delivery driver
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling delivery driver...'),
        backgroundColor: Pallete.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background animated circles
          _buildBackgroundCircles(),
          
          // Main content
          Column(
            children: [
              // Custom App Bar
              _buildAppBar(),
              
              // Map Section
              Expanded(
                flex: 2,
                child: _buildMapSection(),
              ),
              
              // Delivery Info Section
              Expanded(
                flex: 1,
                child: _buildDeliveryInfoSection(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        // Top right animated half circle
        Positioned(
          top: -100,
          right: -100,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
        ),
        // Secondary top right circle
        Positioned(
          top: -80,
          right: -80,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 120,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Iconsax.arrow_left, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tracking Order',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.order.id,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Pallete.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Pallete.primaryColor.withOpacity(0.3)),
              ),
              child: Text(
                'Out for Delivery',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Pallete.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _deliveryLocation,
            initialZoom: 13.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.trulyafricamarket.app',
            ),
            MarkerLayer(
              markers: [
                // Delivery Location Marker
                Marker(
                  point: _deliveryLocation,
                  width: 50,
                  height: 50,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Iconsax.location,
                          color: Pallete.primaryColor,
                          size: 24,
                        ),
                      ),
                      
                    ],
                  ),
                ),
               
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [_currentLocation, _deliveryLocation],
                  color: Pallete.primaryColor.withOpacity(0.6),
                  strokeWidth: 4,
                ),
              ],
            ),
          ],
        ),
        
        // Map Controls
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              // Zoom In
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Iconsax.add, size: 16),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom + 1);
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 8),
              // Zoom Out
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Iconsax.minus, size: 16),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom - 1);
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfoSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Delivery Progress
          Row(
            children: [
              Icon(Iconsax.clock, color: Pallete.primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                'Delivery Progress',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Estimated: 30-45 min',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Progress Steps
          Expanded(
            child: ListView.builder(
              itemCount: _deliverySteps.length,
              itemBuilder: (context, index) {
                final step = _deliverySteps[index];
                return _buildProgressStep(step, index);
              },
            ),
          ),
          
          SizedBox(height: 16),
          
          // Address and Actions
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.location, color: Pallete.primaryColor, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Delivery Address',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.order.deliveryAddress,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _launchMaps,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Pallete.primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.message, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Chat with Driver',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _callDeliveryDriver,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.call, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Call Driver',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(DeliveryStep step, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: step.isCompleted
                  ? Pallete.primaryColor
                  : step.isCurrent
                      ? Colors.orange
                      : Colors.grey[300],
              border: Border.all(
                color: step.isCurrent ? Colors.orange : Colors.transparent,
                width: 2,
              ),
            ),
            child: step.isCompleted
                ? Icon(Iconsax.tick_circle, color: Colors.white, size: 14)
                : step.isCurrent
                    ? Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                      )
                    : null,
          ),
          SizedBox(width: 12),
          
          // Step Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: step.isCurrent ? Colors.black : Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  step.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  step.time,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryStep {
  final String title;
  final String description;
  final String time;
  final bool isCompleted;
  final bool isCurrent;

  DeliveryStep({
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}


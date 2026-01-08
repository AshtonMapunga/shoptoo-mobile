import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/chat/domain/entity/chat_user_entity.dart';
import 'package:shoptoo/features/chat/presentation/provider/chat_repository_provider.dart';
import 'package:shoptoo/features/chat/screens/real_chat_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class TechnicianListScreen extends ConsumerStatefulWidget {
  final String userId;

  const TechnicianListScreen({required this.userId, super.key});

  @override
  ConsumerState<TechnicianListScreen> createState() => _TechnicianListScreenState();
}

class _TechnicianListScreenState extends ConsumerState<TechnicianListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animationController.value,
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
        Positioned(
          top: -80,
          right: -80,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animationController.value * 0.8,
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
        Positioned(
          bottom: -100,
          left: -100,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animationController.value * 1.2,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.primaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
Widget _buildTechCard(ChatUserEntity tech, int index) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        )),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () async {
                final chatId = await ref
                    .read(chatRepositoryProvider)
                    .createOrGetChat(widget.userId, tech.id);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      chatId: chatId,
                      userId: widget.userId,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Pallete.primaryColor.withOpacity(0.3),
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(tech.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tech.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tech.role,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pallete.primaryColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        Iconsax.message,
                        color: Pallete.primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Iconsax.search_normal, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search technicians...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: Icon(Iconsax.close_circle, color: Colors.grey[500]),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTopIconsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Iconsax.shopping_bag, size: 24),
            onPressed: () {
              // Navigate to orders
            },
          ),
          IconButton(
            icon: Badge(
              label: Text('3', style: TextStyle(fontSize: 10)),
              child: Icon(Iconsax.notification, size: 24),
            ),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Iconsax.setting, size: 24),
            onPressed: () {
              // Navigate to settings
            },
          ),
          IconButton(
            icon: Icon(Iconsax.profile_circle, size: 24),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
    );
  }
List<ChatUserEntity> _getFilteredTechnicians(
  List<ChatUserEntity> technicians,
) {
  if (_searchQuery.isEmpty) return technicians;

  final query = _searchQuery.toLowerCase();

  return technicians.where((tech) {
    return tech.name.toLowerCase().contains(query) ;  }).toList();
}


  @override
  Widget build(BuildContext context) {
    final technicians = ref.watch(techniciansProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          _buildBackgroundCircles(),
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildTopIconsRow(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Technicians',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Connect with experts',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Pallete.primaryColor.withOpacity(0.1),
                            ),
                            child: Icon(
                              Iconsax.people,
                              color: Pallete.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                  ],
                ),
              ),
              Expanded(
                child: technicians.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text(e.toString())),
                  data: (data) {
                    final filteredTechs = _getFilteredTechnicians(data);
                    
                    if (filteredTechs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.people, size: 60, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No technicians found',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
                      itemCount: filteredTechs.length,
                      itemBuilder: (context, index) {
                        return _buildTechCard(filteredTechs[index], index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh or add action
        },
        backgroundColor: Pallete.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(Iconsax.refresh, color: Colors.white),
      ),
    );
  }
}
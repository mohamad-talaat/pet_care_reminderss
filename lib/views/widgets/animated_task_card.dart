import 'package:flutter/material.dart';
import 'package:pet_reminder/models/task_model.dart';
import 'package:pet_reminder/views/widgets/task_card.dart';

class AnimatedTaskCard extends StatefulWidget {
  final Task task;
  final VoidCallback onTap;
  final int index;
  final bool selectMode;
  final bool isSelected;
  final VoidCallback? onSelect;
  final VoidCallback? onDismiss;
  
  const AnimatedTaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.index,
    this.selectMode = false,
    this.isSelected = false,
    this.onSelect,
    this.onDismiss,
  });

  @override
  State<AnimatedTaskCard> createState() => _AnimatedTaskCardState();
}

class _AnimatedTaskCardState extends State<AnimatedTaskCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuint,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    
     Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: TaskCard(
              task: widget.task,
              onTap: widget.onTap,
              selectMode: widget.selectMode,
              isSelected: widget.isSelected,
              onSelect: widget.onSelect,
              onDismiss: widget.onDismiss,
            ),
          ),
        );
      },
    );
  }
}
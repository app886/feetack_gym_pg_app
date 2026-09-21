import 'package:flutter/material.dart';
import 'package:vlr/data/models/rooom/pg_floor_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class FloorSidebarItem extends StatelessWidget {
  final PgFloorModel floor;
  final VoidCallback onTap;

  const FloorSidebarItem({
    super.key,
    required this.floor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: floor.isSelect ? primaryColor : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.layers_outlined,
              color: floor.isSelect ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              floor.name ?? "Floor ${floor.floorNumber}",
              textAlign: TextAlign.center,
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    color: floor.isSelect ? Colors.white : Colors.black87,
                    fontWeight: floor.isSelect ? FontWeight.bold : FontWeight.normal,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

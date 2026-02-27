import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../utils/app_theme.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final statusColor = task.completed
        ? AppTheme.completedColor
        : AppTheme.pendingColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: task.completed ? const Color(0xFFFAFBFC) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: task.completed
              ? Colors.grey.shade200
              : AppTheme.primaryColor.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: task.completed
            ? []
            : [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.read<TaskProvider>().toggleTask(task.id),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Animated checkbox ─────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(top: 1),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: task.completed ? statusColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: task.completed
                          ? statusColor
                          : Colors.grey.shade300,
                      width: task.completed ? 0 : 2,
                    ),
                  ),
                  child: task.completed
                      ? const Icon(
                          Icons.check_rounded,
                          size: 17,
                          color: Colors.white,
                        )
                      : null,
                ),

                const SizedBox(width: 14),

                // ── Task content ──────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: Colors.grey.shade300,
                          decorationThickness: 2,
                          color: task.completed
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                          height: 1.3,
                        ),
                      ),
                      if (task.description != null &&
                          task.description!.isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Text(
                          task.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade400,
                            height: 1.4,
                          ),
                        ),
                      ],
                      if (task.deadline != null) ...[
                        const SizedBox(height: 8),
                        _buildDeadlineChip(),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // ── Status pill ───────────────────
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    task.statusText,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeadlineChip() {
    final isOverdue =
        task.deadline!.isBefore(DateTime.now()) && !task.completed;
    final chipColor = isOverdue ? Colors.red : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isOverdue ? Colors.red.shade50 : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_rounded,
            size: 13,
            color: isOverdue ? Colors.red.shade400 : Colors.grey.shade500,
          ),
          const SizedBox(width: 5),
          Text(
            '${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isOverdue ? Colors.red.shade400 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

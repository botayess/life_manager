import 'package:flutter/material.dart';
import '../../l10n/strings.dart';
import '../widgets/section_card.dart';

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _demo(context, s.addTask),
        icon: const Icon(Icons.add_rounded),
        label: Text(s.addTask),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.planner,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            SectionCard(
              title: 'Сегодня',
              subtitle: 'Макет списка задач + “расписание уроков/пар”.',
              trailing: OutlinedButton.icon(
                onPressed: () => _demo(context, 'Календарь (UI)'),
                icon: const Icon(Icons.calendar_month_rounded),
                label: const Text('Календарь'),
              ),
            ),
            const SizedBox(height: 12),
            _TaskTile(title: 'Сдать лабу по Flutter', time: '10:00', done: false),
            const SizedBox(height: 10),
            _TaskTile(title: 'Прогулка 20 минут', time: '16:30', done: true),
            const SizedBox(height: 10),
            _TaskTile(title: 'Записать расходы', time: '19:00', done: false),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Будущий функционал', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(
                    '• Напоминания\n• Повторяющиеся задачи\n• Расписание по дням недели\n• Интеграция календаря (опционально)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _demo(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('Пока это UI. Реальную логику сделаем позже.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ок')),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String title;
  final String time;
  final bool done;

  const _TaskTile({
    required this.title,
    required this.time,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: done ? cs.primary : cs.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Время: $time', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Редактирование — позже.')),
            ),
            icon: const Icon(Icons.edit_rounded),
            tooltip: 'Редактировать',
          )
        ],
      ),
    );
  }
}

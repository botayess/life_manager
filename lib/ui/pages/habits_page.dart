import 'package:flutter/material.dart';
import '../../l10n/strings.dart';
import '../widgets/section_card.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewHabitSheet(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(s.addHabit),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.habits,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            SectionCard(
              title: 'Список привычек',
              subtitle:
                  'Карточки — это верстка. Следующий шаг: добавить реальный список + добавление/удаление.',
              trailing: OutlinedButton.icon(
                onPressed: () => _showFilterDialog(context),
                icon: const Icon(Icons.tune_rounded),
                label: const Text('Фильтр'),
              ),
            ),
            const SizedBox(height: 12),
            _HabitCard(
              title: 'Вода',
              subtitle: '8 стаканов в день',
              progress: 0.62,
              streak: 'Серия: 5 дней',
              color: cs.primaryContainer,
            ),
            const SizedBox(height: 12),
            _HabitCard(
              title: 'Чтение',
              subtitle: '20 минут',
              progress: 0.35,
              streak: 'Серия: 2 дня',
              color: cs.secondaryContainer,
            ),
            const SizedBox(height: 12),
            _HabitCard(
              title: 'Прогулка',
              subtitle: '3 000 шагов',
              progress: 0.80,
              streak: 'Серия: 7 дней',
              color: cs.tertiaryContainer,
            ),
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
                  Text('Будущая логика', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(
                    '• Создание привычек\n• Напоминания\n• Статистика по дням\n• Сохранение локально (Hive/SharedPreferences)\n• Позже: синхронизация (Firebase/Supabase)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Фильтры (UI)'),
        content: const Text('В будущем: активные/архив, по категориям, по целям.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Закрыть')),
        ],
      ),
    );
  }

  void _showNewHabitSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Новая привычка (макет)', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Название',
                hintText: 'Напр. Вода / Чтение / Зарядка',
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Цель',
                hintText: 'Напр. 8 стаканов / 20 минут / 10 раз',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Пока это UI. Добавление сделаем позже.')),
                      );
                    },
                    child: const Text('Сохранить'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Отмена'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _HabitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String streak;
  final Color color;

  const _HabitCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.streak,
    required this.color,
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
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.repeat_rounded, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(value: progress, minHeight: 8),
                ),
                const SizedBox(height: 8),
                Text(streak, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            tooltip: 'Подробнее',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Детали привычки — позже.')),
              );
            },
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}

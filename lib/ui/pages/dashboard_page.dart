import 'package:flutter/material.dart';
import '../../l10n/strings.dart';
import '../widgets/metric_tile.dart';
import '../widgets/section_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    final gridCols = width >= 1200 ? 3 : (width >= 820 ? 2 : 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.today,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          _Grid(
            columns: gridCols,
            gap: 12,
            children: const [
              MetricTile(
                icon: Icons.local_fire_department_rounded,
                title: 'Серия привычек',
                value: '5 дней',
                hint: 'Лучшая серия за неделю',
              ),
              MetricTile(
                icon: Icons.savings_rounded,
                title: 'Баланс',
                value: '45 200 ₸',
                hint: 'Сводка по финансам',
              ),
              MetricTile(
                icon: Icons.check_circle_rounded,
                title: 'Задачи',
                value: '3/8',
                hint: 'Выполнено сегодня',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: s.quickActions,
            subtitle: 'Кнопки пока показывают демо-диалоги.',
            trailing: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _demo(context, s.addHabit),
                  icon: const Icon(Icons.add_rounded),
                  label: Text(s.addHabit),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => _demo(context, s.addIncome),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: Text(s.addIncome),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => _demo(context, s.addExpense),
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  label: Text(s.addExpense),
                ),
                OutlinedButton.icon(
                  onPressed: () => _demo(context, s.addTask),
                  icon: const Icon(Icons.playlist_add_rounded),
                  label: Text(s.addTask),
                ),
              ],
            ),
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
                Text(
                  'Идея для преподавателя',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'На следующей неделе сюда можно добавить график прогресса привычек и простую диаграмму доход/расход.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _demo(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('Пока это только UI. Реальное сохранение добавим позже.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ок')),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final int columns;
  final double gap;
  final List<Widget> children;

  const _Grid({
    required this.columns,
    required this.gap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) SizedBox(height: gap),
          ]
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

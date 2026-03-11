import 'package:flutter/material.dart';
import '../../l10n/strings.dart';
import '../widgets/metric_tile.dart';
import '../widgets/section_card.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final width = MediaQuery.of(context).size.width;
    final gridCols = width >= 1200 ? 3 : (width >= 820 ? 2 : 1);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Wrap(
        spacing: 10,
        children: [
          FloatingActionButton.extended(
            heroTag: 'income',
            onPressed: () => _demo(context, s.addIncome),
            icon: const Icon(Icons.add_rounded),
            label: Text(s.addIncome),
          ),
          FloatingActionButton.extended(
            heroTag: 'expense',
            onPressed: () => _demo(context, s.addExpense),
            icon: const Icon(Icons.remove_rounded),
            label: Text(s.addExpense),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.finance,
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
                  icon: Icons.trending_up_rounded,
                  title: 'Доход (месяц)',
                  value: '120 000 ₸',
                  hint: 'Примерная сумма',
                ),
                MetricTile(
                  icon: Icons.trending_down_rounded,
                  title: 'Расход (месяц)',
                  value: '74 800 ₸',
                  hint: 'Примерная сумма',
                ),
                MetricTile(
                  icon: Icons.account_balance_rounded,
                  title: 'Цель',
                  value: 'Собрать: 200 000 ₸',
                  hint: 'Копилка/цель',
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Транзакции',
              subtitle:
                  'Список сделан как таблица (верстка). Следующий шаг: добавление/удаление и фильтры.',
              trailing: OutlinedButton.icon(
                onPressed: () => _demo(context, 'Экспорт (UI)'),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Экспорт'),
              ),
            ),
            const SizedBox(height: 12),
            _TransactionsTable(),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Идеи на будущее',
              subtitle:
                  '• Категории\n• Диаграммы\n• Бюджеты\n• Напоминания об оплатах\n• Импорт/экспорт CSV',
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
        content: const Text('Пока только UI. Реальную логику добавим позже.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ок')),
        ],
      ),
    );
  }
}

class _TransactionsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final rows = const [
      ('01.03', 'Стипендия', '+60 000 ₸', 'Доход'),
      ('02.03', 'Кофе', '-1 200 ₸', 'Еда'),
      ('02.03', 'Проезд', '-800 ₸', 'Транспорт'),
      ('03.03', 'Книга', '-4 500 ₸', 'Учёба'),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('Дата', style: text.labelLarge?.copyWith(fontWeight: FontWeight.w800))),
              Expanded(flex: 2, child: Text('Описание', style: text.labelLarge?.copyWith(fontWeight: FontWeight.w800))),
              Expanded(child: Text('Сумма', style: text.labelLarge?.copyWith(fontWeight: FontWeight.w800))),
              Expanded(child: Text('Категория', style: text.labelLarge?.copyWith(fontWeight: FontWeight.w800))),
            ],
          ),
          const SizedBox(height: 10),
          for (final r in rows) ...[
            Divider(height: 1, color: cs.outlineVariant),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text(r.$1)),
                Expanded(flex: 2, child: Text(r.$2)),
                Expanded(
                  child: Text(
                    r.$3,
                    style: text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      r.$4,
                      style: text.labelMedium?.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
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

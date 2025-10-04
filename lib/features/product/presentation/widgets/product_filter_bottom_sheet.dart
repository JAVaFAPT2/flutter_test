import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/src/core/constants/app_constants.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/cubit/products_view_cubit.dart';
import 'package:vietnamese_fish_sauce_app/features/product/application/bloc/product_list_bloc.dart'
    as ddd;

class ProductFilterBottomSheet extends StatelessWidget {
  const ProductFilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<ProductsViewCubit>(),
          ),
          BlocProvider.value(
            value: context.read<ddd.ProductListBloc>(),
          ),
        ],
        child: const ProductFilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Bộ lọc', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _ChipGroup(
              title: 'Danh mục',
              options: AppConstants.productCategories,
              isSelected: (value) =>
                  context.read<ProductsViewCubit>().state.selectedCategory ==
                  value,
              onSelected: (value, selected) =>
                  context.read<ProductsViewCubit>().updateCategoryFilter(
                        selected ? value : null,
                      ),
            ),
            const SizedBox(height: 12),
            _ChipGroup(
              title: 'Thương hiệu',
              options: AppConstants.productBrands,
              isSelected: (value) =>
                  context.read<ProductsViewCubit>().state.selectedBrand ==
                  value,
              onSelected: (value, selected) =>
                  context.read<ProductsViewCubit>().updateBrandFilter(
                        selected ? value : null,
                      ),
            ),
            const SizedBox(height: 12),
            const _SortSection(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final view = context.read<ProductsViewCubit>().state;
                  context.read<ddd.ProductListBloc>().add(
                        ddd.ProductListFilterChanged(
                          category: view.selectedCategory,
                          brand: view.selectedBrand,
                          sortBy: view.sortBy,
                        ),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Áp dụng'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipGroup extends StatelessWidget {
  const _ChipGroup({
    required this.title,
    required this.options,
    required this.isSelected,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final bool Function(String value) isSelected;
  final void Function(String value, bool selected) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options
              .map(
                (o) => FilterChip(
                  label: Text(o),
                  selected: isSelected(o),
                  onSelected: (s) => onSelected(o, s),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SortSection extends StatelessWidget {
  const _SortSection();

  @override
  Widget build(BuildContext context) {
    final viewCubit = context.watch<ProductsViewCubit>();
    final sortBy = viewCubit.state.sortBy ?? 'name';
    void setSort(String value) => viewCubit.updateSort(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sắp xếp', style: Theme.of(context).textTheme.titleMedium),
        RadioListTile<String>(
          value: 'name',
          groupValue: sortBy,
          onChanged: (v) => setSort(v ?? 'name'),
          title: const Text('Tên A-Z'),
        ),
        RadioListTile<String>(
          value: 'rating',
          groupValue: sortBy,
          onChanged: (v) => setSort(v ?? 'rating'),
          title: const Text('Đánh giá cao nhất'),
        ),
        RadioListTile<String>(
          value: 'price_asc',
          groupValue: sortBy,
          onChanged: (v) => setSort(v ?? 'price_asc'),
          title: const Text('Giá thấp đến cao'),
        ),
        RadioListTile<String>(
          value: 'price_desc',
          groupValue: sortBy,
          onChanged: (v) => setSort(v ?? 'price_desc'),
          title: const Text('Giá cao đến thấp'),
        ),
      ],
    );
  }
}

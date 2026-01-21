import 'package:erad/core/config/supabase_config.dart';

class BrandsData {
  Future<void> addBrand(
    String categoryName,
    String userID,
    String categoryType,
    String brandName,
  ) async {
    try {
      // Get category and category_type IDs
      final categoryResponse =
          await SupabaseConfig.client
              .from('categories')
              .select('id')
              .eq('user_id', userID)
              .eq('category_name', categoryName)
              .single();

      final categoryTypeResponse =
          await SupabaseConfig.client
              .from('category_types')
              .select('id')
              .eq('user_id', userID)
              .eq('category_type', categoryType)
              .single();

      await SupabaseConfig.client.from('brands').insert({
        'user_id': userID,
        'category_id': categoryResponse['id'],
        'category_type_id': categoryTypeResponse['id'],
        'brand_name': brandName,
        'category_name': categoryName,
        'category_type': categoryType,
      });
    } catch (e) {
      print('Error adding brand: $e');
      rethrow;
    }
  }

  Future<void> deleteBrand(String userID, String brandName) async {
    try {
      await SupabaseConfig.client
          .from('brands')
          .delete()
          .eq('brand_name', brandName)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting brand: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getBrands(
    String userID,
    String categoryType,
    String categoryName,
  ) {
    return SupabaseConfig.client
        .from('brands')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['category_name'] == categoryName &&
                        item['category_type'] == categoryType,
                  )
                  .toList(),
        );
  }

  Future<void> addBrandsType(
    String categoryName,
    String userID,
    String categoryType,
    String brandName,
    String productSize,
    int productBuyingPrice,
    int productSalesPrice,
    int productProfits,
  ) async {
    try {
      String productName = "$categoryType $brandName $productSize";

      // Get category and brand IDs
      final categoryResponse =
          await SupabaseConfig.client
              .from('categories')
              .select('id')
              .eq('user_id', userID)
              .eq('category_name', categoryName)
              .single();

      final brandResponse =
          await SupabaseConfig.client
              .from('brands')
              .select('id')
              .eq('user_id', userID)
              .eq('brand_name', brandName)
              .single();

      await SupabaseConfig.client.from('products').insert({
        'user_id': userID,
        'category_id': categoryResponse['id'],
        'brand_id': brandResponse['id'],
        'product_name': productName,
        'product_size': productSize,
        'product_buying_price': productBuyingPrice,
        'product_sales_price': productSalesPrice,
        'product_profits': productProfits,
        'category_name': categoryName,
        'brand_name': brandName,
      });
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  Future<void> editBrandsType(
    String userID,
    String productBuyingPrice,
    String productSalesPrice,
    String productSize,
    String productName,
  ) async {
    try {
      await SupabaseConfig.client
          .from('products')
          .update({
            'product_size': productSize,
            'product_buying_price': int.parse(productBuyingPrice),
            'product_sales_price': int.parse(productSalesPrice),
          })
          .eq('product_name', productName)
          .eq('user_id', userID);
    } catch (e) {
      print('Error editing product: $e');
      rethrow;
    }
  }

  Future<void> deleteBrandsType(String userID, String productName) async {
    try {
      await SupabaseConfig.client
          .from('products')
          .delete()
          .eq('product_name', productName)
          .eq('user_id', userID);
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getBrandsType(
    String userID,
    String categoryType,
    String categoryName,
    String brandName,
  ) {
    return SupabaseConfig.client
        .from('products')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data
                  .where(
                    (item) =>
                        item['user_id'] == userID &&
                        item['category_name'] == categoryName &&
                        item['brand_name'] == brandName,
                  )
                  .toList(),
        );
  }
}

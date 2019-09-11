require 'csv'

class ProductGenerator
  attr_reader :csv_parsed
  def initialize(csv_file)
    @csv_parsed = CSV.parse(csv_file, headers: true)
  end

  def load
    csv_parsed.each do |row|
      category = Category.find_or_create_by(name: row['Categoria'])
      product = Product.find_or_create_by(name: row['Producto']) { |p| p.category = category }
      row['Presentacion'] == 'N/A' ? base_variant(row, product) : normal_variant(row, product)
    end
  end

  def base_variant(row, product)
    Variant.create!(price: row['Precio unitario'],
                    product: product,
                    base: true)
  end

  def normal_variant(row, product)
    Variant.create!(name: row['Presentacion'],
                    price: row['Precio unitario'],
                    product: product,
                    base: false)
  end
end

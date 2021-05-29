# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
products = [
  { :name => "Xperia Pro (2021)", :price => 949.99, :description => "Sony Xperia S is powered by a 1.5GHz dual-core processor. It comes with 1GB of RAM. The Sony Xperia S runs Android 2.3 and is powered by a 1750mAh non-removable battery. As far as the cameras are concerned, the Sony Xperia S on the rear packs 12.1-megapixel camera.", :views => 0 },
  { :name => "OnePlus Nord", :price => 529.00, :description => "OnePlus Nord is driven by a robust Qualcomm Snapdragon 765G chipset, having an octa-core Kryo 475 processor of up to 2.4GHz. The graphics of Nord is supported by an Adreno 620 GPU with 6GB RAM for a lag-free gaming experience.", :views => 0 },
  { :name => "Xperia Pro (2021)", :price => 2499.99, :description => "The phone comes with a 6.50-inch touchscreen display with a resolution of 1644x3840 pixels. Sony Xperia Pro (2021) is powered by an octa-core Qualcomm Snapdragon 865 processor. It comes with 12GB of RAM. The Sony Xperia Pro (2021) runs Android 10 and is powered by a 4000mAh battery. The Sony Xperia Pro (2021) supports proprietary fast charging.", :views => 0 },
  { :name => "iPhone 12 Pro Max", :price => 906, :description => "iPhone 12 Pro Max smartphone was launched on 13th October 2020. The phone comes with a 6.70-inch touchscreen display with a resolution of 1284x2778 pixels at a pixel density of 458 pixels per inch (ppi). The iPhone 12 Pro Max supports wireless charging, as well as proprietary fast charging.", :views => 0 },
]
products.each do |product|
  Product.create!(product)
end

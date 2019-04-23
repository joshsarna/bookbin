Book.destroy_all
Review.destroy_all

Book.create!({title: "Of Mice and Men", author: "John Steinbeck", image_url: "https://upload.wikimedia.org/wikipedia/en/0/01/OfMiceAndMen.jpg"})
Book.create!({title: "The Grapes of Wrath", author: "John Steinbeck", image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/1/1f/JohnSteinbeck_TheGrapesOfWrath.jpg/200px-JohnSteinbeck_TheGrapesOfWrath.jpg"})
Book.create!({title: "The Winter of Our Discontent", author: "John Steinbeck", image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/7/73/Winter_discontent.JPG/220px-Winter_discontent.JPG"})
Book.create!({title: "The Pearl", author: "John Steinbeck", image_url: "https://ecdn.teacherspayteachers.com/thumbitem/John-Steinbecks-The-Pearl-Teaching-Guide-for-Students-1051680-1432339268/original-1051680-1.jpg"})
Book.create!(title: "A Life In Parts", author: "Bryan Cranston", image_url: "https://images-na.ssl-images-amazon.com/images/I/81Egbe7O3LL.jpg")
Book.create!({title: "A Game of Thrones", author: "George R. R. Martin", image_url: "https://images-na.ssl-images-amazon.com/images/I/91dSMhdIzTL.jpg"})
Book.create!({title: "A Clash of Kings", author: "George R. R. Martin", image_url: "https://images-na.ssl-images-amazon.com/images/I/91Nl6NuijHL.jpg"})
Book.create!({title: "A Storm of Swords", author: "George R. R. Martin", image_url: "https://images-na.ssl-images-amazon.com/images/I/91d-77kn-dL.jpg"})
Book.create!({title: "A Feast for Crows", author: "George R. R. Martin", image_url: "https://awoiaf.westeros.org/thumb.php?f=AFeastForCrows.jpg&width=200"})
Book.create!({title: "A Dance with Dragons", author: "George R. R. Martin", image_url: "https://images-na.ssl-images-amazon.com/images/I/511P60EPvaL._SX301_BO1,204,203,200_.jpg"})
Book.create!({title: "The Fellowship of the Ring", author: "J. R. R. Tolkien", image_url: "https://images-na.ssl-images-amazon.com/images/I/51tW-UJVfHL._SX321_BO1,204,203,200_.jpg"})
Book.create!({title: "The Two Towers", author: "J. R. R. Tolkien", image_url: "https://prodimage.images-bn.com/pimages/9780547928203_p0_v2_s1200x630.jpg"})
Book.create!({title: "The Return of the King", author: "J. R. R. Tolkien", image_url: "https://images-na.ssl-images-amazon.com/images/I/41KGl2FqeAL.jpg"})
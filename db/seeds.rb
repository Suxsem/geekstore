Category.create!([
  {name: "Baby"},
  {name: "Electronics"}
])
Order.create!([
  {user_id: 7, product_id: 1, status: "in attesa di pagamento", price: "105.679"},
  {user_id: 7, product_id: 1, status: "in attesa di conferma", price: "6.31"}
])
Order::HABTM_Upgrades.create!([
  {order_id: 2, upgrade_id: 1}
])
Product.create!([
  {name: "Small Concrete Hat", desc: "", image: "image/upload/v1441611571/vl8xszinz6arfwlnxyyj.jpg", price: "6.31", discount: 10, category_id: 1},
  {name: "Rustic Plastic Computer", desc: nil, image: nil, price: "11.27", discount: 0, category_id: 1},
  {name: "Practical Steel Shoes", desc: nil, image: nil, price: "44.06", discount: 0, category_id: 1},
  {name: "Practical Granite Shoes", desc: nil, image: nil, price: "85.8", discount: 0, category_id: 1},
  {name: "Awesome Rubber Shoes", desc: nil, image: nil, price: "55.42", discount: 0, category_id: 1}
])
Product::HABTM_Stores.create!([
  {product_id: 1, store_id: 1},
  {product_id: 2, store_id: 1},
  {product_id: 3, store_id: 1},
  {product_id: 4, store_id: 1},
  {product_id: 5, store_id: 1}
])
Store.create!([
  {place: "Campus Universitario Ecotekne, Monteroni"},
  {place: "Via Moreno 83, Cristyn umbro"},
  {place: "Contrada Adriano 13, San Oretta umbro"},
  {place: "Via Renzo 580, Testa lido"},
  {place: "Incrocio Carbon 89, Fabiano salentino"},
  {place: "Piazza Luce 7, Quarto Carmela veneto"},
  {place: "Strada Fabio 68, San Kociss"},
  {place: "Via Ercole 422, Quarto Silvano del friuli"},
  {place: "Rotonda Diamante 492, Quarto Emidio"},
  {place: "Contrada Sarita 1, Vitale calabro"},
  {place: "Strada Sesto 132, Ippolito lido"},
  {place: "Incrocio Montanari 635, Folco laziale"},
  {place: "Incrocio Eufemia 925, San Joey calabro"},
  {place: "Rotonda Costantin 9, Borgo Quarto"},
  {place: "Incrocio Lombardo 358, San Jarno a mare"},
  {place: "Strada Eustachio 927, Timothy laziale"},
  {place: "Piazza Gelsomina 5, Cleopatra veneto"},
  {place: "Piazza Marco 376, Tancredi veneto"},
  {place: "Via Battaglia 76, Settimo Nathan ligure"},
  {place: "Via De luca 36, Bortolo veneto"},
  {place: "Piazza Piccarda 28, Settimo Odino veneto"}
])
Store::HABTM_Products.create!([
  {product_id: 1, store_id: 1},
  {product_id: 2, store_id: 1},
  {product_id: 3, store_id: 1},
  {product_id: 4, store_id: 1},
  {product_id: 5, store_id: 1}
])
Upgrade.create!([
  {name: "pot1", price: "100.0", product_id: 1}
])
Upgrade::HABTM_Orders.create!([
  {order_id: 2, upgrade_id: 1}
])
User.create!([
  {name: "stefano", admin: true, password_digest: "$2a$10$rc/FhA9cYNI6xj7UqcDWduUAj5BsCkorhtuMOtGSxnUlnqOsXlk6W"},
  {name: "edipo barbieri", admin: false, password_digest: "$2a$10$zUugbd3NPxv7.hPgH8KlQ.iNDKvdhoXdyNP0nmSOoGPOU.6cr0uYa"},
  {name: "ilario giordano", admin: false, password_digest: "$2a$10$J1Oy6j.m.kcPYoJHxyjY5u9c2q2YkYpkPaM3GTo//4Knd/XPk7MoW"},
  {name: "lino martino", admin: false, password_digest: "$2a$10$ICeWWyue.2USFV65I67KiedVvYL.zwjRBzER3hrXFxLdMx/cipM8i"},
  {name: "osvaldo fontana", admin: false, password_digest: "$2a$10$fsUrdAu6WP.gMQBNcY9YtOoRjy4C9cZeCviEnPtLMc4NONUP9BKYe"},
  {name: "user", admin: false, password_digest: "$2a$10$cfpRfjlWzJnUzAVND6WD7e4k8Vb1kKt7iFwsW7oTf8C6kOntnO/xK"},
  {name: "vinicio de angelis", admin: false, password_digest: "$2a$10$alUS0HOhUVvGNE324P0rJ.nRwsrtdN3kxoARiiTkKo31e.y/DeX7O"}
])

Category.create!([
  {name: "Accessori"},
  {name: "Desktop"},
  {name: "Notebook"},
  {name: "Tablet"}
])
Store.create!([
  {place: "Campus Universitario Ecotekne, Monteroni"},
  {place: "Elettronica Sud, Lecce"},
  {place: "Trony, Lecce"},
  {place: "Euronics, Lecce"},
  {place: "Elettronica componenti SRL, Brindisi"},
  {place: "Mediaworld, Surbo"},
  {place: "Marcopolo, Cavallino"}
])
User.create!([
  {name: "admin", admin: true, password_digest: "$2a$10$rc/FhA9cYNI6xj7UqcDWduUAj5BsCkorhtuMOtGSxnUlnqOsXlk6W"},
  {name: "edipo barbieri", admin: false, password_digest: "$2a$10$zUugbd3NPxv7.hPgH8KlQ.iNDKvdhoXdyNP0nmSOoGPOU.6cr0uYa"},
  {name: "ilario giordano", admin: false, password_digest: "$2a$10$J1Oy6j.m.kcPYoJHxyjY5u9c2q2YkYpkPaM3GTo//4Knd/XPk7MoW"},
  {name: "lino martino", admin: false, password_digest: "$2a$10$ICeWWyue.2USFV65I67KiedVvYL.zwjRBzER3hrXFxLdMx/cipM8i"},
  {name: "osvaldo fontana", admin: false, password_digest: "$2a$10$fsUrdAu6WP.gMQBNcY9YtOoRjy4C9cZeCviEnPtLMc4NONUP9BKYe"},
  {name: "user", admin: false, password_digest: "$2a$10$cfpRfjlWzJnUzAVND6WD7e4k8Vb1kKt7iFwsW7oTf8C6kOntnO/xK"},
  {name: "vinicio de angelis", admin: false, password_digest: "$2a$10$alUS0HOhUVvGNE324P0rJ.nRwsrtdN3kxoARiiTkKo31e.y/DeX7O"}
])
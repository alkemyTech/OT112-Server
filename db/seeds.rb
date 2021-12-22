# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

activities = [
  ["Programas Educativos", "Mediante nuestros programas educativos, buscamos incrementar la capacidad intelectual, moral y afectiva de las personas de acuerdo con la cultura y las normas de convivencia de la sociedad a la que pertenecen."],
  ["Apoyo Escolar para el nivel Primario", "El espacio de apoyo escolar es el corazón del área educativa. Se realizan los talleres de lunes a jueves de 10 a 12 horas y de 14 a 16 horas en el contraturno. 
    Los sábados también se realiza el taller para niños y niñas que asisten a la escuela doble turno.
    Tenemos un espacio especial para los de 1er grado 2 veces por semana ya que ellos necesitan atención especial! Actualmente se encuentran inscriptos a este programa 150 niños y niñas de 6 a 15 años. Este taller está pensado para ayudar a los alumnos con el material que traen de la escuela, también tenemos una docente que les da clases de lengua y matemática con una planificación propia que armamos en Manos para nivelar a los niños y que vayan con más herramientas a la escuela."],
  ["Apoyo Escolar Nivel Secundaria", "Del mismo modo que en primaria, este taller es el corazón del área secundaria. Se realizan talleres de lunes a viernes de 10 a 12 horas y de 16 a 18 horas en el contraturno.
    Actualmente se encuentran inscriptos en el taller 50 adolescentes entre 13 y 20 años.
    Aquí los jóvenes se presentan con el material que traen del colegio y una docente de la institución y un grupo de voluntarios los recibe para ayudarlos a estudiar o hacer la tarea. Este espacio también es utilizado por los jóvenes como un punto de encuentro y relación entre ellos y la institución."],
  ["Tutorias", "Es un programa destinado a jóvenes a partir del tercer año de secundaria, cuyo objetivo es garantizar su permanencia en la escuela y construir un proyecto de vida que da sentido al colegio. El objetivo de esta propuesta es lograr la integración escolar de niños y jóvenes del barrio promoviendo el soporte socioeducativo y emocional apropiado, desarrollando los recursos institucionales necesarios a través de la articulación de nuestras intervenciones con las escuelas que los alojan, con las familias de los alumnos y con las instancias municipales, provinciales y nacionales que correspondan.
    El programa contempla:
    * Encuentro semanal con tutores Individuales y grupales).
    * Actividad proyecto (los participantes del programa deben pensar una actividad relacionada a lo que quieren hacer una vez terminada la escuela y su tutor los acompaña en el proceso).
    * Ayudantías (los que comienzan el 2do años del programa deben elegir una de las actividades que se realizan en la institución para acompañarla e ir conociendo como es el mundo laboral que les espera).
    * Acompañamiento escolar y familiar Los tutores son encargados de articular con la familia y con las escuelas de los jóvenes para monitorear el estado de los tutoreados).
    * Beca estímulo (los jóvenes reciben una beca estímulo que es supervisada por los tutores). Actualmente se encuentran inscriptos en el programa 30 adolescentes."],
  ["Taller Arte y Cuentos", "Taller literario y de manualidades que se realiza semanalmente."],
  ["Paseos recreativos y educativos", "Estos paseos están pensados para promover la participación y sentido de  pertenencia de los niños, niñas y adolescentes al área educativa."],
]

activities.each do |name, content|
  Activity.create(name: name, content: content)
end

roles = [
  {name: "admin", description: "admin role"},
  {name: "regular", description: "regular role"},
  {name: "standard", description: "standard role"}
]

roles.each do |role|
  Role.create(role)
end

users = [
  # Admin
  {first_name: "Admin", last_name: "Admin", email: "admin@example.com", password: "4dM1nM4sT3rK3y", role_id: 1},
  # Regulars
  {first_name: "Pedro", last_name: "Aguilar", email: "pedro.aguilar@example.com", password: "password", role_id: 2},
  {first_name: "Rodolfo", last_name: "Juarez", email: "rodolfo.juarez@example.com", password: "password", role_id: 2},
  {first_name: "Mario", last_name: "Gomez", email: "mario.gomez@example.com", password: "password", role_id: 2},
  {first_name: "Jose", last_name: "Perez", email: "jose.perez@example.com", password: "password", role_id: 2},
  {first_name: "Omar", last_name: "Gutierrez", email: "omar.gutierrez@example.com", password: "password", role_id: 2},
  {first_name: "Juana", last_name: "Diaz", email: "juana.diaz@example.com", password: "password", role_id: 2},
  {first_name: "Maria", last_name: "Sosa", email: "maria.sosa@example.com", password: "password", role_id: 2},
  {first_name: "Ana", last_name: "Jaime", email: "ana.jaime@example.com", password: "password", role_id: 2},
  {first_name: "Marta", last_name: "Martin", email: "marta.martin@example.com", password: "password", role_id: 2},
  {first_name: "Francisca", last_name: "Acevedo", email: "francisca.acevedo@example.com", password: "password", role_id: 2},
  # Standards
  {first_name: "Will", last_name: "Smith", email: "will.smith@example.com", password: "password", role_id: 3},
  {first_name: "Marlon", last_name: "Brando", email: "marlon.brando@example.com", password: "password", role_id: 3},
  {first_name: "Chuck", last_name: "Norris", email: "chuck.norris@example.com", password: "password", role_id: 3},
  {first_name: "Kung", last_name: "Lao", email: "kung.lao@example.com", password: "password", role_id: 3},
  {first_name: "Luke", last_name: "Skywalker", email: "luke.skywalker@example.com", password: "password", role_id: 3},
  {first_name: "Hanna", last_name: "Montana", email: "hanna.montana@example.com", password: "password", role_id: 3},
  {first_name: "Sandra", last_name: "Bullock", email: "sandra.bullock@example.com", password: "password", role_id: 3},
  {first_name: "Serena", last_name: "Williams", email: "serena.williams@example.com", password: "password", role_id: 3},
  {first_name: "Paula", last_name: "Pareto", email: "paula.pareto@example.com", password: "password", role_id: 3},
  {first_name: "Jennifer", last_name: "Lawrence", email: "jennifer.lawrence@example.com", password: "password", role_id: 3}
]

users.each do |user|
  User.create(user)
end

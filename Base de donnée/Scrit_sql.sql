drop database if exists My_map;
create database My_map;
use My_map;

CREATE TABLE Users(
   user_id INT Auto_Increment,
   user_mail VARCHAR(255) NOT NULL,
   password VARCHAR(255) NOT NULL,
   name VARCHAR(50) NOT NULL,
   Max_zone INT,
   PRIMARY KEY(user_id),
   UNIQUE(user_mail)
);

CREATE TABLE Maps(
   map_id INT Auto_Increment,
   game_name VARCHAR(50) NOT NULL,
   description TEXT,
   image VARCHAR(255),
   PRIMARY KEY(map_id)
);

CREATE TABLE Map_Zones(
   zone_id INT Auto_Increment,
   map_id INT NOT NULL,
   name VARCHAR(50) NOT NULL,
   description TEXT,
   order_ INT,
   PRIMARY KEY(zone_id),
   FOREIGN KEY(map_id) REFERENCES Maps(map_id)
);

CREATE TABLE POI_Types(
   poi_type_id INT Auto_Increment,
   name VARCHAR(50) NOT NULL,
   color VARCHAR(9) NOT NULL,
   PRIMARY KEY(poi_type_id),
   UNIQUE(name)
);

CREATE TABLE Items(
   item_id INT Auto_Increment,
   name VARCHAR(50) NOT NULL,
   description TEXT,
   image VARCHAR(255),
   price INT NOT NULL,
   PRIMARY KEY(item_id)
);

CREATE TABLE Lists(
   list_id INT Auto_Increment,
   user_id INT NOT NULL,
   name VARCHAR(50) NOT NULL,
   description TEXT,
   color VARCHAR(9) NOT NULL,
   PRIMARY KEY(list_id),
   FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

CREATE TABLE Points_of_Interest(
   poi_id INT Auto_Increment,
   map_id INT NOT NULL,
   zone_id INT NOT NULL,
   poi_type_id INT NOT NULL,
   name VARCHAR(50) NOT NULL,
   description TEXT,
   position_X INT NOT NULL,
   position_Y INT NOT NULL,
   created_at DATETIME NOT NULL,
   update_at DATETIME,
   created_by INT,
   PRIMARY KEY(poi_id),
   FOREIGN KEY(poi_type_id) REFERENCES POI_Types(poi_type_id),
   FOREIGN KEY(zone_id) REFERENCES Map_Zones(zone_id),
   FOREIGN KEY(map_id) REFERENCES Maps(map_id),
   FOREIGN KEY(created_by) REFERENCES Users(user_id)
);

CREATE TABLE Comments(
   comment_id INT Auto_Increment,
   user_id INT NOT NULL,
   poi_id INT NOT NULL,
   content TEXT NOT NULL,
   created_at DATETIME NOT NULL,
   updated_at DATETIME,
   PRIMARY KEY(comment_id),
   FOREIGN KEY(user_id) REFERENCES Users(user_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id)
);

CREATE TABLE Boss_Details(
   boss_id INT Auto_Increment,
   poi_id INT NOT NULL,
   lore TEXT,
   particularities TEXT,
   statistics TEXT,
   tips TEXT,
   PRIMARY KEY(boss_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id)
);

CREATE TABLE NPC_details(
   npc_id INT Auto_Increment,
   poi_id INT NOT NULL,
   description TEXT,
   PRIMARY KEY(npc_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id)
);

CREATE TABLE List_Pois(
   poi_id INT,
   list_id INT,
   PRIMARY KEY(poi_id, list_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id),
   FOREIGN KEY(list_id) REFERENCES Lists(list_id)
);

CREATE TABLE Merchant_Items(
   poi_id INT,
   item_id INT,
   price INT NOT NULL,
   PRIMARY KEY(poi_id, item_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id),
   FOREIGN KEY(item_id) REFERENCES Items(item_id)
);

CREATE TABLE User_POI_Progress(
   user_id INT,
   poi_id INT,
   status Enum('not_discovered','discovered', 'completed') NOT NULL,
   discovered_at DATETIME,
   completed_at DATETIME,
   PRIMARY KEY(user_id, poi_id),
   FOREIGN KEY(user_id) REFERENCES Users(user_id),
   FOREIGN KEY(poi_id) REFERENCES Points_of_Interest(poi_id)
);

INSERT INTO Users
   (user_id, user_mail, password, name, Max_zone)
VALUES
   (1, 'u4546006479@gmail.com', 'J-b1210', 'Jean-Baptiste', 1),
   (2, 'lebgdu58@gmail.com', 'lebg', 'Thibault', 1),
   (3, 'manolo.martinezcor@gmail.com', 'manolo1234', 'Manolo', 1);

INSERT INTO Maps
   (map_id, game_name, description, image)
VALUES
   (1, 'Cuphead', 'La map principale de cuphead et sont dlc', 'inkwell_isle_1.jpg');

INSERT INTO Map_Zones
   (zone_id, map_id, name, description, order_)
VALUES
   (1, 1, 'Inkwell isle I', 'Zone forestière de Inkwell Isle I.', 1),
   (2, 1, 'Inkwell isle II', 'Zone carnaval et montagnes de Inkwell Isle II.', 2),
   (3, 1, 'Inkwell isle III', 'Zone ville et bord de mer de Inkwell Isle III.', 3),
   (4, 1, 'Inkwell Hell', 'Casino du diable de Inkwell Hell.', 4),
   (5, 1, 'The delicious last course', 'Zone au paysage féeriques et endroits inquiétants.', 5);

INSERT INTO POI_Types
   (poi_type_id, name, color)
VALUES
   (1, 'Boss', '#FF0000'),
   (2, 'Run&Gun', '#00FF00'),
   (3, 'PNJ', '#0000FF');

INSERT INTO Items
   (item_id, name, description, image, price)
VALUES
   (1, 'Peashooter', 'Arme de base de Cuphead à 30 dégâts par second. Tir droit, rapide et longue portée.', 'peashooter.png', 0),
   (2, 'Spread', 'Arme à courte porté qui tire plusieurs projectiles en éventail pouvant faire 41.33 dégâts par second au maximum.', 'spread.png', 4),
   (3, 'Chaser', 'Arme avec des projectiles qui poursuivent automatiquement les ennemies mais fait seulement 17.1 dégâts par seconde.', 'Chaser.png', 4),
   (4, 'Lobber', 'Arme qui tire des boules qui suivent une trajectoire en arc et rebondissent fait 33.14 dégâts par seconde.', 'Lobber.png', 4),
   (5, 'Charge', 'Arme qui se charge, il faut maintenir le tire puis le relâcher, pouvant faire 35.38 dégâts par seconde au mieux.', 'Charge.png', 4),
   (6, 'Roundabout', 'Arme qui envoie un projectile qui revient en arrière et couvre une grande distance comme une boomrang 31.9 dégâts par seconde.', 'Roundabout.png', 4),
   (7, 'Crackshot', 'Arme qui envoie des projectiles qui se fragemente en plusieurs petits tirs et fonçent automatiqument sur les ennemies avec environ 30 dégâts par seconde.', 'Crackshot.png', 4),
   (8, 'Converge', 'Arme qui tire trois projectiles en éventail, que tu peux resserer en mainteant la touche de vérrouillage pouvant faire 33 dégâts par seconde.', 'Converge.png', 4),
   (9, 'Twist up', 'Arme qui tire trois projecticles en spirale vers le haut pouvant faire 32 dégâts par secondes.', 'Twist_up.png', 4),
   (10, 'Heart', 'Objet qui accorde 1 point de vie suplémentaire, mais réduit les dégâts infligés de 5%.', 'Heart.png', 3),
   (11, 'Smoke bomb', 'Objet qui rend invulnérable pendant les dashs en rendant le presonnage invisible.', 'Smoke_bomb', 4),
   (12, 'P.Sugar', 'Objet qui permet de réaliser automatiqument la premère parade en sautant sur un objet rose.', 'P_Sugar', 3),
   (13, 'Coffee', 'Remplit progressivement la jauge de super même sans toucher les ennemies.', 'Coffee.png', 3),
   (14, 'Whetstone', 'Transforme la première parade après avoir touché le sol en une attaque de hache qui inflige des dégâts aux ennemies.', 'Whetstone.png', 3),
   (15, 'Twin Heart', 'Objet qui accorde 2 point de vie suplémentaire, mais réduit les dégâts infligés de 10%.', 'Twin_Heart.png', 5),
   (16, 'Astral Cookie', 'Permet de jouer avec MLe Calice qui est un personnage du DLC qui permet de faire des doubles saut, des esquive spéciale et parade différentes.', 'Astral_Cookie.png', 4),
   (17, 'Heart Ring', 'Objet qui rend 1 poinnt de vie lors de la première, de la troisième et de la sixième parade, peut donc rendre 3 point de vie.', 'Heart_ring.png', 3),
   (18, 'Broken Relic', 'Une relique mystérieuse qui sert à résoubre une énigme du DLC (est nécéssaire pour débloquer une autres relique).', 'Broken_Relic.png', 1),
   (19, 'Cursed Relic', 'Réduit temporairement les capacités en imposant des contraintes aux combats en combattant suffisament avec elle tu peut débloquer un nouvelle item.', 'Cursed_Relic.png', 0),
   (20, 'Divine relic', 'Relique améliorée qui combine plusieurs effets de charme et change les armes au cours du combat.', 'Divine_relic.png', 0);
   
INSERT INTO Points_of_Interest
   (poi_id, map_id, zone_id, poi_type_id, name,
    description, position_X, position_Y,
    created_at, update_at, created_by)
VALUES
   (1, 1, 1, 1, 'The Root Pack','Boss de Inkwell Isle I.', 100, 200, '2026-10-06 10:00:00', NULL, 1);

INSERT INTO Comments
   (comment_id, user_id, poi_id, content, created_at, updated_at)
VALUES
   (1, 1, 1, 'Un boss assez facile pour commencer.', '2026-10-06 10:30:00', NULL);

INSERT INTO Lists
   (list_id, user_id, name, description, color)
VALUES
   (1, 1, 'Boss à battre', 'Liste des boss à battre.', '#7F00FF');

INSERT INTO Boss_Details
   (boss_id, poi_id, lore, particularities, statistics, tips)
VALUES
   (1, 1, 'La Bande des tubercules, trio de légumes qui protège sont territoire.', 'patate qui crache des projectiles, ognion qui pleure, et carrot attaques avec des rayons psychiques', 'Difficulté : 2/5.', 'Reste mobile et hésite pas à abuser du spread car les ennemies sont très proche de toi.'),                        
   (2, 1, 'Victor Visqueux, une créature gélatineuse qui prend des formes de plus en plus imposantes.', 'il rebondit, grandit et fini par une mort particulière.', 'Difficulté : 1/5.', 'Observe sont rythme de rebond pour passé en dessous et anticiper les attaques, le spread est une bonne solution car le boss est lents et proche de toi.'),
   (3, 1, 'Hilda Berg, une adversaire aérienne capable de se transformer selon les signes du zodiaque.', 'Combat en avion avec plusieurs transformation et des attaques circulaires.', 'Difficulté : 3/5.', 'Utilise la petit forme de ton avion pour éviter les passage trop serré.'),
   (4, 1, 'Fred Aster, une fleur apparemment sympathique qui révèle une nature agressive.', 'Graines qui deviennent des plantes ennemies et racines qui traversent les plateformes.', 'Difficulté : 2/5.', 'Elimine les plantes issue des graines dès que possible pour le pas surcharger ton écran et le chaser est une bonne option pour traquer les ennemies secondaires.'),
   (5, 1, 'Coasse et Batrace, deux frères grenouilles qui vous affronte dans un combat inspiré de la boxe.', 'Le premier frappe et lance des projectiles, le second souffle du vent et cela ce termine par une machine à sous.', 'Difficulté : 2/5.', 'Lors de la machine à sous parre le levier rose pour lance la machine, le peashooter est une bonne option étant la seul arme longue distance du jeu à ce moment.'),
   (6, 1, 'Baronne Von Berlingot, une souveraine des bonbons qui défend son château.', 'Tu affrontes plusieurs soldats sucrés tirés au hasard avant la baronne.', 'Difficulté : 3/5.', 'Apprends à reconnaître les mini-boss et utilise les bonbons roses pour remplir ta jauge, le Charge est intérresant pour vaincre rapidement les soldats.'),
   (7, 1, 'Beppi le clown, un clown de fête foraine qui transforme son attraction en cauchemar.', 'Voiture tamponneuse, monture gonflable, tête de manège et attaques de montagnes russes.', 'Difficulté : 3/5.', 'Surveille les rails en bas de ton écran, et utilise le Chaser pour éliminer les horde adverse.'),
   (8, 1, 'Djinn le Génie, un génie magique qui utilise ses pouvoirs pour te mettre à rude épreuve.', 'Cinq phases possibles, dont des sarcophages, des marionnettes et une tête géante.', 'Difficulté : 4/5.', 'En avion, utilise les tirs concentrés quand tu dois esquiver. Pendant les phases où des objets flottent, reste attentif aux ouvertures plutôt que de chercher à infliger des dégâts en continu.'),
   (9, 1, 'Corbin Claquebec, un oiseau territorial qui protège son nid.', 'Combat aérien avec œufs, plumes et projectiles. La dernière phase te demande encore plus de précision.', 'Difficulté : 4/5.', 'Reste près  bord de ton écran pour mieux lire les trajectoires.'),
   (10, 1, 'Allumette le dragon, un dragon qui garde son territoire dans les nuages.', 'Plateformes mouvantes, anneaux de feu et tête qui se divise en trois lance-flammes.', 'Difficulté : 4/5.', 'Conserve toujours une plateforme de repli. Dans la phase finale, place-toi à une distance, utilise le Roundabout pour pouvoir attaquer ton adversaire même de dos.'),
   (11, 1, 'Régina Nectar, une patronne abeille qui règne sur une ruche organisée comme un bureau.', 'Tu dois grimper sur des plateformes tandis que ses attaques arrivent de plusieurs directions.', 'Difficulté : 5/5.', 'Monte en anticipant la plateforme suivante. Dans la phase où elle lance des projectiles, évite de te retrouver coincé contre un bord, utilise le Chaser et le Roundabout pour toucher les ennemies difficile à atteindre.'),
   (12, 1, 'Capitaine Barbedécume, un capitaine pirate aidé par son équipage et son navire.', 'Le bateau attaque de son côté tandis que le capitaine invoque différents animaux.', 'Difficulté : 3/5.', 'Observe le signal du bateau avant son attaque. Quand il ouvre la bouche pour aspirer, prépare-toi à éviter ce qui suit et continue de tirer sur le capitaine, le charge et le Lobber sont intéressant car le boss est statiques.'),
   (13, 1, 'Babette Descène, une actrice de théâtre qui change de rôle au fil du spectacle.', 'Les décors changent entre les actes, avec des accessoires et des attaques de scène.', 'Difficulté : 3/5.', 'Surveille les indices visuels du décor. Dans les phases de mariage, fais attention aux projectiles qui arrivent du haut de ton écran, utilise le Chaser lorsque les projectiles sont nombreux et le Charge lorsque la voie est libre pour faire de gros dégâts.'),
   (14, 1, 'Briscard Gerebil, une souris ingénieuse qui se bat depuis une machine de guerre improvisée.', 'Arsenal bricolé, pièges, puis combat contre un énorme chat.', 'Difficulté : 3/5.', 'Evite les bombes au sol dès leur apparition, le Spread et le Roundabout sont de bonnes options pour être polyvalent sur les différentes phase.'),
   (15, 1, 'Robot du Docteur Kahl, une machine de guerre conçue et contrôlée par le docteur Kahl.', 'Plusieurs parties du robot doivent être détruites avant de pouvoir atteindre son cœur, puis vient une longue poursuite aérienne.', 'Difficulté : 5/5.', 'Détruis les composants dans un ordre qui libère de la place. Le cœur est vulnérable après les autres parties ; mémorise les trajectoires des projectiles au lieu de voler au hasard.'),
   (16, 1, 'Gorgonella, une sirène qui commande des créatures marines et possède un pouvoir pétrifiant.', 'Anguilles, poissons et méduses, puis un rayon qui te transforme en pierre.', 'Difficulté : 4/5.', 'quand son regard te pétrifie, martèle la commande de tir pour te libérer plus vite. Garde de la place autour de ton avion et ne confonds pas les animations attaque avec les moments sûrs.'),
   (17, 1, 'Loco-fantôme, un train hanté peuplé de fantômes et de créatures surnaturelles.', 'Tu te bats sur un chariot mobile et dois déplacer les plateformes en parant les leviers roses.','Difficulté : 4/5.' , 'Utilise les parades pour déplacer le chariot au bon moment, utilise le Spread pour les pharse raprocher et a distance privilégie le Charge.'),
   (18, 1, 'King Dice, le bras droit du Diable et le maître du casino.', 'Il faut traverser son plateau et affronter les mini-boss sélectionnés par les dés avant de le combattre.','Difficulté : 5/5.' , 'Entraîne-toi à contrôler le dé pour atteindre les cases voulues. Pendant son combat final, pare les petits personnages roses qui traversent ton écran.'),
   (19, 1, 'Le diable, le grand antagoniste qui a parié avec Cuphead et Mugman et réclame les âmes des débiteurs.', 'Transformations, attaques de chauves-souris, plateformes réduites et phases successives.','Difficulté : 5/5.' , 'Dans la première phase, mémorise les signaux de ses transformations. Dans la dernière, surveille la plateforme et les projectiles avant de chercher à infliger des dégâts, utilise le Spread après la première phase.'),
   (20, 1, 'Le géant, un géant des montagnes entouré de gnomes.', 'attaques au sol, gnomes qui te gênent et combat dans son corps.','Difficulté : 3/5.' , 'Surveille le sol et les projectiles des gnomes. Dans la dernière phase, identifie rapidement les zones sûres.'),
   (21, 1, 'La mafia insecte, un gang insectes criminels dans une distillerie.', 'Araignée gangster, insectes armés et fourmilier.','Difficulté : 3/5.' , 'Elimine les ennemis secondaires quand ils deviennent gênants et surveille les changements de niveau de des ennemies.'),
   (22, 1, 'Le sorcier des glaces, .', '.','Difficulté : /5.' , '.'),
   (23, 1, 'un magicien qui contrôle le froid et se transforme en créatures monstrueuses.', 'Attaques glacées, boule de neige géante et machine de glace.','Difficulté : 4/5.' , 'Repère les projectiles avant de sauter. Dans la dernière phase, utilise les ouvertures entre les attaques circulaires.'),
   (24, 1, 'La vache cow-girl, une cow-girl du Far West qui défend son territoire.', 'Combat aérien, lasso, dynamite, puis transformation en saucisse, en conserve !','Difficulté : 4/5.' , 'Privilégie la précision en avion et surveille les projectiles qui changent de direction. Apprends les trajectoires de chaque transformation.'),
   (25, 1, 'Escadrille canine, une escadrille de chiens pilotes.', 'Combat aérien, avions ennemis et écran qui pivote.','Difficulté : 5/5.' , 'Surveille les repères de de ton écran plutôt que tes habitudes de déplacement. Lorsque la caméra tourne, adapte ta position puis attaque.'),
   (26, 1, 'Le chef pâtissier, le pâtissier chargé de préparer la tarte de Mme Chalice, qui révèle ses véritables intentions.', 'Ingrédients vivants, attaques de sucre et de feu, puis un combat final intense.','Difficulté : 5/5.' , 'Utilise une arme à bonne portée et concentre-toi sur les menaces immédiates. Les projectiles roses sont précieux pour les parades et la jauge spéciale.'),
   (27, 1, 'Forest Follies, le premier niveau run & gun de jeu, cuphead traverse une forêt peuplée de petites créatures végétales. L’ambiance est celle d’une forêt de dessin animé pleine de vie, mais hostile.', 'Pluie de glands, ennemis-fleurs, champignons rebondissants et machine qui fabrique des glands à détruire.','Difficulté : 1.5/5.' , 'Utilise le Chaser si tu veux te concentrer sur les déplacements plutôt que viser, particulièrement utile sur les run & gun.'),
   (28, 1, 'Treetop Trouble, tu progresses dans un environnement perché dans les arbres, au milieu d’insectes et de créatures qui défendent leur territoire.', 'Plateformes étroites, ennemis qui sautent, insectes volants et passages où une chute peut te coûter une vie.','Difficulté : 2.5/5.' , 'Équipe la Smoke Bomb si tu l’as achetée : elle facilite les esquives pendant les sauts.'),
   (29, 1, 'Funfair Fever, cuphead s’aventure dans une fête foraine loufoque, peuplée d’artistes de cirque, de jouets vivants et de personnages qui veulent lui barrer la route.', 'Trampolines, ballons, boulets de canon, clowns et plusieurs adversaires ressemblant à des mini-boss, dont un hot-dog géant à la fin.','Difficulté : 3/5.' , 'Le Spread est très efficace car beaucoup d’ennemis proches.'),
   (30, 1, 'Funhouse Frazzle, cuphead entre dans une maison de fête foraine déformée, où les lois de la gravité et de l’orientation semblent ne plus fonctionner normalement.', 'Gravité inversée, parcours en zigzag, plateformes trompeuses et obstacles qui perturbent tes repères visuels.','Difficulté : 3.5/5.' , 'Concentre-toi sur la position réelle de ton personnage plutôt que sur le décor, le Chaser est très utile car dans ce niveau il est préférable de ce concentrer sur sa position.'),
   (31, 1, 'Rugged Ridge, cuphead gravit une montagne fantastique inspirée de l’art surréaliste et de créatures mythologiques. Le décor devient de plus en plus étrange à mesure qu’il approche des ruines.', 'Chèvres qui lancent des pioches, plateformes mobiles, ascenseur rempli d’ennemis, statues cracheuses d’huile et course finale face à un cyclope.','Difficulté : 4/5.' , 'Pendant la poursuite finale, privilégie la vitesse et les esquives plutôt que de tirer, le cyclope est un obstacle à esquiver, pas un boss que tu peux éliminer.'),
   (32, 1, 'Perilous Piers, cuphead traverse des quais dangereux au milieu d’une guerre loufoque entre créatures marines. L’ambiance mélange pirates, crustacés et aventures en mer.', 'Poissons volants, crabes, homard qui attaque à répétition, plateformes au-dessus de l’eau.','Difficulté : 5/5.' , 'Dans la séquence de la pieuvre, pare régulièrement le joyau rose pour la faire avancer, tu peux utiliser une combinaison de Spread et Chaser c’est la partie la plus dure.');
   
   
   

INSERT INTO NPC_details
   (npc_id, poi_id, description)
VALUES
   (1, 1, 'Mac, personnage en forme de pomme. Il est assis près du pont de la première île. Il accueille le joueur et lui offre un cadeau lors de la première interaction.'),
   (2, 1, 'Quint, personnage en forme de pièce qui cache son argent sur la carte, A vous de les trouver !.'),
   (3, 1, 'Chip, est un personnage travailleur, il souhaite économiser suffisamment pour réparer sa lame abîmée, il exprime également son mécontentement envers les débiteurs du casino et King Dice.'),
   (4, 1, 'Angel, personnage vigilante et spontanée. A la vu de Cuphead, elle le prend pour un fantôme et est prête à utiliser une parade pour se défendre. Elle se montre ensuite serviable en expliquant comment vaincre les fantômes du mausolée.'),
   (5, 1, 'Elder Kettle, il est le gardien et mentor de Cuphead et mugman, il intervient dans le début du jeu et le tutoriel.'),
   (6, 1, 'Le marchand, porcin installé dans sa boutique, le Porkrinds Emporium. Il permet au joueur de prendre des armes et des charmes (objets) contre des pièces. Il revient sur plusieurs îles.'),
   (7, 1, 'Le passeur, Personnage qui permet de voyager en bateau entre les îles. Son interaction sert à accéder aux DLC et à revenir aux autres îles.'),
   (8, 1, 'Le mécanicien-aviateur, gourde passioné de machines volantes présent lors du tutoriel pour aviateur.'),
   (9, 1, 'Quadratus est un personnage mystérieux en forme de fontaine, situé sur l’île 2. Il donne des conseils au joueur et lui propose une énigme liée aux nombres et aux combats de boss.'),
   (10, 1, 'Le groupe de chanteur, ce groupe de personnages chanteurs se trouve sur la deuxième île 2. Ils discutent avec le joueur et chantent ensemble lorsque vous aurez remplit certaines conditions liées à leur rencontre.'),
   (11, 1, 'Lucien, personnage en forme d’ampoule portant une tenue universitaire, se trouve près du deuxième mausolée et d’un pont en bois. Il s’intéresse aux mystères de l’île et étudie Quadratus, un être mystérieux lié à l’eau et aux nombres.'),
   (12, 1, 'Ginger, personnage en forme de fille en pain d’épices, se trouve près du niveau de Wally Warbles. Elle demande au joueur de trouver un raccourci secret permettant de traverser l’île. Lorsque le joueur découvre ce passage et revient lui parler, elle lui offre un cadeau en récompense.'),
   (13, 1, 'Buster, personnage jongleur situé près du niveau du dragon Grim Matchstick, propose un défi au joueur. Il lui demande d’effectuer quatre parades consécutives sans toucher le sol. Une fois le défi réussi, le joueur peut revenir lui parler pour recevoir un cadeau en récompense.'),
   (14, 1, 'Tully, est une tortue installée près du rivage. Il propose un défi consistant à terminer les niveaux Run and Gun sans éliminer d’ennemis. Ce défi permet de débloquer un filtre qui va complètement changé les couleurs.'),
   (15, 1, 'Silverworth, est une fourche argentée portant un costume rouge et un monocle. Il propose au joueur d’obtenir le rang A- ou supérieur dans les différents niveaux concernés pour débloquer un filtre visuel.'),
   (16, 1, 'Cora,  est une jeune pirate aux cheveux turquoise et aux vêtements rouges, située près de la plage. Elle conseille à Cuphead et Mugman de varier leurs armes selon les ennemis rencontrés.'),
   (17, 1, 'Ludwig est un phonographe qui préfère la musique minimaliste. Il reproche à Wolfgang de compliquer inutilement les mélodies et demande au joueur de le convaincre que « moins, c’est plus ». En lui reparlant après avoir suivi ses indications, le joueur peut débloquer une musique.'),
   (18, 1, 'Wolfgang est une vieille radio qui préfère les musiques riches et complexes. Il critique Ludwig et sa philosophie minimaliste, puis avertit Cuphead et Mugman de ne pas l’écouter. En poursuivant les échanges entre les deux personnages, il est possible de revenir à la musique originale.'),
   (19, 1, 'Buckley, Personnage en forme de chat qui tient un journal et se trouve près du village de l’île du DLC. Il offre trois pièces au joueur lorsqu’il lui parle, ce qui permet d’acheter des équipements auprès du marchand.'),
   (20, 1, 'Senita, Cactus portant une robe bleue et une fleur sur la tête. Assise près d’un feu de camp dans la zone désertique, elle raconte les exploits de Mme Chalice. En terminant les combats de boss avec Mme Chalice, le joueur débloque un filtre pour celle-ci.'),
   (21, 1, 'Inspector Graves, Fantôme portant un chapeau de détective et utilisant une loupe pour examiner les environs du cimetière. Il fournit des indices qui aident à résoudre l’énigme des pierres tombales et à découvrir le combat secret du DLC.'),
   (22, 1, 'Lumin, Digby et Prynne, Trois outils de mine : une lanterne, une pelle et une pioche. Ils se trouvent près du marchand et parlent de leur compétition d’escalade. Leurs indications permettent de résoudre l’énigme liée au cimetière.'),
   (23, 1, 'Le Roi des jeux, Personnage royal qui organise les épreuves du King’s Leap. Il propose cinq défis contre des pièces d’échecs et récompense le joueur avec des pièces d’or après les victoires. Il s’agit d’un personnage organisateur, distinct de ses champions.');

INSERT INTO List_Pois
   (poi_id, list_id)
VALUES
   (1, 1);

INSERT INTO Merchant_Items
   (poi_id, item_id, price)
VALUES
   (1, 2, 4),
   (1, 3, 4),
   (1, 4, 4),
   (1, 5, 4),
   (1, 6, 4),
   (1, 7, 4),
   (1, 8, 4),
   (1, 9, 4),
   (1, 10, 3),
   (1, 11, 4),
   (1, 12, 3),
   (1, 13, 3),
   (1, 14, 3),
   (1, 15, 5),
   (1, 16, 4),
   (1, 17, 3),
   (1, 18, 1);

INSERT INTO User_POI_Progress
   (user_id, poi_id, status, discovered_at, completed_at)
VALUES
   (1, 1, 'completed', '2026-10-06 11:00:00', '2026-10-06 11:30:00');
   
   

#Test avec quelque requête simple:

Select * From Boss_Details Where boss_id = 7;
Select * From Items Order by price DESC;
Select * From Map_Zones Order by order_ ASC;
Select boss.boss_id, boss.lore, boss.statistics, boss.tips From Boss_Details boss Join Points_of_Interest points On boss.poi_id = points.poi_id;

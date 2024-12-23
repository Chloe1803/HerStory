using HerStory.Server.Data;
using HerStory.Server.Models;
using HerStory.Server.Enums;
using BCrypt.Net;

namespace HerStory.Server
{
    public class Seed
    {
        private readonly ApplicationDbContext _context;

        public Seed(ApplicationDbContext context)
        {
            this._context = context;
        }

        public void SeedData()
        {
            //var roles = GetRoles();
            //_context.Role.AddRange(roles);

            //var users = GetUsers();
            //_context.AppUser.AddRange(users);

            //var fields = GetFields();
            //_context.Field.AddRange(fields);

            //var categories = GetCategories();
            //_context.Category.AddRange(categories);

            //var portraits = GetPortraits();
            //_context.Portrait.AddRange(portraits);

            //var visitor = new Role { Name = RoleName.Visitor, Description = "Utilisateur en attente d'attribution du rôle de contributeur" };
            //_context.Role.Add(visitor);


            _context.SaveChanges();

        }

        private List<Role> GetRoles()
        {
            return new List<Role>
            {
                new Role {  Name = RoleName.Banned, Description = "Utilisateur banni" },
                new Role {  Name = RoleName.Contributor, Description = "Utilisateur qui peut soumettre des ajouts ou des modifications aux portraits" },
                new Role { Name = RoleName.Reviewer, Description = "Utilisateur peut relire les portrait soumis et ajouter de nouveaux contributeurs" },
                new Role {  Name = RoleName.Admin, Description = "Utilisateur qui peut modifiier les assignations de relectures et bannir des utilisateurs" },
                new Role {  Name = RoleName.SuperAdmin, Description = "Utilisateur qui peut nommer de nouveaux Admins" }
            };
        }

        private List<AppUser> GetUsers()
        {
            return new List<AppUser>
            {
                new AppUser { FirstName="BannedUser", LastName="Banned", CreatedAt= new DateTime(2024, 12, 05), Email="banned@test.com", HashedPassword=BCrypt.Net.BCrypt.HashPassword("123"), RoleId = 3},
                new AppUser { FirstName="ContributorUser", LastName="Contributor", CreatedAt = new DateTime(2024, 12, 05), Email="contributor@test.com", HashedPassword=BCrypt.Net.BCrypt.HashPassword("123"), RoleId = 4  },
                new AppUser { FirstName="ReviewerUser", LastName="Reviewer", CreatedAt = new DateTime(2024, 12, 05), Email="reviewer@test.com", HashedPassword=BCrypt.Net.BCrypt.HashPassword("123"), RoleId = 5 },
                new AppUser { FirstName="AdminUser", LastName="Admin", CreatedAt = new DateTime(2024, 12, 05), Email="admin@test.com", HashedPassword=BCrypt.Net.BCrypt.HashPassword("123"), RoleId = 6 },
                new AppUser { FirstName="SuperAdminUser", LastName="SuperAdmin", CreatedAt = new DateTime(2024, 12, 05), Email="superadmin@test.com", HashedPassword=BCrypt.Net.BCrypt.HashPassword("123"), RoleId = 7}
            };
        }

        private List<Field> GetFields()
        {
            return new List<Field> {
                new Field { Name = "Informatique et Technologie" },
                new Field { Name = "Sciences exactes" },
                new Field { Name = "Sciences du vivant" },
                new Field { Name = "Sciences humaines et sociales" },
                new Field { Name = "Arts et Culture" },
                new Field { Name = "Sports" },
                new Field { Name = "Entrepreneuriat et Innovation" },
                new Field { Name = "Politique et Géopolitique" },
                new Field { Name = "Ingénierie et Industrie" },
                new Field { Name = "Santé et Bien-être" },
                new Field { Name = "Environnement et Développement durable" },
                new Field { Name = "Éducation et Formation" },
                new Field { Name = "Histoire et Géographie" },
                new Field { Name = "Langues et Littérature" },
            };
        }

        private List<Category> GetCategories()
        {
            return new List<Category> {
                new Category {Name= "Scientifique" },
                new Category {Name= "Artiste" },
                new Category {Name= "Sportive" },
                new Category {Name= "Ingénieure" },
                new Category {Name= "Entrepreneure"},
                new Category {Name= "Éducatrice"},
                new Category {Name=  "Exploratrice"},
                new Category {Name= "Responsable de politiques"},
                new Category {Name= "Militante"},
                new Category {Name= "Innovatrice"},
                new Category {Name= "Chercheuse"},
                new Category {Name= "Botaniste"},
                new Category {Name= "Zoologiste"},
            };
        }

        private List<Portrait> GetPortraits() 
        { 
            return new List<Portrait>
            {
                new Portrait {FirstName = "Ada", LastName = "Lovelace", DateOfBirth=new DateTime(1815, 12, 10), DateOfDeath=new DateTime(1852, 11, 27), CountryOfBirth="Royaume-Uni", CreatedAt=new DateTime(2024, 12 ,05), BiographyAbstract="Ada Lovelace, de son nom complet Augusta Ada King, comtesse de Lovelace, née Ada Byron le 10 décembre 1815 à Londres et morte le 27 novembre 1852 à Marylebone dans la même ville, est une pionnière de la science informatique.", BiographyFull="Elle est principalement connue pour avoir conçu et décrit le premier programme informatique publié, lors de son travail sur un ancêtre de l'ordinateur : la machine analytique de Charles Babbage. Le formalisme inédit de son algorithme, ainsi que la présence de la première boucle conditionnelle connue, font qu'Ada Lovelace est largement considérée comme la première développeuse informatique de l'histoire. Elle a également entrevu et décrit certaines possibilités offertes par les calculateurs universels, allant bien au-delà du calcul numérique et de ce qu'imaginaient Babbage et ses contemporains.", PhotoUrl="https://upload.wikimedia.org/wikipedia/commons/a/a4/Ada_Lovelace_portrait.jpg" },
                new Portrait {FirstName = "Marie", LastName = "Curie", DateOfBirth=new DateTime(1867, 11, 7), DateOfDeath=new DateTime(1934, 7, 4), CountryOfBirth="Pologne", CreatedAt=new DateTime(2024, 12 ,05), BiographyAbstract="Marie Curie, née Maria Skłodowska le 7 novembre 1867 à Varsovie, au sein du royaume du Congrès (actuelle Pologne), et morte le 4 juillet 1934 à Passy, en Haute-Savoie, est une physicienne et chimiste polonaise, naturalisée française.", BiographyFull="Pionnière dans l'étude de la radioactivité, elle fut la première femme à recevoir un prix Nobel et la seule à en recevoir dans deux disciplines différentes : le prix Nobel de physique en 1903, conjointement avec son mari Pierre Curie et Henri Becquerel, et le prix Nobel de chimie en 1911. Elle est également la première femme professeure à l'université de Paris.", PhotoUrl="https://upload.wikimedia.org/wikipedia/commons/7/7e/Marie_Curie_c1920.jpg" },
            };
        }

        private List<PortraitCategory> GetPortraitCategories()
        {
            return new List<PortraitCategory>
            {
                new PortraitCategory { PortraitId = 0, CategoryId = 1 },
                new PortraitCategory { PortraitId = 1, CategoryId = 10 },
            };
        }

        private List<PortraitField> GetPortraitFields()
        {
            return new List<PortraitField>
            {
                new PortraitField { PortraitId = 0, FieldId = 0 },
                new PortraitField { PortraitId = 1, FieldId = 1 },
            };
        }

    }
}

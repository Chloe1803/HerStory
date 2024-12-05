

namespace HerStory.Server.Models
{
    public class AppUser 
    {
        public int Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public required string HashedPassword { get; set; }
        public required DateTime CreatedAt { get; set; }

        public string? AboutMe { get; set; }
        public required int RoleId { get; set; }
        public  Role Role { get; set; } = null!;

        public int? LastRoleChangeId { get; set; }  
        public RoleChange? LastRoleChange { get; set; }
        public ICollection<AppUserNotification>? Notifications { get; set; }

        // Contributions créées par l'utilisateur
        public ICollection<Contribution>? Contributions { get; set; }
        // Contributions revues par l'utilisateur
        public ICollection<Contribution>? Reviews { get; set; }

    }
}

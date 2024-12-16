using HerStory.Server.Enums;
using System.Text.Json.Serialization;

namespace HerStory.Server.Models
{
    public class Role
    {
        public int Id { get; set; }
        public required RoleName Name { get; set; }
        public required string Description { get; set; }
      
        public ICollection<AppUser>? AppUsersWithRole { get; set; }
    
        public ICollection<RoleChange>? RoleChanges { get; set; }
    }
}

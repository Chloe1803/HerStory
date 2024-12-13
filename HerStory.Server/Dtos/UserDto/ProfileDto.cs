using HerStory.Server.Models;

namespace HerStory.Server.Dtos.UserDto
{
    public class ProfileDto
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public  DateTime CreatedAt { get; set; }
        public string AboutMe { get; set; }
        public Role Role { get; set; } = null!;
        public RoleChange? LastRoleChange { get; set; }
        public int? numberOfContributions { get; set; }
        public int?  numberOfReviews { get; set; }
    }
}

using HerStory.Server.Enums;

namespace HerStory.Server.Dtos.RoleChangeDto
{
    public class RoleChangeProfileDto
    {
        public int Id { get; set; }
        public RoleDto RequestedRole { get; set; }
        public string Status { get; set; }

    }
}

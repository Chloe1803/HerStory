namespace HerStory.Server.Dtos.RoleChangeDto
{
    public class RoleChangeListDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
        public RoleDto RequestedRole { get; set; }

    }
}

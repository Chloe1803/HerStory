namespace HerStory.Server.Dtos.UserDto
{
    public class RegisterDto
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public string? AboutMe { get; set; }
    }
}

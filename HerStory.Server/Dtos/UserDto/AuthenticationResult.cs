using HerStory.Server.Models;

namespace HerStory.Server.Dtos.UserDto
{
    public class AuthenticationResult
    {
        public bool IsSuccess { get; set; }
        public string? ErrorMessage { get; set; }
        public AppUser? User { get; set; }
    }
}

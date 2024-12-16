using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IUserService
    {
        public Task<AuthenticationResult> AuthenticateAsync(string email, string password);
        public Task<AuthenticationResult> RegisterAsync(RegisterDto user);
        public Task<ProfileDto> GetProfileAsync(int id);
        public Task<AppUser> GetUserById(int id);
    }
}

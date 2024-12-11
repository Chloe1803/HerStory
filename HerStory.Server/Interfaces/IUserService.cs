using HerStory.Server.Dtos.UserDto;

namespace HerStory.Server.Interfaces
{
    public interface IUserService
    {
        public Task<AuthenticationResult> AuthenticateAsync(string email, string password);
        public Task<AuthenticationResult> RegisterAsync(RegisterDto user);
    }
}

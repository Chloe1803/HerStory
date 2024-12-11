using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IUserRepository
    {
        public Task<AppUser> GetUserByEmailAsync(string email);
        public Task<AppUser> CreateUser(AppUser user);
        public Task<bool> UserEmailExists(string email);
    }
}

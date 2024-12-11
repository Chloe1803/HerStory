using HerStory.Server.Data;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace HerStory.Server.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly ApplicationDbContext _context;

        public UserRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<AppUser> CreateUser(AppUser user)
        {
            await _context.AppUser.AddAsync(user);  
            await _context.SaveChangesAsync();
            return await _context.AppUser
                .Include(u => u.Role)
                .FirstOrDefaultAsync(u => u.Id == user.Id);
        }

        public async Task<AppUser> GetUserByEmailAsync(string email)
        {
            return await _context.AppUser.Include(u => u.Role).FirstOrDefaultAsync(u => u.Email == email);
        }

        public async Task<bool> UserEmailExists(string email)
        {
            return await _context.AppUser.AnyAsync(u => u.Email == email);
        }
    }
}

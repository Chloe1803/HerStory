using HerStory.Server.Data;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore;


namespace HerStory.Server.Repositories
{
    public class RoleChangeRepository : IRoleChangeRepository
    {
        private readonly ApplicationDbContext _context;
        public RoleChangeRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public async Task<RoleChange> CreateRoleChange(RoleChange roleChange)
        {
            await _context.RoleChange.AddAsync(roleChange);
            await _context.SaveChangesAsync();

            return await _context.RoleChange
                .Include(rc=> rc.AppUser)
                .FirstOrDefaultAsync(rc => rc.Id == roleChange.Id);
        }

        public async Task<RoleChange> GetLastRoleChangeByUser(AppUser user)
        {
            return await _context.RoleChange
                .Include(rc => rc.AppUser)
                .Where(rc => rc.AppUser.Id == user.Id)
                .Where(rc => rc.IsLastChange == true)
                .FirstOrDefaultAsync(rc => rc.AppUser.Id == user.Id);
        }

        public async Task<bool> UpdateRoleChange(RoleChange roleChange)
        {
            try
            {
                _context.Update(roleChange);
                await _context.SaveChangesAsync();
                return true; 
            }
            catch (Exception)
            {
               
                return false;
            }
        }

    }
}

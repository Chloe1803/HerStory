﻿using HerStory.Server.Data;
using HerStory.Server.Enums;
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
                .Include(rc => rc.RequestedRole)
                .FirstOrDefaultAsync(rc => rc.Id == roleChange.Id);
        }

        public async Task<ICollection<RoleChange>> GetAllPendingRoleChanges()
        {
            return await _context.RoleChange
                .Include(rc => rc.AppUser)
                .Include(rc => rc.RequestedRole)
                .Where(rc => rc.Status == RoleChangeStatus.Pending)
                .ToListAsync();
        }

        public async Task<RoleChange> GetLastRoleChangeByUser(AppUser user)
        {
            if (user == null)
            {
                Console.WriteLine("Error in GetLastRoleChangeByUser: user is null.");
                throw new ArgumentNullException(nameof(user));
            }

            Console.WriteLine($"Getting last role change for user {user.Id}...");

            try
            {
                // Exemple d'une requête LINQ (selon votre implémentation)
                var lastRoleChange = await _context.RoleChange
                    .Where(rc => rc.AppUserId == user.Id && rc.IsLastChange)
                    .FirstOrDefaultAsync();

                Console.WriteLine(lastRoleChange != null
                    ? $"Last role change found: {lastRoleChange.Id}, Status: {lastRoleChange.Status}"
                    : "No last role change found.");

                return lastRoleChange;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception in GetLastRoleChangeByUser: {ex.Message}");
                throw;
            }
        }

        public Task<RoleChange> GetRoleChangeById(int id)
        {
            return _context.RoleChange
                .Include(rc => rc.AppUser)
                .Include(rc => rc.RequestedRole)
                .FirstOrDefaultAsync(rc => rc.Id == id);
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

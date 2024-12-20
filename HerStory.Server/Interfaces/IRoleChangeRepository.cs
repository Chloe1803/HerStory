using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IRoleChangeRepository
    {
        public Task<RoleChange> CreateRoleChange(RoleChange roleChange);
        public Task<bool> UpdateRoleChange(RoleChange roleChange);
        public Task<RoleChange> GetLastRoleChangeByUser(AppUser user);
        public Task<ICollection<RoleChange>> GetAllPendingRoleChanges();

        public Task<RoleChange> GetRoleChangeById(int id);    

    }
}

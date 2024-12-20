using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IRoleChangeService
    {
        public Task<RoleChange> RequestRoleChange(AppUser user, int RequestedRoleId);
        public Task<ICollection<RoleChangeListDto>> GetAllPendingRoleChanges(AppUser user);
        public Task<RoleChange> GetRoleChangeById(int id);
        public Task<bool> AcceptRoleChange(AppUser respondingUser, RoleChange roleChange);
        public Task<bool> RejectRoleChange(AppUser respondingUser, RoleChange roleChange);
    }
}

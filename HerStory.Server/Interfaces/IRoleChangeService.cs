using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IRoleChangeService
    {
        public Task<RoleChange> RequestRoleChange(AppUser user, int RequestedRoleId);
    }
}

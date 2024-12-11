using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.IdentityModel.Protocols.Configuration;

namespace HerStory.Server.Services
{
    public class RoleChangeService : IRoleChangeService
    {
        private readonly IRoleChangeRepository _roleChangeRepository;

        public async Task<RoleChange> RequestRoleChange(AppUser user, int RequestedRoleId)
        {
            var lastRoleChange = await _roleChangeRepository.GetLastRoleChangeByUser(user);

            if (lastRoleChange != null && lastRoleChange.Status == Enums.RoleChangeStatus.Pending) {
                return null;
            }

            var newRoleChange = new RoleChange
            {
                AppUserId = user.Id,
                AppUser = user,
                RequestedRoleId = RequestedRoleId,
                Status = Enums.RoleChangeStatus.Pending,
                RequestedAt = DateTime.Now,
                IsLastChange = true
            };

            lastRoleChange.IsLastChange = false;
            await _roleChangeRepository.UpdateRoleChange(lastRoleChange);

            return await _roleChangeRepository.CreateRoleChange(newRoleChange);

        }
    }
}

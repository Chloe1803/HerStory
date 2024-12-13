using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.IdentityModel.Protocols.Configuration;

namespace HerStory.Server.Services
{
    public class RoleChangeService : IRoleChangeService
    {
        private readonly IRoleChangeRepository _roleChangeRepository;
        private readonly IUserRepository _userRepository;

        public RoleChangeService(IRoleChangeRepository roleChangeRepository, IUserRepository userRepository)
        {
            _roleChangeRepository = roleChangeRepository;
            _userRepository = userRepository;
        }

        public async Task<RoleChange> RequestRoleChange(AppUser user, int RequestedRoleId)
        {
            Console.WriteLine($"User : {user?.Id} RequestedRoleId : {RequestedRoleId}");

            try
            {
                // Récupére le dernier changement de rôle
                var lastRoleChange = await _roleChangeRepository.GetLastRoleChangeByUser(user);
               

                // Vérifie si un changement de rôle en attente existe déjà
                if (lastRoleChange != null && lastRoleChange.Status == Enums.RoleChangeStatus.Pending)
                {
     
                    return null;
                }

                // Crée une nouvelle requête de changement de rôle
                var newRoleChange = new RoleChange
                {
                    AppUserId = user.Id,
                    AppUser = user,
                    RequestedRoleId = RequestedRoleId,
                    Status = Enums.RoleChangeStatus.Pending,
                    RequestedAt = DateTime.Now,
                    IsLastChange = true
                };

                // Marque l'ancien changement comme obsolète (si applicable)
                if (lastRoleChange != null)
                {
                    lastRoleChange.IsLastChange = false;
                    await _roleChangeRepository.UpdateRoleChange(lastRoleChange);
                }

                // Sauvegarde le nouveau changement de rôle
                var createdRoleChange = await _roleChangeRepository.CreateRoleChange(newRoleChange);
               
                if (createdRoleChange != null)
                {
                    user.LastRoleChangeId = createdRoleChange.Id;
                    await _userRepository.UpdateUser(user);
                }

                return createdRoleChange;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in RequestRoleChange: {ex.Message}");
                throw;
            }
        }

    }
}

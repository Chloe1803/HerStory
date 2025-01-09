using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using HerStory.Server.Constants;
using AutoMapper;
using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Enums;

namespace HerStory.Server.Services
{
    public class RoleChangeService : IRoleChangeService
    {
        private readonly IRoleChangeRepository _roleChangeRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        private readonly ILogger<RoleChangeService> _logger ;

        public RoleChangeService(IRoleChangeRepository roleChangeRepository, IUserRepository userRepository, IMapper mapper, ILogger<RoleChangeService> logger)
        {
            _roleChangeRepository = roleChangeRepository;
            _userRepository = userRepository;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<bool> AcceptRoleChange(AppUser respondingUser, RoleChange roleChange)
        {
            var userToUpdate = roleChange.AppUser;
            userToUpdate.RoleId = roleChange.RequestedRoleId;
            userToUpdate.Role = roleChange.RequestedRole;

            try
            {
                await _userRepository.UpdateUser(userToUpdate);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error in AcceptRoleChange: {ex.Message}");
                return false;

            }

            roleChange.Status =RoleChangeStatus.Approved;
            roleChange.ProcessedByUserId = respondingUser.Id;
            roleChange.ProcessedByUser = respondingUser;
            roleChange.ProcessedAt = DateTime.Now;

            try
            {
                await _roleChangeRepository.UpdateRoleChange(roleChange);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error in AcceptRoleChange: {ex.Message}");
                return false;
            }
            return true;
        }


        public async Task<ICollection<RoleChangeListDto>> GetAllPendingRoleChanges(AppUser user)
        {
            var allPendingRoleChanges = await _roleChangeRepository.GetAllPendingRoleChanges();

            // Filtre les demandes de changement de rôle en fonction de l'accès de l'utilisateur
            var filteredRoleChanges = allPendingRoleChanges
                .Where(rc => RoleConstants.RoleHierarchy.HasAccess(user.Role.Name, rc.RequestedRole.Name))
                .ToList();

            var result = _mapper.Map<ICollection<RoleChangeListDto>>(filteredRoleChanges);

            return result;
        }

        public Task<RoleChange> GetRoleChangeById(int id)
        {
            return _roleChangeRepository.GetRoleChangeById(id);
        }

        public async Task<bool> RejectRoleChange(AppUser respondingUser, RoleChange roleChange)
        {
            roleChange.Status = RoleChangeStatus.Rejected;
            roleChange.ProcessedByUserId = respondingUser.Id;
            roleChange.ProcessedByUser = respondingUser;
            roleChange.ProcessedAt = DateTime.Now;

            try
            {
                await _roleChangeRepository.UpdateRoleChange(roleChange);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error in AcceptRoleChange: {ex.Message}");
                return false;
            }
            return true;
        }

        public async Task<RoleChange> RequestRoleChange(AppUser user, int RequestedRoleId)
        {
 
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

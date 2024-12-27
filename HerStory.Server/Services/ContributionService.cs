using AutoMapper;
using HerStory.Server.Dtos.ContributionDto;
using HerStory.Server.Enums;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore.Migrations.Operations;
using Microsoft.Extensions.Configuration.UserSecrets;

namespace HerStory.Server.Services
{
    public class ContributionService : IContributionService
    {
        private readonly IContributionRepository _contributionRepository;
        private readonly IMapper _mapper;
        public ContributionService(IContributionRepository contributionRepository, IMapper mapper)
        {
            _contributionRepository = contributionRepository;
            _mapper = mapper;

        }


        public Task<bool> ChangeReviewerAssignment(bool isAssigned, Contribution contribution, AppUser user)
        {
            //Si l'utilisateur est assigné on le retire comme reviewer sinon on l'assigne
            if (isAssigned)
            {
                contribution.Reviewer = null;
                contribution.ReviewerId = null;
                    
            } else
            {
                contribution.Reviewer = user;
                contribution.ReviewerId = user.Id;
            }

            var updated = _contributionRepository.UpdateContribution(contribution);
            return updated;
        }

        public async Task<Contribution> CreateContribution(NewContributionDto contributionDto, AppUser user)
        {
            var contribution = new Contribution
            {
                PortraitId = contributionDto.PortraitId,
                Contributor = user,
                ContributorId = user.Id,
                Status = ContributionStatus.Pending,
                CreatedAt = DateTime.Now,
                Details = new List<ContributionDetail>()
            };

            if (contributionDto.Changes != null)
            {
                foreach (var kvp in contributionDto.Changes)
                {
                    var fieldName = kvp.Key;  // Clé du dictionnaire (nom du champ)
                    var newValue = kvp.Value?.ToString() ?? string.Empty;  // Valeur du dictionnaire (nouvelle valeur)

                    // Crée un ContributionDetail pour chaque changement
                    var contributionDetail = new ContributionDetail
                    {
                        FieldName = Enum.TryParse(fieldName, true, out ContributionDetailFieldName fieldNameEnum)
                            ? fieldNameEnum  // Si l'énumération existe
                            : ContributionDetailFieldName.Unknown,  // Valeur par défaut ou "Unknown"
                        NewValue = newValue
                    };

                    contribution.Details.Add(contributionDetail);
                }
            }


            return await _contributionRepository.CreateContribution(contribution);
        }

        public async Task<Contribution> GetContributionById(int id)
        {
            return await _contributionRepository.GetContributionById(id);
        }

        public async Task<ContributionViewDto> GetContributionViewDtoById(int id)
        {
            var contribution = await _contributionRepository.GetContributionById(id);

            return _mapper.Map<ContributionViewDto>(contribution);
        }

        public async Task<ICollection<ContributionListDto>> GetPendingContributionsAssignedToUser(AppUser user)
        {
            var pendingContributions = await _contributionRepository.GetAllPendingContributions();


            return _mapper.Map<ICollection<ContributionListDto>>(pendingContributions.Where(c => c.ReviewerId == user.Id).ToList());
        }

        public async Task<ICollection<ContributionListDto>> GetPendingContributionsNotAssigned(AppUser user)
        {
            var pendingContributions = await _contributionRepository.GetAllPendingContributions();

            return _mapper.Map<ICollection<ContributionListDto>>(pendingContributions.Where(c => c.ReviewerId == null && c.ContributorId != user.Id).ToList());
        }
    }
}

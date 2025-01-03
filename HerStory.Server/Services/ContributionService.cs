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
        private readonly IPortraitService _portraitService;
        public ContributionService(IContributionRepository contributionRepository, IMapper mapper, IPortraitService portraitService)
        {
            _contributionRepository = contributionRepository;
            _mapper = mapper;
            _portraitService = portraitService;

        }

        public async Task<bool> AcceptContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user)
        {
            contribution.Status = ContributionStatus.Approved;
            contribution.ReviewedAt = DateTime.Now;
            contribution.ReviewComment = reviewDto.Comment;

            var update = await _contributionRepository.UpdateContribution(contribution);

            if (!update)
            {
                throw new InvalidOperationException($"Failed to update contribution with ID {contribution.Id}. The update was unsuccessful.");
            }

            //S'il n'y a pas de portrait associé à la contribution, on crée un nouveau portrait sion on le met à jour
            if (contribution.PortraitId == null)
            {
                var createPortrait = await _portraitService.CreatePortraitFromContribution(contribution);
                if (!createPortrait)
                    throw new InvalidOperationException($"Failed to create new portrait");

                return createPortrait;
            }
            else
            {
                var updatePortrait = await _portraitService.UpdatePortraitFromContribution(contribution);
                if (!updatePortrait)
                    throw new InvalidOperationException($"Failed to update portrait");

                return updatePortrait;
            }


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

        public async Task<bool> RejectContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user)
        {
            contribution.Status = ContributionStatus.Rejected;
            contribution.ReviewedAt = DateTime.Now;
            contribution.ReviewComment = reviewDto.Comment;

            return await _contributionRepository.UpdateContribution(contribution);

        }
    }
}

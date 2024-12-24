using HerStory.Server.Dtos;
using HerStory.Server.Enums;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;

namespace HerStory.Server.Services
{
    public class ContributionService : IContributionService
    {
        private readonly IContributionRepository _contributionRepository;
        public ContributionService(IContributionRepository contributionRepository)
        {
            _contributionRepository = contributionRepository;
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
    }
}

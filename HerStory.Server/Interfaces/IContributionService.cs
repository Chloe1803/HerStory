using HerStory.Server.Dtos;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IContributionService
    {
        public Task<Contribution> CreateContribution(NewContributionDto contributionDto, AppUser user);
    }
}

using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IContributionRepository
    {
        public Task<Contribution> CreateContribution(Contribution contribution);
    }
}

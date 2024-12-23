using HerStory.Server.Data;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;

namespace HerStory.Server.Repositories
{
    public class ContributionRepository : IContributionRepository
    {
        private readonly ApplicationDbContext _context;
        public ContributionRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public async Task<Contribution> CreateContribution(Contribution contribution)
        {
            await _context.Contribution.AddAsync(contribution);
            await _context.SaveChangesAsync();

            return contribution;
        }
    }
}

using HerStory.Server.Data;
using HerStory.Server.Enums;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore;


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

        public async Task<ICollection<Contribution>> GetAllPendingContributions()
        {
            var contributions = await _context.Contribution
                .Include(c => c.Portrait)
                .Include(c => c.Reviewer)
                .Include(c => c.Details)
                .Where(c => c.Status == ContributionStatus.Pending)
                .ToListAsync();

            return contributions;
        }

        public async Task<ICollection<Contribution>> GetAllUserContributions(AppUser user)
        {
            var contributions = await _context.Contribution
               .Include(c => c.Portrait)
               .Include(c => c.Reviewer)
               .Include(c => c.Details)
               .Where(c => c.ContributorId == user.Id)
               .OrderByDescending(c => c.CreatedAt)
               .ToListAsync();

            return contributions;
        }

        public async Task<Contribution> GetContributionById(int Id)
        {
            var contribution = await _context.Contribution
                .Include(c => c.Contributor)
                .Include(c => c.Reviewer)
                .Include(c => c.Portrait)
                    .ThenInclude(p => p.PortraitCategories)
                    .ThenInclude(pc => pc.Category)
                .Include(c => c.Portrait)
                    .ThenInclude(p => p.PortraitFields)
                    .ThenInclude(pf => pf.Field)
                .Include(c => c.Details)
                .FirstOrDefaultAsync(c => c.Id == Id);

            return contribution;
        }

        public async Task UpdateContribution(Contribution contribution)
        {
            _context.Update(contribution);
            await _context.SaveChangesAsync();

        }

    }
}

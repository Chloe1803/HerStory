﻿using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IContributionRepository
    {
        public Task<Contribution> CreateContribution(Contribution contribution);
        public Task<ICollection<Contribution>> GetAllPendingContributions();
        public Task<ICollection<Contribution>> GetAllUserContributions(AppUser user);
        public Task<Contribution> GetContributionById(int Id);
        public Task UpdateContribution(Contribution contribution);
    }
}

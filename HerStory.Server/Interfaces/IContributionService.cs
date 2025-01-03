using HerStory.Server.Dtos.ContributionDto;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IContributionService
    {
        public Task<Contribution> CreateContribution(NewContributionDto contributionDto, AppUser user);
        public Task<ICollection<ContributionListDto>> GetPendingContributionsNotAssigned(AppUser user);
        public Task<ICollection<ContributionListDto>> GetPendingContributionsAssignedToUser(AppUser user);
        public Task<Contribution> GetContributionById(int Id);
        public Task<ContributionViewDto> GetContributionViewDtoById(int Id);
        public Task<bool> ChangeReviewerAssignment(bool isAssigned, Contribution contribution, AppUser user);
        public Task<bool> RejectContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user);
        public Task<bool> AcceptContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user);
    }
}

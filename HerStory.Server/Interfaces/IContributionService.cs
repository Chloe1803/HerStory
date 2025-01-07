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
        public Task ChangeReviewerAssignment(bool isAssigned, Contribution contribution, AppUser user);
        public Task RejectContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user);
        public Task AcceptContribution(ContributionReviewDto reviewDto, Contribution contribution, AppUser user);
        public Task<ICollection<UserContributionListDto>> GetAllUserContribution(AppUser user);
        public Task<UserContributionViewDto> GetUserContributionById(AppUser user, int id);
    }
}

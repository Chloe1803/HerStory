using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Enums;

namespace HerStory.Server.Dtos.ContributionDto
{
    public class UserContributionViewDto
    {
        public int Id { get; set; }
        public PortraitDetailDto? Portrait { get; set; }
        public ICollection<ContributionDetailDto> Details { get; set; }
        public ContributionStatus Status { get; set; }
        public string? ReviewComment { get; set; }
    }
}

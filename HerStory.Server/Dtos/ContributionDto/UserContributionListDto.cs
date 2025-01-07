using HerStory.Server.Enums;

namespace HerStory.Server.Dtos.ContributionDto
{
    public class UserContributionListDto
    {
        public int ContributionId { get; set; }
        public int? PortraitId { get; set; }
        public string PortraitFirstName { get; set; }
        public string PortraitLastName { get; set; }
        public bool IsNewPortrait { get; set; }
        public ContributionStatus Status { get; set; }
    }
}

using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Enums;

namespace HerStory.Server.Dtos.ContributionDto
{
    public class ContributionViewDto
    {
        public int Id { get; set; }
        public PortraitDetailDto? Portrait { get; set; }
        public ShortUserInfoDto Contributor { get; set; }
        public ICollection<ContributionDetailDto> Details {get;set; }

    }

    public class ContributionDetailDto
    {
        public ContributionDetailFieldName FieldName { get; set; }
        public string NewValue { get; set; }

    }
}

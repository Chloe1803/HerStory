namespace HerStory.Server.Dtos.ContributionDto
{
    public class ContributionListDto
    {
        public int ContributionId { get; set; }
        public int? PortraitId { get; set; }
        public string PortraitFirstName { get; set; }
        public string PortraitLastName { get; set; }
        public bool IsNewPortrait { get; set; }
    }
}

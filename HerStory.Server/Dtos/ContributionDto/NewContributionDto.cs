namespace HerStory.Server.Dtos.ContributionDto
{
    public class NewContributionDto
    {
        public Dictionary<string, object> Changes { get; set; }
        public bool IsEdit { get; set; }
        public int? PortraitId { get; set; }
    }
}

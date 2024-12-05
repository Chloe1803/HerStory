using HerStory.Server.Enums;

namespace HerStory.Server.Models
{
    public class ContributionDetail
    {
        public int Id { get; set; }
        public int ContributionId { get; set; }
        public required Contribution Contribution { get; set; }
        public required ContributionDetailFieldName FieldName { get; set; }
        public required string NewValue { get; set; }
    }
}

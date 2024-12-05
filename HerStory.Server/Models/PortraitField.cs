namespace HerStory.Server.Models
{
    public class PortraitField
    {
        public required int PortraitId { get; set; }
        public Portrait Portrait { get; set; } = null!;
        public int FieldId { get; set; }
        public Field Field { get; set; } = null!;
    }
}

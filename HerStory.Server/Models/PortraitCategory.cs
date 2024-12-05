namespace HerStory.Server.Models
{
    public class PortraitCategory
    {
        public required int PortraitId { get; set; }
        public  Portrait Portrait { get; set; } = null!;
        public required int CategoryId { get; set; }
        public Category Category { get; set; } = null!;
    }
}

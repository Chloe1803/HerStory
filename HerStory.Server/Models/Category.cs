namespace HerStory.Server.Models
{
    public class Category
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public ICollection<PortraitCategory>? PortraitCategories { get; set; }
    }
}

namespace HerStory.Server.Models
{
    public class Field
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public ICollection<PortraitField>? PortraitFields { get; set; }
    }
}

﻿namespace HerStory.Server.Models
{
    public class Portrait
    {
        public int Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required int BirthYear { get; set; }
        public int DeathYear { get; set; }
        public required string BiographyAbstract { get; set; }
        public required string BiographyFull { get; set; }
        public string? PhotoUrl { get; set; }
        public required string CountryOfBirth { get; set; }
        public required DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public ICollection<PortraitCategory>? PortraitCategories { get; set; }
        public  ICollection<PortraitField>? PortraitFields { get; set; }
    }
}
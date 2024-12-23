using HerStory.Server.Models;
using System;

namespace HerStory.Server.Dtos
{
    public class PortraitListDto
    {
        public int Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required DateTime DateOfBirth{ get; set; }
        public DateTime DateOfDeath { get; set; }
        public required string BiographyAbstract { get; set; }
        public string? PhotoUrl { get; set; }
        public ICollection<Category>? Categories { get; set; }
        public ICollection<Field>? Fields { get; set; }
    }

    public class PortraitDetailDto
    {
        public int Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required DateTime DateOfBirth { get; set; }
        public DateTime DateOfDeath { get; set; }
        public required string BiographyAbstract { get; set; }
        public required string BiographyFull { get; set; }
        public string? PhotoUrl { get; set; }
        public required string CountryOfBirth { get; set; }
        public ICollection<Category>? Categories { get; set; }
        public ICollection<Field>? Fields { get; set; }
    }

    public class CategoryDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
    }

    public class FieldDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
    }
}

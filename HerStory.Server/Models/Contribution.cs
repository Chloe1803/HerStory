using HerStory.Server.Enums;
using System.ComponentModel.DataAnnotations;

namespace HerStory.Server.Models
{
    public class Contribution
    {
        public int Id { get; set; }
        public required int PortraitId { get; set; }
        public Portrait Portrait { get; set; }
        // Auteur de la contribution
        public required int ContributorId { get; set; }
        public  AppUser Contributor { get; set; }

        public ContributionStatus Status { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? ReviewedAt { get; set; }

        // Relecteur de la contribution (peut être null)
        public int? ReviewerId { get; set; }
        public AppUser? Reviewer { get; set; }
        public string? ReviewComment { get; set; }
        public required ICollection<ContributionDetail> Details { get; set; }

    }
}

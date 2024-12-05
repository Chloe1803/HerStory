using HerStory.Server.Enums;

namespace HerStory.Server.Models
{
    public class RoleChange
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public AppUser AppUser { get; set; } required
        public int RequestedRoleId { get; set; }
        public required Role RequestedRole { get; set; }
        public RoleChangeStatus Status { get; set; }
        public int? ProcessedByUserId { get; set; }
        public AppUser? ProcessedByUser { get; set; }
        public DateTime RequestedAt { get; set; }
        public DateTime? ProcessedAt { get; set; }
        public bool IsLastChange { get; set; }
    }
}

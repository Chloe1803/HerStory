using HerStory.Server.Enums;

namespace HerStory.Server.Models
{
    public class Notification
    {
        public int Id { get; set; }
        public required string Content { get; set; }
        public NotificationType Type { get; set; }
        public NotificationTargetEntityType TargetEntityType { get; set; }
        public int TargetEntityId { get; set; }
        public DateTime CreatedAt { get; set; }
        public int TriggeredByAppUserId { get; set; }
        public required AppUser TriggeredByAppUser { get; set; }

        public ICollection<AppUserNotification>? AppUsersNotified { get; set; }
    }
}

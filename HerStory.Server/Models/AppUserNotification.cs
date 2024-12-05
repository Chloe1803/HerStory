namespace HerStory.Server.Models
{
    public class AppUserNotification
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public required AppUser AppUser { get; set; }
        public int NotificationId { get; set; }
        public required Notification Notification { get; set; }
        public bool IsRead { get; set; }
        public DateTime ReadAt { get; set; }

    }
}

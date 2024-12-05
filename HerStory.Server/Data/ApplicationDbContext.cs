using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore;


namespace HerStory.Server.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        public DbSet<Portrait> Portrait { get; set; }
        public DbSet<Category> Category { get; set; }
        public DbSet<Field> Field { get; set; }
        public DbSet<PortraitCategory> PortraitCategory { get; set; }
        public DbSet<PortraitField> PortraitField { get; set; }
        public DbSet<AppUser> AppUser { get; set; }
        public DbSet<Role> Role { get; set; }
        public DbSet<RoleChange> RoleChange { get; set; }
        public DbSet<Notification> Notification { get; set; }
        public DbSet<AppUserNotification> AppUserNotification { get; set; }
        public DbSet<Contribution> Contribution { get; set; }
        public DbSet<ContributionDetail> ContributionDetail { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Relation Portrait-Categrory (Many-to-Many)
            modelBuilder.Entity<PortraitCategory>()
                .HasKey(pc => new { pc.PortraitId, pc.CategoryId });
            modelBuilder.Entity<PortraitCategory>()
                .HasOne(pc => pc.Portrait)
                .WithMany(p => p.PortraitCategories)
                .HasForeignKey(pc => pc.PortraitId);
            modelBuilder.Entity<PortraitCategory>()
                .HasOne(pc => pc.Category)
                .WithMany(c => c.PortraitCategories)
                .HasForeignKey(pc => pc.CategoryId);

            //Relation Portrait-Field (Many-to-Many)
            modelBuilder.Entity<PortraitField>()
                .HasKey(pf => new { pf.PortraitId, pf.FieldId });
            modelBuilder.Entity<PortraitField>()
                .HasOne(pf => pf.Portrait)
                .WithMany(p => p.PortraitFields)
                .HasForeignKey(pf => pf.PortraitId);
            modelBuilder.Entity<PortraitField>()
                .HasOne(pf => pf.Field)
                .WithMany(f => f.PortraitFields)
                .HasForeignKey(pf => pf.FieldId);

            // Relation AppUser → Role (Many-to-One)
            modelBuilder.Entity<AppUser>()
                .HasOne(user => user.Role)
                .WithMany() 
                .HasForeignKey(user => user.RoleId).OnDelete(DeleteBehavior.Restrict); 

            // Relation Role → AppUser (One-to-Many)
            modelBuilder.Entity<Role>()
                .HasMany(role => role.AppUsersWithRole)
                .WithOne(user => user.Role)
                .HasForeignKey(user => user.RoleId).OnDelete(DeleteBehavior.Restrict); 

            //Relation AppUser-RoleChange 
            modelBuilder.Entity<AppUser>()
                .HasOne(user => user.LastRoleChange)
                .WithMany()
                .HasForeignKey(rc => rc.LastRoleChangeId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<RoleChange>()
                .HasOne(rc => rc.AppUser)
                .WithMany()
                .HasForeignKey(rc => rc.AppUserId).OnDelete(DeleteBehavior.Restrict); 

            modelBuilder.Entity<RoleChange>()
                .HasOne(rc => rc.ProcessedByUser)
                .WithMany()
                .HasForeignKey(rc => rc.ProcessedByUserId).OnDelete(DeleteBehavior.Restrict); 

            //Relation Role-RoleChange
            modelBuilder.Entity<Role>()
                .HasMany(role => role.RoleChanges)
                .WithOne(rc => rc.RequestedRole)
                .HasForeignKey(rc => rc.RequestedRoleId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<RoleChange>()
                .HasOne(rc => rc.RequestedRole)
                .WithMany(role => role.RoleChanges)
                .HasForeignKey(rc => rc.RequestedRoleId).OnDelete(DeleteBehavior.Restrict);


            //Relation AppUser-Notification
            modelBuilder.Entity<AppUserNotification>()
                .HasKey(aun => new { aun.AppUserId, aun.NotificationId });
            modelBuilder.Entity<AppUserNotification>()
                .HasOne(aun => aun.AppUser)
                .WithMany(user => user.Notifications)
                .HasForeignKey(aun => aun.AppUserId).OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<AppUserNotification>()
                .HasOne(aun => aun.Notification)
                .WithMany(n => n.AppUsersNotified)
                .HasForeignKey(aun => aun.NotificationId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<AppUser>()
                .HasMany(user => user.Notifications)
                .WithOne(n => n.AppUser)
                .HasForeignKey(n => n.AppUserId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Notification>()
                .HasOne(n => n.TriggeredByAppUser)
                .WithMany()
                .HasForeignKey(n => n.TriggeredByAppUserId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Notification>()
                .HasMany(n => n.AppUsersNotified)
                .WithOne(aun => aun.Notification)
                .HasForeignKey(aun => aun.NotificationId).OnDelete(DeleteBehavior.Restrict);


            //Relation AppUser-Contribution

            modelBuilder.Entity<Contribution>()
                .HasOne(c => c.Contributor)
                .WithMany(user => user.Contributions)
                .HasForeignKey(c => c.ContributorId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Contribution>()
                .HasOne(c => c.Reviewer)
                .WithMany(user => user.Reviews)
                .HasForeignKey(c => c.ReviewerId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<AppUser>()
                .HasMany(user => user.Contributions)
                .WithOne(c => c.Contributor)
                .HasForeignKey(c => c.ContributorId).OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<AppUser>()
                .HasMany(user => user.Reviews)
                .WithOne(c => c.Reviewer)
                .HasForeignKey(c => c.ReviewerId).OnDelete(DeleteBehavior.Restrict);
        }

    }
}

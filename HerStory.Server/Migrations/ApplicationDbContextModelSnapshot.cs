﻿// <auto-generated />
using System;
using HerStory.Server.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace HerStory.Server.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    partial class ApplicationDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("HerStory.Server.Models.AppUser", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("AboutMe")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("HashedPassword")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("LastRoleChangeId")
                        .HasColumnType("int");

                    b.Property<int>("RoleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("LastRoleChangeId");

                    b.HasIndex("RoleId");

                    b.ToTable("AppUser");
                });

            modelBuilder.Entity("HerStory.Server.Models.AppUserNotification", b =>
                {
                    b.Property<int>("AppUserId")
                        .HasColumnType("int");

                    b.Property<int>("NotificationId")
                        .HasColumnType("int");

                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<bool>("IsRead")
                        .HasColumnType("bit");

                    b.Property<DateTime>("ReadAt")
                        .HasColumnType("datetime2");

                    b.HasKey("AppUserId", "NotificationId");

                    b.HasIndex("NotificationId");

                    b.ToTable("AppUserNotification");
                });

            modelBuilder.Entity("HerStory.Server.Models.Category", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Category");
                });

            modelBuilder.Entity("HerStory.Server.Models.Contribution", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("ContributorId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("PortraitId")
                        .HasColumnType("int");

                    b.Property<string>("ReviewComment")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("ReviewedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("ReviewerId")
                        .HasColumnType("int");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ContributorId");

                    b.HasIndex("PortraitId");

                    b.HasIndex("ReviewerId");

                    b.ToTable("Contribution");
                });

            modelBuilder.Entity("HerStory.Server.Models.ContributionDetail", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("ContributionId")
                        .HasColumnType("int");

                    b.Property<string>("FieldName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("NewValue")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ContributionId");

                    b.ToTable("ContributionDetail");
                });

            modelBuilder.Entity("HerStory.Server.Models.Field", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Field");
                });

            modelBuilder.Entity("HerStory.Server.Models.Notification", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("TargetEntityId")
                        .HasColumnType("int");

                    b.Property<int>("TargetEntityType")
                        .HasColumnType("int");

                    b.Property<int>("TriggeredByAppUserId")
                        .HasColumnType("int");

                    b.Property<int>("Type")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("TriggeredByAppUserId");

                    b.ToTable("Notification");
                });

            modelBuilder.Entity("HerStory.Server.Models.Portrait", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("BiographyAbstract")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("BiographyFull")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CountryOfBirth")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("DateOfBirth")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DateOfDeath")
                        .HasColumnType("datetime2");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhotoUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("UpdatedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("Portrait");
                });

            modelBuilder.Entity("HerStory.Server.Models.PortraitCategory", b =>
                {
                    b.Property<int>("PortraitId")
                        .HasColumnType("int");

                    b.Property<int>("CategoryId")
                        .HasColumnType("int");

                    b.HasKey("PortraitId", "CategoryId");

                    b.HasIndex("CategoryId");

                    b.ToTable("PortraitCategory");
                });

            modelBuilder.Entity("HerStory.Server.Models.PortraitField", b =>
                {
                    b.Property<int>("PortraitId")
                        .HasColumnType("int");

                    b.Property<int>("FieldId")
                        .HasColumnType("int");

                    b.HasKey("PortraitId", "FieldId");

                    b.HasIndex("FieldId");

                    b.ToTable("PortraitField");
                });

            modelBuilder.Entity("HerStory.Server.Models.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Role");
                });

            modelBuilder.Entity("HerStory.Server.Models.RoleChange", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("AppUserId")
                        .HasColumnType("int");

                    b.Property<bool>("IsLastChange")
                        .HasColumnType("bit");

                    b.Property<DateTime?>("ProcessedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("ProcessedByUserId")
                        .HasColumnType("int");

                    b.Property<DateTime>("RequestedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("RequestedRoleId")
                        .HasColumnType("int");

                    b.Property<int>("Status")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("AppUserId");

                    b.HasIndex("ProcessedByUserId");

                    b.HasIndex("RequestedRoleId");

                    b.ToTable("RoleChange");
                });

            modelBuilder.Entity("HerStory.Server.Models.AppUser", b =>
                {
                    b.HasOne("HerStory.Server.Models.RoleChange", "LastRoleChange")
                        .WithMany()
                        .HasForeignKey("LastRoleChangeId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("HerStory.Server.Models.Role", "Role")
                        .WithMany("AppUsersWithRole")
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("LastRoleChange");

                    b.Navigation("Role");
                });

            modelBuilder.Entity("HerStory.Server.Models.AppUserNotification", b =>
                {
                    b.HasOne("HerStory.Server.Models.AppUser", "AppUser")
                        .WithMany("Notifications")
                        .HasForeignKey("AppUserId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("HerStory.Server.Models.Notification", "Notification")
                        .WithMany("AppUsersNotified")
                        .HasForeignKey("NotificationId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("AppUser");

                    b.Navigation("Notification");
                });

            modelBuilder.Entity("HerStory.Server.Models.Contribution", b =>
                {
                    b.HasOne("HerStory.Server.Models.AppUser", "Contributor")
                        .WithMany("Contributions")
                        .HasForeignKey("ContributorId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("HerStory.Server.Models.Portrait", "Portrait")
                        .WithMany()
                        .HasForeignKey("PortraitId");

                    b.HasOne("HerStory.Server.Models.AppUser", "Reviewer")
                        .WithMany("Reviews")
                        .HasForeignKey("ReviewerId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.Navigation("Contributor");

                    b.Navigation("Portrait");

                    b.Navigation("Reviewer");
                });

            modelBuilder.Entity("HerStory.Server.Models.ContributionDetail", b =>
                {
                    b.HasOne("HerStory.Server.Models.Contribution", "Contribution")
                        .WithMany("Details")
                        .HasForeignKey("ContributionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Contribution");
                });

            modelBuilder.Entity("HerStory.Server.Models.Notification", b =>
                {
                    b.HasOne("HerStory.Server.Models.AppUser", "TriggeredByAppUser")
                        .WithMany()
                        .HasForeignKey("TriggeredByAppUserId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("TriggeredByAppUser");
                });

            modelBuilder.Entity("HerStory.Server.Models.PortraitCategory", b =>
                {
                    b.HasOne("HerStory.Server.Models.Category", "Category")
                        .WithMany("PortraitCategories")
                        .HasForeignKey("CategoryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("HerStory.Server.Models.Portrait", "Portrait")
                        .WithMany("PortraitCategories")
                        .HasForeignKey("PortraitId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Category");

                    b.Navigation("Portrait");
                });

            modelBuilder.Entity("HerStory.Server.Models.PortraitField", b =>
                {
                    b.HasOne("HerStory.Server.Models.Field", "Field")
                        .WithMany("PortraitFields")
                        .HasForeignKey("FieldId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("HerStory.Server.Models.Portrait", "Portrait")
                        .WithMany("PortraitFields")
                        .HasForeignKey("PortraitId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Field");

                    b.Navigation("Portrait");
                });

            modelBuilder.Entity("HerStory.Server.Models.RoleChange", b =>
                {
                    b.HasOne("HerStory.Server.Models.AppUser", "AppUser")
                        .WithMany()
                        .HasForeignKey("AppUserId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("HerStory.Server.Models.AppUser", "ProcessedByUser")
                        .WithMany()
                        .HasForeignKey("ProcessedByUserId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("HerStory.Server.Models.Role", "RequestedRole")
                        .WithMany("RoleChanges")
                        .HasForeignKey("RequestedRoleId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("AppUser");

                    b.Navigation("ProcessedByUser");

                    b.Navigation("RequestedRole");
                });

            modelBuilder.Entity("HerStory.Server.Models.AppUser", b =>
                {
                    b.Navigation("Contributions");

                    b.Navigation("Notifications");

                    b.Navigation("Reviews");
                });

            modelBuilder.Entity("HerStory.Server.Models.Category", b =>
                {
                    b.Navigation("PortraitCategories");
                });

            modelBuilder.Entity("HerStory.Server.Models.Contribution", b =>
                {
                    b.Navigation("Details");
                });

            modelBuilder.Entity("HerStory.Server.Models.Field", b =>
                {
                    b.Navigation("PortraitFields");
                });

            modelBuilder.Entity("HerStory.Server.Models.Notification", b =>
                {
                    b.Navigation("AppUsersNotified");
                });

            modelBuilder.Entity("HerStory.Server.Models.Portrait", b =>
                {
                    b.Navigation("PortraitCategories");

                    b.Navigation("PortraitFields");
                });

            modelBuilder.Entity("HerStory.Server.Models.Role", b =>
                {
                    b.Navigation("AppUsersWithRole");

                    b.Navigation("RoleChanges");
                });
#pragma warning restore 612, 618
        }
    }
}

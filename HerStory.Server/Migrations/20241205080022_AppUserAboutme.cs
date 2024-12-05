using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HerStory.Server.Migrations
{
    /// <inheritdoc />
    public partial class AppUserAboutme : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "AboutMe",
                table: "AppUser",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AboutMe",
                table: "AppUser");
        }
    }
}

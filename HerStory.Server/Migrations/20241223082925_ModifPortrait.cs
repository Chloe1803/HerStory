using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HerStory.Server.Migrations
{
    /// <inheritdoc />
    public partial class ModifPortrait : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "BirthYear",
                table: "Portrait");

            migrationBuilder.DropColumn(
                name: "DeathYear",
                table: "Portrait");

            migrationBuilder.AddColumn<DateTime>(
                name: "DateOfBirth",
                table: "Portrait",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "DateOfDeath",
                table: "Portrait",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "ReviewComment",
                table: "Contribution",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DateOfBirth",
                table: "Portrait");

            migrationBuilder.DropColumn(
                name: "DateOfDeath",
                table: "Portrait");

            migrationBuilder.DropColumn(
                name: "ReviewComment",
                table: "Contribution");

            migrationBuilder.AddColumn<int>(
                name: "BirthYear",
                table: "Portrait",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "DeathYear",
                table: "Portrait",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}

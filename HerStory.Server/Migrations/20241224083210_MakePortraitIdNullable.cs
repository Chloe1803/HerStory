using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HerStory.Server.Migrations
{
    /// <inheritdoc />
    public partial class MakePortraitIdNullable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Contribution_Portrait_PortraitId",
                table: "Contribution");

            migrationBuilder.AlterColumn<int>(
                name: "PortraitId",
                table: "Contribution",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Contribution_Portrait_PortraitId",
                table: "Contribution",
                column: "PortraitId",
                principalTable: "Portrait",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Contribution_Portrait_PortraitId",
                table: "Contribution");

            migrationBuilder.AlterColumn<int>(
                name: "PortraitId",
                table: "Contribution",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Contribution_Portrait_PortraitId",
                table: "Contribution",
                column: "PortraitId",
                principalTable: "Portrait",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

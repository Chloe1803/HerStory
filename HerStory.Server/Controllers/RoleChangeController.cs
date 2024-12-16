using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RoleChangeController : Controller
    {
        private readonly IRoleChangeService _roleChangeService;
        private readonly IUserService _userService;
        public RoleChangeController(IRoleChangeService roleChangeService, IUserService userService)
        {
            _roleChangeService = roleChangeService;
            _userService = userService;
        }

        [HttpGet("pending")]
        [Authorize(Roles = "Admin, Reviewer, SuperAdmin")]
        [ProducesResponseType(200, Type = typeof(ICollection<RoleChangeListDto>))]
        public async Task<IActionResult> GetPendingRoleChanges()
        {
            var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
            if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized("User ID not found in token.");
            }

            var user = await _userService.GetUserById(userId);
            if (user == null) {
                return NotFound("User not found.");
            }

            var pendingRoleChanges = await _roleChangeService.GetAllPendingRoleChanges(user);

            if (pendingRoleChanges == null)
            {
                return NotFound("No pending role changes found.");
            }

            return Ok(pendingRoleChanges);
        }

    }
}

using HerStory.Server.Constants;
using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Enums;
using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

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
            try
            {
                var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
                if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
                {
                    return Unauthorized("User ID not found in token.");
                }

                var user = await _userService.GetUserById(userId);
                if (user == null)
                {
                    return NotFound("User not found.");
                }

                var pendingRoleChanges = await _roleChangeService.GetAllPendingRoleChanges(user);

                if (pendingRoleChanges == null)
                {
                    return NotFound("No pending role changes found.");
                }

                return Ok(pendingRoleChanges);
            }
            catch 
            {
                throw;
            }
        }

        [HttpPost("{id}/response")]
        [Authorize(Roles = "Admin, Reviewer, SuperAdmin")]
        [ProducesResponseType(200)]
        public async Task<IActionResult> RespondToRoleChange(int id, [FromBody] RoleChangeResponseDto response)
        {
            try
            {
                var roleChange = await _roleChangeService.GetRoleChangeById(id);
                if (roleChange == null)
                {
                    return NotFound("Role change not found.");
                }

                if (roleChange.Status != RoleChangeStatus.Pending)
                {
                    return BadRequest("Role change is not pending.");
                }

                var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
                if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
                {
                    return Unauthorized("User ID not found in token.");
                }

                var respondingUser = await _userService.GetUserById(userId);
                if (respondingUser == null)
                {
                    return NotFound("User not found.");
                }

                if (!RoleConstants.RoleHierarchy.HasAccess(respondingUser.Role.Name, roleChange.RequestedRole.Name))
                {
                    return Unauthorized("User does not have permission to respond to role changes.");
                }

                if (response.Action == "accept")
                {
                    var result = await _roleChangeService.AcceptRoleChange(respondingUser, roleChange);
                    if (!result)
                    {
                        return BadRequest("Role change could not be accepted.");
                    }
                }
                else if (response.Action == "reject")
                {
                    var result = await _roleChangeService.RejectRoleChange(respondingUser, roleChange);
                    if (!result)
                    {
                        return BadRequest("Role change could not be rejected.");
                    }

                }
                else
                {
                    return BadRequest("Invalid action.");
                }

                return Ok();
            }
            catch 
            {
                throw;
            }
           
        }

        [HttpPost("request-next")]
        [Authorize(Roles = "Visitor, Contributor, Reviewer, Admin")]
        [ProducesResponseType(200)]
        public async Task<IActionResult> RequestNextRole()
        {
            try
            {
                var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
                if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
                {
                    return Unauthorized("User ID not found in token.");
                }

                var user = await _userService.GetUserById(userId);
                if (user == null)
                {
                    return NotFound("User not found.");
                }

                if (user == null)
                {
                    return NotFound("User not found.");
                }

                var nextRole = RoleConstants.RoleHierarchy.GetNextRole(user.Role.Name);

                if (nextRole == null)
                {
                    return BadRequest("User is already at the highest role.");
                }

                var nextRoleId = RoleConstants.RoleIds[nextRole.Value];
                var changeRoleRequest = await _roleChangeService.RequestRoleChange(user, nextRoleId);
                return Ok();
            }
            catch
            {
                throw;
            }

           
        }
    }
}

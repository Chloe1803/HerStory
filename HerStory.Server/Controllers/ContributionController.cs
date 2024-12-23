using HerStory.Server.Dtos;
using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContributionController : Controller
    {
        private readonly IContributionService _contributionService;
        private readonly IUserService _userService;

        public ContributionController(IContributionService contributionService, IUserService userService)
        {
            _contributionService = contributionService;
            _userService = userService;
        }

        [HttpPost]
        [Authorize(Roles = "Contributor, Admin, Reviewer, SuperAdmin")]
        [ProducesResponseType(200)]
        public async Task<IActionResult> CreateContribution([FromBody] NewContributionDto contributionDto)
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

            var contribution = await _contributionService.CreateContribution(contributionDto, user);

            if (contribution == null)
            {
                return BadRequest("Failed to create contribution.");
            }

            return Ok();
        }


    }
}

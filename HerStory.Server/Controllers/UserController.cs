﻿using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Mvc;
using HerStory.Server.Dtos.UserDto;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : Controller
    {
        private readonly IUserService _userService;
        public UserController(IUserService userService)
        {
            _userService = userService;
        }
  

        [HttpGet("profile")]
        [Authorize(Roles = "Visitor, Contributor, Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(200, Type = typeof(ProfileDto))]
        public async Task<IActionResult> GetProfile()
        {
            try
            {
                var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

                if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
                {
                    return Unauthorized("User ID not found in token.");
                }

                var profile = await _userService.GetProfileAsync(userId);

                if (profile == null)
                {
                    return NotFound("User not found.");
                }

                return Ok(profile);
            }
            catch
            {
                throw;
            }
           
        }

        [HttpGet("otherProfile/{otherUserId}")]
        [Authorize(Roles = " Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(200, Type = typeof(ProfileDto))]
        public async Task<IActionResult> GetOtherUserProfile(int otherUserId)
        {
            try
            {
                var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

                if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
                {
                    return Unauthorized("User ID not found in token.");
                }

                var profile = await _userService.GetProfileAsync(otherUserId);

                if (profile == null)
                {
                    return NotFound("User not found.");
                }

                return Ok(profile);
            }
            catch
            {
                throw;
            }

        }
    }
}

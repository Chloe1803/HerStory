﻿using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using HerStory.Server.Dtos.ContributionDto;
using System.Data;
using HerStory.Server.Models;
using System.Text.Json;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContributionController : Controller
    {
        private readonly IContributionService _contributionService;
        private readonly IUserService _userService;
    

        public ContributionController(IContributionService contributionService, IUserService userService )
        {
            _contributionService = contributionService;
            _userService = userService;
  
        }

        [HttpGet("{contributionId}")]
        [Authorize(Roles = "Contributor, Admin, Reviewer, SuperAdmin")]
        [ProducesResponseType(200, Type =typeof(ContributionViewDto))]
        public async Task<IActionResult> GetContributionById(int contributionId)
        {
            var userIdClaim = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
            if (userIdClaim == null || !int.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized("User ID not found in token.");
            }

            var contribution = await _contributionService.GetContributionViewDtoById(contributionId);

            if (contribution == null)
                return NotFound("Contribution not found");

            return Ok(contribution);
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

            Console.WriteLine(System.Text.Json.JsonSerializer.Serialize(contributionDto));
            var contribution = await _contributionService.CreateContribution(contributionDto, user);

            if (contribution == null)
            {
                return BadRequest("Failed to create contribution.");
            }

            return Ok();
        }

        [HttpGet("pending")]
        [Authorize(Roles = "Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(200, Type=typeof(ICollection<ContributionListDto>))]
        public async Task<IActionResult> GetPendingContributionNotAssigned()
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

            var contributions = await _contributionService.GetPendingContributionsNotAssigned(user);

            if (contributions == null)
                return NotFound("No pending contributions not assigned");

            return Ok(contributions);
        }

        [HttpGet("pendingAssigned")]
        [Authorize(Roles = "Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(200, Type = typeof(ICollection<ContributionListDto>))]
        public async Task<IActionResult> GetPendingContributionAssignedToUser()
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

            var contributions = await _contributionService.GetPendingContributionsAssignedToUser(user);

            if (contributions == null)
                return NotFound("No pending contributions assigned to user");

            return Ok(contributions);
        }

        [HttpPost("{contributionId}/reviewer")]
        [Authorize(Roles = "Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(204)]
        public async Task<IActionResult> AssignSelfToContribution(int contributionId)
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

            var contribution = await _contributionService.GetContributionById(contributionId);
            if (contribution == null)
                return NotFound("Contribution not found.");

            if (contribution.ReviewerId != null)
                return BadRequest("Contribution already assigned to a user");

            if (contribution.ContributorId == user.Id)
                return BadRequest("User can not review own contibution");

            var isAssigned = contribution.ReviewerId == user.Id;

            if (isAssigned)
                return BadRequest("User already assigned");

            try
            {
                await _contributionService.ChangeReviewerAssignment(isAssigned, contribution, user);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occured during reviewer assignent:", ex);
                throw ex;
            }

            return Ok();
        }

        [HttpDelete("{contributionId}/reviewer")]
        [Authorize(Roles = "Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(204)]
        public async Task<IActionResult> UnassignSelfFromContribution(int contributionId)
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

            var contribution = await _contributionService.GetContributionById(contributionId);
            if (contribution == null)
                return NotFound("Contribution not found.");

            if (contribution.ReviewerId == null)
                return BadRequest("Contribution has no assigned user");

            var isAssigned = contribution.ReviewerId == user.Id;

            if (!isAssigned)
                return BadRequest("User is not assigned to contribution");

            try
            {
                await _contributionService.ChangeReviewerAssignment(isAssigned, contribution, user);
            }
             catch (Exception ex)
            {
                Console.WriteLine("An error occured during reviewer assignent:", ex);
                throw ex;
            }          

            return Ok();

        }

        //[HttpPost("{contributionId}/reviewer/{userId}")]
        //[Authorize(Roles = " Admin, SuperAdmin")]
        //public async Task<IActionResult> AssignUserToContribution(int contributionId, int userId)
        //{

        //}

        //[HttpDelete("{contributionId}/reviewer/{userId}")]
        //[Authorize(Roles = " Admin, SuperAdmin")]
        //public async Task<IActionResult> UnassignUserFromContribution(int contributionId, int userId)
        //{ }


        [HttpPut("review")]
        [Authorize(Roles = "Reviewer, Admin, SuperAdmin")]
        [ProducesResponseType(204)]
        public async Task<IActionResult> handleContributionReview([FromBody] ContributionReviewDto reviewDto)
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

            if (reviewDto == null)
                return NotFound("Review not found");
            Console.WriteLine("ReviewDto content: " + JsonSerializer.Serialize(reviewDto));


            var contribution = await _contributionService.GetContributionById(reviewDto.ContributionId);
            if (contribution == null)
                return NotFound("Contribution not found.");

            if (contribution.ReviewerId != user.Id)
                return BadRequest("this user is not the assigned reviewer");

            
            if (reviewDto.IsAccepted == false)
            {
                Console.WriteLine("rejecting");
                try
                {
                   
                    await _contributionService.RejectContribution(reviewDto, contribution, user);
                    return Ok();
                }
              
                     catch (Exception ex)
                {
                    Console.WriteLine("An error occured during rejection :", ex);
                
                    throw ex;
                }
            }else
            {
                Console.WriteLine("accepting");
                try
                {
                    await _contributionService.AcceptContribution(reviewDto, contribution, user);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occured during approval :", ex);
                    throw ex;
                }
            }

            return Ok();

        }


    }
}

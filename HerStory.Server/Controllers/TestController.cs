using Microsoft.AspNetCore.Mvc;
using System;
using HerStory.Server.Exceptions;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {
        // Simule une erreur 400 (Bad Request)
        [HttpGet("bad-request")]
        public IActionResult GetBadRequest()
        {
            throw new BadRequestException("This is a simulated bad request error.");
        }

        // Simule une erreur 401 (Unauthorized)
        [HttpGet("unauthorized")]
        public IActionResult GetUnauthorized()
        {
            throw new UnauthorizedException("This is a simulated unauthorized error.");
        }

        // Simule une erreur 409 (Conflict)
        [HttpGet("conflict")]
        public IActionResult GetConflict()
        {
            throw new ConflictException("This is a simulated conflict error.");
        }

        // Simule une erreur 500 (Internal Server Error)
        [HttpGet("internal-error")]
        public IActionResult GetInternalError()
        {
            throw new Exception("This is a simulated internal server error.");
        }

        // Simule une requête valide
        [HttpGet("success")]
        public IActionResult GetSuccess()
        {
            return Ok(new { message = "This is a successful response." });
        }
    }
}

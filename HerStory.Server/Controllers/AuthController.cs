using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Exceptions;
using HerStory.Server.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HerStory.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly JwtTokenService _jwtTokenService;
        private readonly IUserService _userService;
        private readonly ILogger<AuthController> _logger;


        public AuthController(JwtTokenService jwtTokenService, IUserService userService, ILogger<AuthController> logger)
        {
            _jwtTokenService = jwtTokenService;
        _userService = userService;
            _logger = logger;
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            try
            {
                _logger.LogInformation("Login attempt for email: {Email}", loginDto?.Email);

                if (loginDto == null || string.IsNullOrEmpty(loginDto.Email) || string.IsNullOrEmpty(loginDto.Password))
                {
                    _logger.LogWarning("Invalid login request: missing email or password.");

                    throw new BadRequestException("Email et mot de passe sont requis");
                }

                var authResult = await _userService.AuthenticateAsync(loginDto.Email, loginDto.Password);

                if (!authResult.IsSuccess)
                {

                    if (authResult.ErrorMessage == "User not found.")
                        return NotFound(new { message = "Adresse email inconnue" });

                    if (authResult.ErrorMessage == "Invalid password.")
                        return Unauthorized(new { message = "Mot de passe incorrect" });

                    return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred.");
                }

                var token = _jwtTokenService.GenerateToken(authResult.User!.Id.ToString(), authResult.User.Role.Name.ToString());

                return Ok(new { token });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred during login.");
                throw;
            }
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                _logger.LogInformation("Register attempt for email: {Email}", registerDto?.Email);

                if (registerDto == null || string.IsNullOrEmpty(registerDto.Email) || string.IsNullOrEmpty(registerDto.Password))
                {
                    _logger.LogWarning("Invalid register request: missing email or password.");

                    throw new BadRequestException("Email and password are required.");
                }

                var authResult = await _userService.RegisterAsync(registerDto);

                if (!authResult.IsSuccess)
                {
                    if (authResult.ErrorMessage == "Email already exists.")
                        return Conflict(new { message = "L'email est déjà utilisé" });

                    return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred.");
                }

                var token = _jwtTokenService.GenerateToken(authResult.User!.Id.ToString(), authResult.User.Role.Name.ToString());

                return Ok(new { token });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred during register.");
                throw ;
            }
        }
    }
}

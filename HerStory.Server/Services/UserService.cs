using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;

namespace HerStory.Server.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly ILogger<UserService> _logger;
        private readonly IRoleChangeService _roleChangeService;
        public UserService(IUserRepository userRepository, ILogger<UserService> logger, IRoleChangeService roleChangeService)
        {
            _userRepository = userRepository;
            _logger = logger;
            _roleChangeService = roleChangeService;
        }
        public async Task<AuthenticationResult> AuthenticateAsync(string email, string password)
        {
            var user = await _userRepository.GetUserByEmailAsync(email);

            if (user == null)
            {
                return new AuthenticationResult
                {
                    IsSuccess = false,
                    ErrorMessage = "User not found."
                };
            }

            var isPasswordValid = BCrypt.Net.BCrypt.Verify(password, user.HashedPassword);
            if (!isPasswordValid)
            {
                return new AuthenticationResult
                {
                    IsSuccess = false,
                    ErrorMessage = "Invalid password."
                };
            }

            return new AuthenticationResult
            {
                IsSuccess = true,
                User = user
            };
        }

        public async Task<AuthenticationResult> RegisterAsync(RegisterDto user)
        {
            var isEmailUsed = await _userRepository.UserEmailExists(user.Email);
            if (isEmailUsed)
            {
                return new AuthenticationResult
                {
                    IsSuccess = false,
                    ErrorMessage = "Email already exists."
                };
            }

            var newUser = new AppUser
            {
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                HashedPassword = BCrypt.Net.BCrypt.HashPassword(user.Password),
                RoleId = 8, // RoleId 8 pour les "visiteurs" en attente de validation -> constante à définir
                AboutMe = user.AboutMe,
                CreatedAt = DateTime.Now,
            };

            try
            {
                var addedUser = await _userRepository.CreateUser(newUser);
                var changeRoleRequest = await _roleChangeService.RequestRoleChange(addedUser, 4); //Constante pour les roles à implémenter
                _logger.LogInformation("User created: {Role}", addedUser.Role.Name);
                return new AuthenticationResult
                {
                    IsSuccess = true,
                    User = addedUser
                };
            }
            catch
            {
                return new AuthenticationResult
                {
                    IsSuccess = false,
                    ErrorMessage = "An error occured while creating the user."
                };
            }
        }
    }
}

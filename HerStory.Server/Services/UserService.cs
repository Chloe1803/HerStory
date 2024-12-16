using AutoMapper;
using HerStory.Server.Constants;
using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Enums;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;

namespace HerStory.Server.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly ILogger<UserService> _logger;
        private readonly IRoleChangeService _roleChangeService;
        private readonly IMapper _mapper;
        public UserService(IUserRepository userRepository, ILogger<UserService> logger, IRoleChangeService roleChangeService, IMapper mapper)
        {
            _userRepository = userRepository;
            _logger = logger;
            _roleChangeService = roleChangeService;
            _mapper = mapper;
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
                RoleId = RoleConstants.RoleIds[RoleName.Visitor],
                AboutMe = user.AboutMe,
                CreatedAt = DateTime.Now,
            };

            try
            {
                var addedUser = await _userRepository.CreateUser(newUser);
                var changeRoleRequest = await _roleChangeService.RequestRoleChange(addedUser, RoleConstants.RoleIds[RoleName.Contributor]); 
                return new AuthenticationResult
                {
                    IsSuccess = true,
                    User = addedUser
                };
            }
            catch (Exception ex)
            {
                _logger.LogError("An error occured while creating the user : ", ex.Message);
                return new AuthenticationResult
                {
                    IsSuccess = false,
                    ErrorMessage = "An error occured while creating the user."
                };
            }
        }

        public async Task<ProfileDto> GetProfileAsync(int id)
        {
            var user = await _userRepository.GetUserProfileByIdAsync(id);
            if (user == null)
            {
                return null;
            }

            var profile = _mapper.Map<ProfileDto>(user);

            return profile;
        }

        public async Task<AppUser> GetUserById(int id)
        {
            return await _userRepository.GetUserByIdAsync(id);
        }
    }
}

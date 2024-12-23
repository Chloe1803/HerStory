using HerStory.Server.Hubs;
using HerStory.Server.Interfaces;
using HerStory.Server.Repositories;
using HerStory.Server.Services;

namespace HerStory.Server.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<IPortraitRepository, PortraitRepository>();
            services.AddScoped<IPortraitService, PortraitService>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IRoleChangeRepository, RoleChangeRepository>();
            services.AddScoped<IRoleChangeService, RoleChangeService>();
            services.AddScoped<JwtTokenService>();
            services.AddScoped<NotificationHub>();
            services.AddScoped<IContributionRepository, ContributionRepository>();
            services.AddScoped<IContributionService, ContributionService>();

            return services;
        }
    }
}

using HerStory.Server.Interfaces;
using HerStory.Server.Repository;
using HerStory.Server.Services;

namespace HerStory.Server.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<IPortraitRepository, PortraitRepository>();
            services.AddScoped<IPortraitService, PortraitService>();
            return services;
        }
    }
}

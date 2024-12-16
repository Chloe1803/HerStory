using AutoMapper;
using HerStory.Server.Dtos;
using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Models;

namespace HerStory.Server.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles() {
            CreateMap<Portrait, PortraitListDto>()
                .ForMember(dest => dest.Categories, opt => opt.MapFrom(src => src.PortraitCategories.Select(pc => pc.Category)))
                .ForMember(dest => dest.Fields, opt => opt.MapFrom(src => src.PortraitFields.Select(pf => pf.Field)));
            
            CreateMap<Portrait, PortraitDetailDto>()
                .ForMember(dest => dest.Categories, opt => opt.MapFrom(src => src.PortraitCategories.Select(pc => pc.Category)))
                .ForMember(dest => dest.Fields, opt => opt.MapFrom(src => src.PortraitFields.Select(pf => pf.Field)));

            CreateMap<AppUser, ProfileDto>()
                .ForMember(dest => dest.numberOfContributions, o => o.MapFrom(src => src.Contributions.Count))
                .ForMember(dest => dest.numberOfReviews, o => o.MapFrom(src => src.Reviews.Count))
                .ForMember(dest => dest.Role, opt => opt.MapFrom(src => src.Role))  
                .ForMember(dest => dest.LastRoleChange, opt => opt.MapFrom(src => src.LastRoleChange));

            CreateMap<Role, RoleDto>();

            CreateMap<RoleChange, RoleChangeProfileDto>()
                .ForMember(dest => dest.Status, opt => opt.MapFrom(src => src.Status.ToString()))
                .ForMember(dest => dest.RequestedRole, opt => opt.MapFrom(src=> src.RequestedRole));

            CreateMap<RoleChange, RoleChangeListDto>()
                .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.AppUserId))
                .ForMember(dest => dest.UserFirstName, opt => opt.MapFrom(src => src.AppUser.FirstName))
                .ForMember(dest => dest.UserLastName, opt => opt.MapFrom(src => src.AppUser.LastName))
                .ForMember(dest => dest.RequestedRole, opt => opt.MapFrom(src => src.RequestedRole));

        }
    }
}

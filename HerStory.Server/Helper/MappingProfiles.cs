using AutoMapper;
using HerStory.Server.Dtos;
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
                .ForMember(dest => dest.numberOfReviews, o => o.MapFrom(src => src.Reviews.Count));


        }
    }
}

using AutoMapper;
using HerStory.Server.Dtos;
using HerStory.Server.Dtos.ContributionDto;
using HerStory.Server.Dtos.RoleChangeDto;
using HerStory.Server.Dtos.UserDto;
using HerStory.Server.Models;

namespace HerStory.Server.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles() {

            CreateMap<Category, CategoryDto>();
            CreateMap<Field, FieldDto>();

            CreateMap<Portrait, PortraitListDto>()
                .ForMember(dest => dest.Categories, opt => opt.MapFrom(src => src.PortraitCategories.Select(pc => new CategoryDto
                {
                    Id = pc.Category.Id,
                    Name = pc.Category.Name
                })))
                .ForMember(dest => dest.Fields, opt => opt.MapFrom(src => src.PortraitFields.Select(pf => new FieldDto
                 {
                    Id = pf.Field.Id,
                    Name = pf.Field.Name
                 })));

            CreateMap<Portrait, PortraitDetailDto>()
                .ForMember(dest => dest.Categories, opt => opt.MapFrom(src => src.PortraitCategories.Select(pc => new CategoryDto
                {
                    Id = pc.Category.Id,
                    Name = pc.Category.Name
                })))
                .ForMember(dest => dest.Fields, opt => opt.MapFrom(src => src.PortraitFields.Select(pf => new FieldDto
                {
                    Id = pf.Field.Id,
                    Name = pf.Field.Name
                })))
                .ForMember(dest => dest.DateOfDeath, opt => opt.MapFrom(src => src.DateOfDeath != DateTime.MinValue ? src.DateOfDeath : (DateTime?)null));


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

            CreateMap<Category, CategoryDto>();
            CreateMap<Field, FieldDto>();

            CreateMap<Contribution, ContributionListDto>()
                .ForMember(dest => dest.ContributionId, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.IsNewPortrait, opt => opt.MapFrom(src => src.PortraitId == null))
                .ForMember(dest => dest.PortraitId, opt => opt.MapFrom(src => src.PortraitId))
               //Si c'est un nouveau portrait il faut mapp a partir des détails de la contribution, si non c'est à partir du portrait
               .ForMember(dest => dest.PortraitFirstName, opt => opt.MapFrom(src =>
                    src.PortraitId == null
                        ? src.Details.Where(d => d.FieldName == Enums.ContributionDetailFieldName.FirstName)
                            .Select(d => d.NewValue)
                            .FirstOrDefault()
                     : src.Portrait!.FirstName))
               .ForMember(dest => dest.PortraitLastName, opt => opt.MapFrom(src =>
                    src.PortraitId == null
                        ? src.Details.Where(d => d.FieldName == Enums.ContributionDetailFieldName.LastName)
                            .Select(d => d.NewValue)
                            .FirstOrDefault()
                     : src.Portrait!.LastName));

            CreateMap<AppUser, ShortUserInfoDto>();
            CreateMap<ContributionDetail, ContributionDetailDto>();
            CreateMap<Contribution, ContributionViewDto>()
                .ForMember(dest => dest.Portrait, opt => opt.MapFrom(src => src.Portrait))
                .ForMember(dest => dest.Contributor, opt => opt.MapFrom(src => src.Contributor))
                .ForMember(dest => dest.Details, opt => opt.MapFrom(src => src.Details));

            CreateMap<Contribution, UserContributionListDto>()
                .ForMember(dest => dest.ContributionId, opt => opt.MapFrom(src => src.Id))
                .ForMember(dest => dest.IsNewPortrait, opt => opt.MapFrom(src => src.PortraitId == null))
                .ForMember(dest => dest.PortraitId, opt => opt.MapFrom(src => src.PortraitId))
               //Si c'est un nouveau portrait il faut mapp a partir des détails de la contribution, si non c'est à partir du portrait
               .ForMember(dest => dest.PortraitFirstName, opt => opt.MapFrom(src =>
                    src.PortraitId == null
                        ? src.Details.Where(d => d.FieldName == Enums.ContributionDetailFieldName.FirstName)
                            .Select(d => d.NewValue)
                            .FirstOrDefault()
                     : src.Portrait!.FirstName))
               .ForMember(dest => dest.PortraitLastName, opt => opt.MapFrom(src =>
                    src.PortraitId == null
                        ? src.Details.Where(d => d.FieldName == Enums.ContributionDetailFieldName.LastName)
                            .Select(d => d.NewValue)
                            .FirstOrDefault()
                     : src.Portrait!.LastName));

            CreateMap<Contribution, UserContributionViewDto>()
               .ForMember(dest => dest.Portrait, opt => opt.MapFrom(src => src.Portrait))
               .ForMember(dest => dest.Details, opt => opt.MapFrom(src => src.Details));


        }
    }
}

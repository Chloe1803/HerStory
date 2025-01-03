using AutoMapper;
using HerStory.Server.Dtos;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using HerStory.Server.Enums;

namespace HerStory.Server.Services
{
    public class PortraitService : IPortraitService
    {
        private readonly IPortraitRepository _portraitRepository;
        private readonly IMapper _mapper;
        private readonly IContributionRepository _contributionRepository;
        public PortraitService(IPortraitRepository portraitRepository, IMapper mapper, IContributionRepository contributionRepository)
        {
            _portraitRepository = portraitRepository;
            _mapper = mapper;
            _contributionRepository = contributionRepository;

        }

        public async Task<bool> CreatePortraitFromContribution(Contribution contribution)
        {
            if (contribution.Details == null || contribution.Details.Count == 0)
            {
                return false; 
            }

            //Champs a compléter
            string firstName = "";
            string lastName = "";
            DateTime dateOfBirth = DateTime.MinValue;
            DateTime dateOfDeath;
            string biographyAbstract = "";
            string biographyFull = "";
            string countryOfBirth = "";
            string photoUrl = "";
            string courtyOfBirth = "";
            string categoriesAsString = "";
            string fieldsAsString = "";
          


            foreach (var detail in contribution.Details)
            {
                switch (detail.FieldName)
                {
                    case ContributionDetailFieldName.FirstName:
                        firstName = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.LastName:
                        lastName = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.DateOfBirth:
                        dateOfBirth = DateTime.Parse(detail.NewValue);
                        break;
                    case ContributionDetailFieldName.DateOfDeath:
                        if (detail.NewValue != null)
                            dateOfDeath = DateTime.Parse(detail.NewValue);
                        break;
                    case ContributionDetailFieldName.BiographyAbstract:
                        biographyAbstract = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.BiographyFull:
                        biographyFull = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.PhotoUrl:
                        photoUrl = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.CountryOfBirth:
                        countryOfBirth = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.Categories:
                        categoriesAsString = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.Fields:
                        fieldsAsString = detail.NewValue;
                        break;
                }

                var portrait = new Portrait
                {
                    FirstName = firstName,
                    LastName = lastName,
                    DateOfBirth = dateOfBirth,
                    BiographyAbstract = biographyAbstract,
                    BiographyFull = biographyFull,
                    PhotoUrl = photoUrl,
                    CountryOfBirth = countryOfBirth,
                    CreatedAt = DateTime.Now
                };

                var create = await _portraitRepository.CreatePortrait(portrait);
                if (!create)
                    return create;

                contribution.PortraitId = portrait.Id;

                var updateContribution = await _contributionRepository.UpdateContribution(contribution);
                if (!updateContribution)
                    return false;

                return true;
    
            }
        }

        public async Task<ICollection<PortraitListDto>> GetAllPortraitsAsync()
        {
            var portraits = _mapper.Map<ICollection<PortraitListDto>>(await _portraitRepository.GetAllPortraitsAsync());

            return portraits;
        }

        public async Task<ICollection<CategoryDto>> GetCategories()
        {
            var categories = _mapper.Map<ICollection<CategoryDto>>(await _portraitRepository.GetCategories());

            return categories;
        }

        public async Task<ICollection<FieldDto>> GetFields()
        {
            var fields = _mapper.Map<ICollection<FieldDto>>(await _portraitRepository.GetFields());
            return fields;
        }

        public async Task<PortraitDetailDto> GetPortraitByIdAsync(int id)
        {
            var portrait = _mapper.Map<PortraitDetailDto>(await _portraitRepository.GetProtraitByIdAsync(id));

            return portrait;
        }

        public Task<bool> UpdatePortraitFromContribution(Contribution contibution)
        {
            throw new NotImplementedException();
        }
    }
}

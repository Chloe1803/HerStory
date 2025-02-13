using AutoMapper;
using HerStory.Server.Dtos;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using HerStory.Server.Enums;
using Newtonsoft.Json;

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

        public async Task CreatePortraitFromContribution(Contribution contribution)
        {
            if (contribution.Details == null || contribution.Details.Count == 0)
            {
                throw new InvalidOperationException("No contribution details"); 
            }

            //Champs a compléter
            string firstName = "";
            string lastName = "";
            DateTime dateOfBirth = DateTime.MinValue;
            DateTime? dateOfDeath = null;
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
            }

            var portrait = new Portrait
            {
                FirstName = firstName,
                LastName = lastName,
                DateOfBirth = dateOfBirth,
                DateOfDeath = dateOfDeath,
                BiographyAbstract = biographyAbstract,
                BiographyFull = biographyFull,
                PhotoUrl = photoUrl,
                CountryOfBirth = countryOfBirth,
                CreatedAt = DateTime.Now
            };

           
            try
            {
               await UpdateCategoriesForPortrait(portrait, categoriesAsString);
               await UpdateFieldsForPortrait(portrait, fieldsAsString);

                
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Echec de l'ajout de catégorie et fields : {ex.Message}");
                throw;
            }

            try
            {
                await _portraitRepository.CreatePortrait(portrait);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Une erreur est survenue lors de la création du portrait : {ex.Message}");
                throw;
            }

            try
            {
                contribution.PortraitId = portrait.Id;

                await _contributionRepository.UpdateContribution(contribution);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Une erreur est survenue lors de la mise à jour de la contribution avec l'id du portrait créer : {ex.Message}");
                throw;
            }



        }

        public async Task<ICollection<PortraitListDto>> GetAllPortraitsAsync(int offset, int limit)
        {
            var portraits = _mapper.Map<ICollection<PortraitListDto>>(await _portraitRepository.GetAllPortraitsAsync(offset, limit));

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

        public async Task UpdatePortraitFromContribution(Contribution contribution)
        {
            if (contribution.Details == null || contribution.Details.Count == 0)
            {
                throw new InvalidOperationException("No contribution details");
            }

            var portrait = contribution.Portrait;
            var categoriesAsString = "";
            var fieldsAsString = "";

            foreach (var detail in contribution.Details)
            {
                switch (detail.FieldName)
                {
                    case ContributionDetailFieldName.FirstName:
                        portrait.FirstName = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.LastName:
                        portrait.LastName = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.DateOfBirth:
                        portrait.DateOfBirth = DateTime.Parse(detail.NewValue);
                        break;
                    case ContributionDetailFieldName.DateOfDeath:
                        portrait.DateOfDeath = DateTime.Parse(detail.NewValue);
                        break;
                    case ContributionDetailFieldName.BiographyAbstract:
                        portrait.BiographyAbstract = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.BiographyFull:
                        portrait.BiographyFull = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.PhotoUrl:
                        portrait.PhotoUrl = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.CountryOfBirth:
                        portrait.CountryOfBirth = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.Categories:
                        categoriesAsString = detail.NewValue;
                        break;
                    case ContributionDetailFieldName.Fields:
                        fieldsAsString = detail.NewValue;
                        break;
                }
            }

            portrait.UpdatedAt = DateTime.Now;
            try
            { 
                await UpdateCategoriesForPortrait(portrait, categoriesAsString);
                await UpdateFieldsForPortrait(portrait, fieldsAsString);

                await _portraitRepository.UpdatePortrait(portrait);
          
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Une erreur est survenue : {ex.Message}");
                throw;
            }

        }

        public async Task UpdateCategoriesForPortrait(Portrait portrait, string categoriesAsString)
        {
            if (string.IsNullOrWhiteSpace(categoriesAsString))
            {
                return;
            }

            // Parse les catégories
            var categoryNames = JsonConvert.DeserializeObject<List<string>>(categoriesAsString);
            if (categoryNames == null)
                return;

            // Récupére les catégories de la base de données
            var categories = await _portraitRepository.GetCategoriesByNamesAsync(categoryNames);

            // Met à jour les relations
            portrait.PortraitCategories = categories.Select(category => new PortraitCategory
            {
                PortraitId = portrait.Id,
                CategoryId = category.Id,
                Category = category
            }).ToList();
        }

        public async Task UpdateFieldsForPortrait(Portrait portrait, string fieldsAsString)
        {
            if (string.IsNullOrWhiteSpace(fieldsAsString))
            {
                return;
            }
         
            // Parse les champs
            var fieldNames = JsonConvert.DeserializeObject<List<string>>(fieldsAsString);
            if (fieldNames == null)
            {
                return;
            }
           

            // Récupére les champs de la base de données
            var fields = await _portraitRepository.GetFieldsByNamesAsync(fieldNames);

           
            portrait.PortraitFields = fields.Select(field => new PortraitField
            {
                PortraitId = portrait.Id,
                FieldId = field.Id,
                Field = field
            }).ToList();
        }

        public async Task<ICollection<PortraitListDto>> SearchByTermAsync(string term)
        {
            term = term.ToLower();

            var portrait = await _portraitRepository.SearchByName(term);

            return _mapper.Map<ICollection<PortraitListDto>>(portrait);
 
        }

        public async Task<ICollection<PortraitListDto>> FilterAsync(FilterCriteriaDto criteria)
        {
            var portrait = await _portraitRepository.FilterByCategoryAndField(criteria);
            return _mapper.Map<ICollection<PortraitListDto>>(portrait);

        }
    }
}

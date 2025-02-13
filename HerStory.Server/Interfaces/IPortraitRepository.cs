using HerStory.Server.Dtos;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitRepository
    {
        Task<ICollection<Portrait>> GetAllPortraitsAsync(int offset, int limit);
        Task<Portrait> GetProtraitByIdAsync(int id);
        Task<ICollection<Category>> GetCategories();
        Task<ICollection<Category>> GetCategoriesByNamesAsync(ICollection<string> categoryNames);
        Task<ICollection<Field>> GetFields();
        Task<ICollection<Field>> GetFieldsByNamesAsync(ICollection<string> fieldNames);
        Task CreatePortrait(Portrait portrait);
        Task UpdatePortrait(Portrait portrait);
        Task<ICollection<Portrait>> SearchByName(string term);
        Task<ICollection<Portrait>> FilterByCategoryAndField(FilterCriteriaDto criteria);
    }
}

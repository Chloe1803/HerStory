using HerStory.Server.Dtos;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitService
    {
        Task<ICollection<PortraitListDto>> GetAllPortraitsAsync(int offset, int limit);
        Task<PortraitDetailDto> GetPortraitByIdAsync(int id);
        Task<ICollection<CategoryDto>> GetCategories();
        Task<ICollection<FieldDto>> GetFields();
        Task CreatePortraitFromContribution(Contribution contribution);
        Task UpdatePortraitFromContribution(Contribution contibution);
        Task<ICollection<PortraitListDto>> SearchByTermAsync(string term);
        Task<ICollection<PortraitListDto>> FilterAsync(FilterCriteriaDto criteria);
    }
}

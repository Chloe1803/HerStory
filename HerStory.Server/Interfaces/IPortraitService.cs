using HerStory.Server.Dtos;
using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitService
    {
        Task<ICollection<PortraitListDto>> GetAllPortraitsAsync();
        Task<PortraitDetailDto> GetPortraitByIdAsync(int id);
        Task<ICollection<CategoryDto>> GetCategories();
        Task<ICollection<FieldDto>> GetFields();
        Task<bool> CreatePortraitFromContribution(Contribution contribution);
        Task<bool> UpdatePortraitFromContribution(Contribution contibution);
    }
}

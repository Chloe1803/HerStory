using HerStory.Server.Dtos;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitService
    {
        Task<ICollection<PortraitListDto>> GetAllPortraitsAsync();
        Task<PortraitDetailDto> GetPortraitByIdAsync(int id);
    }
}

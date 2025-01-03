using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitRepository
    {
        Task<ICollection<Portrait>> GetAllPortraitsAsync();
        Task<Portrait> GetProtraitByIdAsync(int id);
        Task<ICollection<Category>> GetCategories();
        Task<ICollection<Field>> GetFields();
        Task<bool> CreatePortrait(Portrait portrait);
        Task<bool> UpdatePortrait(Portrait portrait);
    }
}

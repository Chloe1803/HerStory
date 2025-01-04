﻿using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitRepository
    {
        Task<ICollection<Portrait>> GetAllPortraitsAsync();
        Task<Portrait> GetProtraitByIdAsync(int id);
        Task<ICollection<Category>> GetCategories();
        Task<ICollection<Category>> GetCategoriesByNamesAsync(ICollection<string> categoryNames);
        Task<ICollection<Field>> GetFields();
        Task<ICollection<Field>> GetFieldsByNamesAsync(ICollection<string> fieldNames);
        Task CreatePortrait(Portrait portrait);
        Task UpdatePortrait(Portrait portrait);
    }
}

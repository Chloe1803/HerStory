﻿using HerStory.Server.Models;

namespace HerStory.Server.Interfaces
{
    public interface IPortraitRepository
    {
        Task<ICollection<Portrait>> GetAllPortraitsAsync();
        Task<Portrait> GetProtraitByIdAsync(int id);
   }
}

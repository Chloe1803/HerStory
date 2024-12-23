using HerStory.Server.Data;
using HerStory.Server.Interfaces;
using HerStory.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace HerStory.Server.Repositories
{
    public class PortraitRepository : IPortraitRepository
    {
        private readonly ApplicationDbContext _context;
        public PortraitRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<ICollection<Portrait>> GetAllPortraitsAsync()
        {
            return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .ToListAsync();
        }

        public async Task<ICollection<Category>> GetCategories()
        {
            return await _context.Category.ToListAsync();
        }

        public async Task<ICollection<Field>> GetFields()
        {
            return await _context.Field.ToListAsync();
        }

        public async Task<Portrait> GetProtraitByIdAsync(int id)
        {
            return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .FirstOrDefaultAsync(p => p.Id == id);
        }
    }
}

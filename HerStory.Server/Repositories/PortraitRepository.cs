using HerStory.Server.Data;
using HerStory.Server.Dtos;
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

        public async Task CreatePortrait(Portrait portrait)
        {
            await _context.Portrait.AddAsync(portrait);
            await _context.SaveChangesAsync();
        }

        public async Task<ICollection<Portrait>> FilterByCategoryAndField(FilterCriteriaDto criteria)
        {
            var query = _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .AsQueryable();

            // Filtrage par catégories
            if (criteria.Categories != null && criteria.Categories.Any())
            {
                var categoryIds = criteria.Categories.Select(c => c.Id).ToList();
                query = query.Where(p => p.PortraitCategories.Any(c => categoryIds.Contains(c.CategoryId)));
            }

            // Filtrage par champs
            if (criteria.Fields != null && criteria.Fields.Any())
            {
                var fieldIds = criteria.Fields.Select(f => f.Id).ToList();
                query = query.Where(p => p.PortraitFields.Any(p => fieldIds.Contains(p.FieldId)));
            }

            return await query.ToListAsync();

        }

        public async Task<ICollection<Portrait>> GetAllPortraitsAsync()
        {
            var portraits = await _context.Portrait
               .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
               .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
               .ToListAsync();

             return portraits.OrderBy(_ => Guid.NewGuid()).ToList();
        }

        public async Task<ICollection<Category>> GetCategories()
        {
            return await _context.Category.ToListAsync();
        }

        public async Task<ICollection<Category>> GetCategoriesByNamesAsync(ICollection<string> categoryNames)
        {
            // Vérifie si categoryNames est null ou vide
             if (categoryNames == null || !categoryNames.Any())
             {
                return new List<Category>(); 
             }

             var categories = await _context.Category
                                               .Where(c => categoryNames.Contains(c.Name))
                                               .ToListAsync();

             return categories;
        }

        public async Task<ICollection<Field>> GetFields()
        {
            return await _context.Field.ToListAsync();
        }

        public async Task<ICollection<Field>> GetFieldsByNamesAsync(ICollection<string> fieldNames)
        {
            if (fieldNames == null || !fieldNames.Any())
            {
                return new List<Field>();
            }

            var fields = await  _context.Field
                    .Where(c => fieldNames.Contains(c.Name))
                    .ToListAsync();

            return fields;
  
        }

        public async Task<Portrait> GetProtraitByIdAsync(int id)
        {
            return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<ICollection<Portrait>> SearchByName(string term)
        {
            return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                 .Where(p => p.FirstName.ToLower().Contains(term) ||
                             p.LastName.ToLower().Contains(term))
                 .ToListAsync();
        }

        public async Task UpdatePortrait(Portrait portrait)
        {
            _context.Update(portrait);
            await _context.SaveChangesAsync();
        }
    }
}

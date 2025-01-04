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

        public async Task CreatePortrait(Portrait portrait)
        {
            try
            {
                _context.Portrait.AddAsync(portrait);
                _context.SaveChangesAsync();
                
            }catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error: {ex.Message}");
                throw new Exception("An unexpected error occurred.", ex);
            }
        }

        public async Task<ICollection<Portrait>> GetAllPortraitsAsync()
        {
            try
            {
                return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .ToListAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error: {ex.Message}");
                throw new Exception("An unexpected error occurred.", ex);
            }


        }

        public async Task<ICollection<Category>> GetCategories()
        {
            return await _context.Category.ToListAsync();
        }

        public async Task<ICollection<Category>> GetCategoriesByNamesAsync(ICollection<string> categoryNames)
        {
            try
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
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la récupération des catégories par noms.", ex);
            }
        }

        public async Task<ICollection<Field>> GetFields()
        {
            return await _context.Field.ToListAsync();
        }

        public async Task<ICollection<Field>> GetFieldsByNamesAsync(ICollection<string> fieldNames)
        {
            try
            {
                if (fieldNames == null || fieldNames.Any())
                    return new List<Field>();

                var fields = await  _context.Field
                    .Where(c => fieldNames.Contains(c.Name))
                    .ToListAsync();

                return fields;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la récupération des fields par noms.", ex);
            }
        }

        public async Task<Portrait> GetProtraitByIdAsync(int id)
        {
            return await _context.Portrait
                .Include(p => p.PortraitCategories).ThenInclude(pc => pc.Category)
                .Include(p => p.PortraitFields).ThenInclude(pf => pf.Field)
                .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task UpdatePortrait(Portrait portrait)
        {
           try
            {
               _context.Update(portrait);
                await _context.SaveChangesAsync();
               
            }
            catch (DbUpdateException ex)
            {
                Console.WriteLine($"Database update error: {ex.Message}");
                throw new Exception("An error occurred while updating the portrait in the database.", ex);
            }
            catch (Exception ex)
            {
                // Journaliser toute autre exception inattendue
                Console.WriteLine($"Unexpected error: {ex.Message}");
                throw new Exception("An unexpected error occurred.", ex);
            }
        }
    }
}

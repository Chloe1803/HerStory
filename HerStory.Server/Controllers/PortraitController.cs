using HerStory.Server.Dtos;
using Microsoft.AspNetCore.Mvc;
using HerStory.Server.Interfaces;


namespace HerStory.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PortraitController : Controller
    {
        private readonly IPortraitService _portraitService;
        public PortraitController(IPortraitService portraitService)
        {
            _portraitService = portraitService;
        }
        [HttpGet]
        [ProducesResponseType(200, Type =typeof(ICollection<PortraitListDto>))]
        public async Task<IActionResult> GetAllPortraitsAsync()
        {
            try
            {
                var portraits = await _portraitService.GetAllPortraitsAsync();
                if (portraits == null || !portraits.Any())
                {
                    return NotFound();
                }

                return Ok(portraits);
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(PortraitDetailDto))]
        public async Task<IActionResult> GetPortraitByIdAsync(int id)
        {
            try
            {
                var portrait = await _portraitService.GetPortraitByIdAsync(id);
                if (portrait == null)
                {
                    return NotFound();
                }
                return Ok(portrait);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
     }
}

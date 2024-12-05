using AutoMapper;
using HerStory.Server.Dtos;
using HerStory.Server.Interfaces;

namespace HerStory.Server.Services
{
    public class PortraitService : IPortraitService
    {
        private readonly IPortraitRepository _portraitRepository;
        private readonly IMapper _mapper;
        public PortraitService(IPortraitRepository portraitRepository, IMapper mapper)
        {
            _portraitRepository = portraitRepository;
            _mapper = mapper;

        }
        public async Task<ICollection<PortraitListDto>> GetAllPortraitsAsync()
        {
            var portraits = _mapper.Map<ICollection<PortraitListDto>>(await _portraitRepository.GetAllPortraitsAsync());

            return portraits;
        }

        public async Task<PortraitDetailDto> GetPortraitByIdAsync(int id)
        {
            var portrait = _mapper.Map<PortraitDetailDto>(await _portraitRepository.GetProtraitByIdAsync(id));

            return portrait;
        }
    }
}

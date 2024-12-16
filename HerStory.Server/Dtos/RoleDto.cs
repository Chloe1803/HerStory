using HerStory.Server.Enums;
using System.Text.Json.Serialization;

namespace HerStory.Server.Dtos
{
    public class RoleDto
    {
        public int Id { get; set; }
        [JsonConverter(typeof(JsonStringEnumConverter))]
        public RoleName Name { get; set; }
    }
}

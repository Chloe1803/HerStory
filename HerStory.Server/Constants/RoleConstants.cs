using HerStory.Server.Enums;

namespace HerStory.Server.Constants
{
    public class RoleConstants
    {
        public static readonly Dictionary<RoleName, int> RoleIds = new Dictionary<RoleName, int>
    {
        { RoleName.Banned, 3 },
        { RoleName.Visitor, 8 },
        { RoleName.Contributor, 4 },
        { RoleName.Reviewer, 5 },
        { RoleName.Admin, 6 },
        { RoleName.SuperAdmin, 7 }
    };

        public static class RoleHierarchy
        {
            public static readonly Dictionary<RoleName, int> RoleLevels = new Dictionary<RoleName, int>
            {
                { RoleName.Banned, 0 },
                { RoleName.Visitor, 1 },
                { RoleName.Contributor, 2 },
                { RoleName.Reviewer, 3 },
                { RoleName.Admin, 4 },
                { RoleName.SuperAdmin, 5 }
            };

            public static bool HasAccess(RoleName userRole, RoleName requiredRole)
            {
                return RoleLevels[userRole] >= RoleLevels[requiredRole];
            }

            public static RoleName? GetNextRole(RoleName currentRole)
            {
                var roleList = RoleLevels.OrderBy(kv => kv.Value).Select(kv => kv.Key).ToList();
                var currentIndex = roleList.IndexOf(currentRole);

                if (currentIndex == -1 || currentIndex == roleList.Count - 1)
                {
                    return null; // Aucun rôle suivant ou rôle non trouvé
                }

                return roleList[currentIndex + 1];
            }

        }
    }
}

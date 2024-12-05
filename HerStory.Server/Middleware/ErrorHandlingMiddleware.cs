using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System;
using System.Net;
using System.Threading.Tasks;
using HerStory.Server.Exceptions;
using HerStory.Server.Constants;

namespace HerStory.Server.Middleware
{
    public class ErrorHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ErrorHandlingMiddleware> _logger;

        public ErrorHandlingMiddleware(RequestDelegate next, ILogger<ErrorHandlingMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext httpContext)
        {
            try
            {
                // Appel du middleware suivant
                await _next(httpContext);
            }
            catch (BadRequestException ex)
            {
                // Logge l'erreur et renvoie un code HTTP 400 pour BadRequest
                _logger.LogError(ex, ErrorMessages.BadRequest);
                httpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                httpContext.Response.ContentType = "application/json";

                var response = new { message = ex.Message, errorCode = "BAD_REQUEST" };
                await httpContext.Response.WriteAsJsonAsync(response);
            }
            catch (UnauthorizedException ex)
            {
                // Logge l'erreur et renvoie un code HTTP 401 pour Unauthorized
                _logger.LogError(ex, ErrorMessages.Unauthorized);
                httpContext.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                httpContext.Response.ContentType = "application/json";

                var response = new { message = ex.Message, errorCode = "UNAUTHORIZED" };
                await httpContext.Response.WriteAsJsonAsync(response);
            }
            catch (ConflictException ex)
            {
                // Logge l'erreur et renvoie un code HTTP 409 pour Conflict
                _logger.LogError(ex, ErrorMessages.Conflict);
                httpContext.Response.StatusCode = (int)HttpStatusCode.Conflict;
                httpContext.Response.ContentType = "application/json";

                var response = new { message = ex.Message, errorCode = "CONFLICT" };
                await httpContext.Response.WriteAsJsonAsync(response);
            }
            catch (Exception ex)
            {
                // Gestion des autres erreurs (500 par défaut)
                _logger.LogError(ex, ErrorMessages.InternalServerError);
                httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                httpContext.Response.ContentType = "application/json";

                var response = new { message = ErrorMessages.InternalServerError, errorCode = "INTERNAL_SERVER_ERROR" };
                await httpContext.Response.WriteAsJsonAsync(response);
            }
        }
    }
}

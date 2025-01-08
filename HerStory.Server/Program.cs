using Microsoft.EntityFrameworkCore;
using HerStory.Server.Data;
using HerStory.Server;
using HerStory.Server.Extensions;
using Microsoft.Extensions.Logging;
using HerStory.Server.Middleware;
using HerStory.Server.Configuration;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authentication;

using Microsoft.OpenApi.Models;
using HerStory.Server.Hubs;

var builder = WebApplication.CreateBuilder(args);

// Configure le logging 
builder.Logging.ClearProviders();  
builder.Logging.AddConsole();      
builder.Logging.AddDebug();

builder.Services.AddControllers();
builder.Services.AddSignalR();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Enter 'Bearer' [space] and your token in the text input below. Example: 'Bearer abcdef12345'"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});


// Services liées a la DB et au entités
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddTransient<Seed>();
builder.Services.AddApplicationServices();
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// Gestion des CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular", policy =>
    {
        policy.WithOrigins("http://localhost:4200") // URL du front-end Angular
              .AllowAnyMethod()
              .AllowAnyHeader()
              .AllowCredentials();
    });
});

// Gestion des JWT
builder.Services.AddScoped<JwtAuthenticationHandler>();

// Charge les paramètres JWT depuis appsettings.json
builder.Services.Configure<JwtSettings>(builder.Configuration.GetSection("JwtSettings"));
JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
JwtSecurityTokenHandler.DefaultOutboundClaimTypeMap.Clear();

// Ajoute les services nécessaires
builder.Services.AddAuthorization();
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = "Jwt";
    options.DefaultChallengeScheme = "Jwt";

}).AddScheme<AuthenticationSchemeOptions, JwtAuthenticationHandler>("Jwt", null);



var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.Use(async (context, next) =>
{
    // Ignore les requêtes vers Swagger
    if (context.Request.Path.StartsWithSegments("/swagger"))
    {
        await next();
        return;
    }

    // Continue avec les autres middlewares
    await next();
});


app.UseDefaultFiles();
app.UseStaticFiles();

app.UseMiddleware<ErrorHandlingMiddleware>();
app.UseRouting();
app.UseCors("AllowAngular");

app.UseAuthentication();
app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
    endpoints.MapHub<NotificationHub>("/notifications"); // URL du hub
});




if (args.Length == 1 && args[0].ToLower() == "seeddata")
    SeedData(app);

void SeedData(IHost app)
{
    var scopedFactory = app.Services.GetService<IServiceScopeFactory>();
    if (scopedFactory == null)
    {
        throw new Exception("IServiceScopeFactory is not registered in the DI container.");
    }


    using (var scope = scopedFactory.CreateScope())
    {
        var service = scope.ServiceProvider.GetService<Seed>();
        service.SeedData();
    }
}

app.Run();

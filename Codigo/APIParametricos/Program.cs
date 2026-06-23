using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<DatosParametricos.ApplicationDbContext>(opciones => opciones.UseSqlServer("name=DefaultConnection"));

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("../swagger/v1/swagger.json", "API Sapal v1");
});

app.UseCors(c =>
{
    c.WithOrigins("http://localhost:9000")
    .AllowAnyHeader()
    .AllowCredentials()
    .WithMethods("GET", "PUT", "POST", "DELETE", "OPTIONS")
    .SetPreflightMaxAge(TimeSpan.FromSeconds(3600));
});

app.UseStaticFiles();

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthorization();

app.MapControllers();

app.Run();

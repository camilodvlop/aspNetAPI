using Microsoft.AspNetCore.Mvc;

namespace TestDummyApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HealthController : ControllerBase
    {
        // GET api/my
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new { message = "info controller ok" });
        }
    }
}
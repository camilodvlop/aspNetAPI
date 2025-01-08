using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace CPTestFunctionApp
{
    public static class TestHttpFunction
    {
        [FunctionName("TestHttpFunction")]
        public static IActionResult Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = "api/test/{id?}")] HttpRequest req,
            ILogger log,
            string id)
        {
            log.LogInformation("Processing a request.");

            // Handle GET request
            if (req.Method == "GET")
            {
                return new OkObjectResult(new { message = $"GET request received for ID: {id ?? "none"}" });
            }

            // Handle POST request
            if (req.Method == "POST")
            {
                string requestBody = new StreamReader(req.Body).ReadToEnd();
                dynamic data = JsonConvert.DeserializeObject(requestBody);
                return new OkObjectResult(new { message = "POST request received", data = data });
            }

            return new BadRequestObjectResult(new { error = "Unsupported HTTP method" });
        }
    }
}
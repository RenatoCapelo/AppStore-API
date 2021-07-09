using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StatusController : ControllerBase
    {
        // GET: api/<Status>
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new Status() {Message="Ok"});
            //return NotFound();
            //return BadRequest()
            //return StatusCode(402, "")
        }
    }
}

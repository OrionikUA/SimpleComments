using System.Collections.Generic;
using System.Linq;
using AppComments.Context;
using AppComments.Models;
using Microsoft.AspNetCore.Mvc;

namespace AppComments.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentsController : ControllerBase
    {
        [HttpGet]
        public ActionResult<List<ApiComment>> ReadAllComments()
        {
            try
            {
                var list = CommentRepository.ReadAllComments().Select(x => new ApiComment(x)).ToList();
                return new ActionResult<List<ApiComment>>(list);
            }
            catch
            {
                return StatusCode(500);
            }
        }

        [HttpGet("{id}")]
        public ActionResult<ApiComment> ReadComment(int id)
        {
            try
            {
                var comment = CommentRepository.ReadComment(id);
                if (comment == null)
                {
                    return StatusCode(500);
                }
                return new ActionResult<ApiComment>(new ApiComment(comment));
            }
            catch
            {
                return StatusCode(500);
            }
        }

        [HttpPost]
        public ActionResult CreateComment(ApiComment comment)
        {
            try
            {
                var result = CommentRepository.CreateComment(comment.Cast());
                if (result == null)
                {
                    return StatusCode(500);
                }
                return Ok(new ApiComment(result));
            }
            catch
            {
                return StatusCode(500);
            }
        }

        [HttpDelete("{id}")]
        public ActionResult DeleteComment(int id)
        {
            try
            {
                var result = CommentRepository.DeleteComment(id);
                if (!result)
                {
                    return StatusCode(500);
                }
                return Ok();
            }
            catch
            {
                return StatusCode(500);
            }
        }
        
        [HttpPut("{id}")]
        public ActionResult<ApiComment> UpdateComment(int id, ApiComment apiComment)
        {
            try
            {
                var result = CommentRepository.UpdateComment(id, apiComment.User, apiComment.Message, apiComment.IsLike);
                if (result == null)
                {
                    return StatusCode(500);
                }
                return new ActionResult<ApiComment>(new ApiComment(result));
            }
            catch
            {
                return StatusCode(500);
            }
        }
    }
}
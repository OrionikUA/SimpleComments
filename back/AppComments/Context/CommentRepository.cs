using System;
using System.Collections.Generic;
using System.Linq;
using AppComments.DbModels;
using Microsoft.EntityFrameworkCore;

namespace AppComments.Context
{
    public static class CommentRepository
    {
        private static MainContext CreateContext() => new MainContext();

        public static List<Comment> ReadAllComments()
        {
            try
            {
                using var context = CreateContext();
                return context.Comments.Include(x => x.Children).ToList().Where(x => x.Parent == null).ToList();
            }
            catch
            {
                return null;
            }
        }

        private static Comment GetContextById(int id, MainContext context, bool includeChildren = false)
        {
            if (includeChildren)
            {
                return context.Comments.Include(x => x.Children).FirstOrDefault(x => x.Id == id);
            }
            return context.Comments.FirstOrDefault(x => x.Id == id);
        }

        public static Comment ReadComment(int id)
        {
            try
            {
                using var context = CreateContext();
                return GetContextById(id, context);
            }
            catch
            {
                return null;
            }
        }

        public static Comment CreateComment(Comment comment)
        {
            try
            {
                using var context = CreateContext();
                context.Comments.Add(comment);
                context.SaveChanges();
                return comment;
            }
            catch
            {
                return null;
            }
        }

        public static bool DeleteComment(int id)
        {
            try
            {
                using var context = CreateContext();
                if (!DeleteComment(id, context))
                    return false;
                context.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        private static bool DeleteComment(int id, MainContext context)
        {
            try
            {
                var comment = GetContextById(id, context, true);
                if (comment == null) return false;
                foreach (var child in comment.Children)
                {
                    var r = DeleteComment(child.Id, context);
                    if (!r) return false;
                }
                context.Comments.Remove(comment);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static Comment UpdateComment(int id, String user = null, String message = null, bool? isLike = null)
        {
            try
            {
                var hasChanges = false;
                using var context = CreateContext();
                var comment = GetContextById(id, context);
                if (!string.IsNullOrEmpty(user) && !string.Equals(user, comment.User))
                {
                    comment.User = user;
                    hasChanges = true;
                }
                if (!string.IsNullOrEmpty(message) && !string.Equals(message, comment.Message))
                {
                    comment.Message = message;
                    hasChanges = true;
                }
                if (isLike.HasValue && comment.IsLike != isLike.Value)
                {
                    comment.IsLike = isLike.Value;
                    hasChanges = true;
                }

                if (hasChanges)
                {
                    comment.UpdateDate = DateTime.Now;
                }

                var newComment = context.Update(comment);
                context.SaveChanges();
                return newComment.Entity;
            }
            catch
            {
                return null;
            }
        }
    }
}
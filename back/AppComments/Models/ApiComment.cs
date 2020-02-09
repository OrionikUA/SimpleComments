using System;
using System.Collections.Generic;
using AppComments.DbModels;

namespace AppComments.Models
{
    public class ApiComment
    {
        public int? Id { get; set; }
        public string User { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public string Message { get; set; }
        public bool IsLike { get; set; }
        public List<ApiComment> InnerComment { get; set; }
        public int? ParentId { get; set; }

        public ApiComment()
        {
            InnerComment = new List<ApiComment>();
        }

        public ApiComment(Comment comment)
        {
            Id = comment.Id;
            User = comment.User;
            CreateDate = comment.CreateDate;
            UpdateDate = comment.UpdateDate;
            Message = comment.Message;
            IsLike = comment.IsLike;
            ParentId = comment.ParentId;
            InnerComment = new List<ApiComment>();
            if (comment.Children != null)
            {
                foreach (var commentChild in comment.Children)
                {
                    InnerComment.Add(new ApiComment(commentChild));
                }
            }
        }

        public Comment Cast()
        {
            return new Comment
            {
                Id = Id ?? 0,
                CreateDate = CreateDate ?? DateTime.Now,
                IsLike = IsLike,
                Message = Message,
                UpdateDate = UpdateDate,
                User = User,
                ParentId = ParentId,
            };
        }
    }
}

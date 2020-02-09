using System;
using System.Collections.Generic;

namespace AppComments.DbModels
{
    public class Comment
    {
        public int Id { get; set; }
        public String User { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public String Message { get; set; }
        public bool IsLike { get; set; }

        public virtual List<Comment> Children { get; set; }

        public virtual Comment Parent { get; set; }
        public int? ParentId { get; set; }
    }
}

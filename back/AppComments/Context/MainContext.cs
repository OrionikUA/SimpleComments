using System;
using AppComments.DbModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace AppComments.Context
{
    public class MainContext : DbContext
    {
        public DbSet<Comment> Comments { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();
            optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Comment>().HasKey(x => x.Id);
            modelBuilder.Entity<Comment>()
                .HasOne(x => x.Parent)
                .WithMany(x => x.Children)
                .HasForeignKey(x => x.ParentId);
            modelBuilder.Entity<Comment>().Property(x => x.User).IsRequired();
            modelBuilder.Entity<Comment>().Property(x => x.Message).IsRequired();
            modelBuilder.Entity<Comment>().Property(x => x.CreateDate).IsRequired();
            modelBuilder.Entity<Comment>().Property(x => x.IsLike).IsRequired();
        }
    }
}
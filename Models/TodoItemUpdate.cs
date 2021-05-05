#nullable enable
namespace TodoApi.Models
{
    public class TodoItemUpdate
    {
        public long Id { get; set; }
        public string? Name { get; set; }
        public bool? IsComplete { get; set; }
    }
}
const std = @import("std");

const MEM_SIZE = 1024 * 64;

pub const CPU = struct {
    allocator: std.mem.Allocator,
    memory: []u8,

    pub fn init(allocator: std.mem.Allocator) !CPU {
        const mem = try allocator.alloc(u8, MEM_SIZE);
        @memset(mem, 0);
        return CPU{
            .allocator = allocator,
            .memory = mem,
        };
    }

    pub fn deinit(self: *CPU) void {
        self.allocator.free(self.memory);
    }
};

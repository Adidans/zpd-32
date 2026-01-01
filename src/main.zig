const std = @import("std");
const rl = @import("raylib");
const rg = @import("raygui");
const cpuType = @import("cpu.zig");

pub fn main() !void {
    const screenWidth = 600;
    const screenHeight = 340;

    rl.initWindow(screenWidth, screenHeight, "ZPD-32");
    rl.setWindowMonitor(1);
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var stepButtonPressed = false;
    var runButtonPressed = false;
    var stopButtonPressed = false;

    // temp
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();
    const cpu = try cpuType.CPU.init(allocator);
    cpu.memory[cpu.memory.len - 1] = 2;
    std.debug.print("{any}", .{cpu.memory});

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);

        _ = rg.label(.init(56, 16, 120, 24), rl.textFormat("FPS: %d", .{rl.getFPS()}));
        _ = rg.groupBox(.init(48, 56, 120, 200), "REGISTERS");
        _ = rg.groupBox(.init(184, 56, 80, 104), "CPU");
        if (rg.button(.init(184, 168, 80, 24), "STEP")) {
            stepButtonPressed = true;
        }
        if (rg.button(.init(184, 200, 80, 24), "RUN")) {
            runButtonPressed = true;
        }
        if (rg.button(.init(184, 232, 80, 24), "STOP")) {
            stopButtonPressed = true;
        }
        // Display
        _ = rg.panel(.init(280, 32, 280, 280), null);
        _ = rg.groupBox(.init(48, 272, 120, 32), "INSTRUCTION");
        rl.drawText("ZPD-32", 180, 276, 24, .gray);
    }
}

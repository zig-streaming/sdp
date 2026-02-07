const std = @import("std");

const Self = @This();

pub const NetType = enum { IN };
pub const AddrType = enum { IP4, IP6 };

net_type: NetType,
addr_type: AddrType,
address: []const u8,

/// Parses a connection string in the format: "<net_type> <addr_type> <address>"
pub fn parse(buffer: []const u8) !Self {
    var parts = std.mem.splitAny(u8, buffer, " ");

    const net_type_str = parts.next() orelse return error.InvalidConnection;
    const addr_type_str = parts.next() orelse return error.InvalidConnection;
    const address_str = parts.next() orelse return error.InvalidConnection;

    const net_type = try parseNetType(net_type_str);
    const addr_type = try parseAddrType(addr_type_str);

    return Self{
        .net_type = net_type,
        .addr_type = addr_type,
        .address = address_str,
    };
}

pub fn parseNetType(input: []const u8) !NetType {
    if (std.mem.eql(u8, "IN", input)) {
        return NetType.IN;
    } else {
        return error.InvalidNetType;
    }
}

pub fn parseAddrType(input: []const u8) !AddrType {
    if (std.mem.eql(u8, "IP4", input)) {
        return AddrType.IP4;
    } else if (std.mem.eql(u8, "IP6", input)) {
        return AddrType.IP6;
    } else {
        return error.InvalidAddrType;
    }
}

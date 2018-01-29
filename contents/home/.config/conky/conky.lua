--[[
-- Conky configuration by Emil Bertilsson
]]

conky.config = {
    alignment = 'bottom_right',
    background = true,
    border_width = 10,
    cpu_avg_samples = 2,
	default_color = 'white',
    default_outline_color = 'white',
    default_shade_color = 'white',
    draw_borders = false,
    draw_graph_borders = true,
    draw_outline = false,
    draw_shades = false,
    use_xft = true,
    double_buffer = true,
    font = 'Anonymous Pro:size=9',
    gap_x = 10,
    gap_y = 0,
    minimum_height = 1080,
	minimum_width = 300,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_stderr = false,
    extra_newline = false,
    own_window = true,
    own_window_class = 'Conky',

    own_window_type = 'desktop',
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    own_window_transparent = false,
    own_window_argb_visual = true,
    own_window_argb_value = 127,
    stippled_borders = 0,
    update_interval = 1.0,
    uppercase = false,
    use_spacer = 'none',
    show_graph_scale = false,
    show_graph_range = false
}

local user_settings = {
    show_wireless = false,
    show_alt_filesystems = true,
    alt_filesystems = { "/home", "/media/hd1", "/media/win" }
}

local user_vars = {
    network_interface = 'enp6s0',
    network_rate_scale = 10000, -- Scale in KiB/s for the network graphs
    color_header = '#ffffff',
    font_header = 'Anonymous Pro:size=9:style=bold',
    font_main = 'Anonymous Pro:size=9',
    color_text1 = '#ffffff',
    color_text2 = '#cc6666',
    color_bar = '#ffffff',
    color_graph = '#ffffff',
    bar_height = 5,
    graph_height = 25
}

local function interp (s, t)
    return s:gsub('(#%b{})', function (w)
        return t[w:sub(3, -2)] or w
    end)
end

local function output_wireless()
    if user_settings.show_wireless then
        return
[[
${color #{color_text2}}${font #{font_main}}ESSID: ${color #{color_text1}}${wireless_essid #{network_interface}}
${color #{color_text2}}${font #{font_main}}Signal: ${color #{color_text1}}${wireless_link_qual_perc #{network_interface}}%
${color #{color_bar}}${wireless_link_bar #{bar_height} #{network_interface}}

]]
    else
        return ""
    end
end

local fs_template =
[[
${color #{color_text2}}${font #{font_main}}#{mp}: ${color #{color_text1}}${fs_used #{mp}}/${fs_size #{mp}}
${color #{color_bar}}${fs_bar #{mp}}
]]

local function output_filesystems()

    local output = interp(fs_template, { mp = '/' })

    if user_settings.show_alt_filesystems then
        for _, fs in pairs(user_settings.alt_filesystems) do
            output = output .. interp(fs_template, { mp = fs })
        end
    end

    return output
end

conky.text = interp([[
${color #{color_header}}${font #{font_header}}SYSTEM $hr

${color #{color_text2}}${font #{font_main}}System: ${color #{color_text1}}$sysname $kernel
${color #{color_text2}}${font #{font_main}}Uptime: ${color #{color_text1}}$uptime

${color #{color_header}}${font #{font_header}}CPU $hr

${color #{color_text2}}${font #{font_main}}Frequency: ${color #{color_text1}}${freq_g}GHz
${color #{color_text2}}${font #{font_main}}Processes: ${color #{color_text1}}$processes ($running_processes running)
${color #{color_text2}}${font #{font_main}}Total usage: ${color #{color_text1}}${cpu cpu0}%
${color #{color_bar}}${cpubar #{bar_height}}

${color #{color_text2}}${font #{font_main}}CPU1: ${color #{color_text1}}${cpu cpu1}%              ${color #{color_text2}}${font #{font_main}}CPU2: ${color #{color_text1}}${cpu cpu2}%
${color #{color_graph}}${cpugraph cpu1 #{graph_height},145 FF0000 00FF00} ${color #{color_graph}}${cpugraph cpu2 #{graph_height},145 FF0000 00FF00}
${color #{color_text2}}${font #{font_main}}Name                  PID     CPU%${alignr}MEM%
${color #{color_text1}}${font #{font_main}}  ${top name 1}  ${top pid 1}   ${top cpu 1}${alignr}${top mem 1}
${color #{color_text1}}${font #{font_main}}  ${top name 2}  ${top pid 2}   ${top cpu 2}${alignr}${top mem 2}
${color #{color_text1}}${font #{font_main}}  ${top name 3}  ${top pid 3}   ${top cpu 3}${alignr}${top mem 3}
${color #{color_text1}}${font #{font_main}}  ${top name 4}  ${top pid 4}   ${top cpu 4}${alignr}${top mem 4}

${color #{color_header}}${font #{font_header}}MEMORY $hr

${color #{color_text2}}${font #{font_main}}Swap usage: ${color #{color_text1}}$swap/$swapmax
${color #{color_text2}}${font #{font_main}}RAM usage: ${color #{color_text1}}$mem/$memmax
${membar #{bar_height}}
${color #{color_graph}}${memgraph #{graph_height},300 FF0000 00FF00}

${color #{color_header}}${font #{font_header}}FILESYSTEMS $hr

]] .. output_filesystems() .. [[

${color #{color_header}}${font #{font_header}}NETWORK $hr

]] .. output_wireless() .. [[
${color #{color_text2}}${font #{font_main}}IP: ${color #{color_text1}}${addr #{network_interface}}
${color #{color_text2}}${font #{font_main}}Upload: ${color #{color_text1}}${upspeedf #{network_interface}}K/s        ${color #{color_text2}}${font #{font_main}}Download: ${color #{color_text1}}${downspeedf #{network_interface}}K/s
${color #{color_graph}}${upspeedgraph #{network_interface} #{graph_height},145 FF0000 00FF00 #{network_rate_scale}} ${downspeedgraph #{network_interface} #{graph_height},145 FF0000 00FF00 #{network_rate_scale}}
]], user_vars)

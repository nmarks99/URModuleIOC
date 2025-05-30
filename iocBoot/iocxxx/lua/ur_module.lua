-- Correct path to ASYN_HTTP_CLIENT
local ASYN_HTTP_CLIENT = "/home/beams/NMARKS/devel/asynHttpClient/"
package.path = ASYN_HTTP_CLIENT .. "asynHttpClientApp/src/lua/?.lua;" .. package.path

epics = require("epics")
json = require("lunajson")

local function urlencode(str)
    return (str:gsub("[^%w%-._~]", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

function string_to_table(str)
    local chars = {}
    for i = 1, #str do
        chars[i] = str:sub(i, i)
    end
    return chars
end

function string_strip(s)
    return s:match("^%s*(.-)%s*$")
end

function toggle_gripper_set_post_url(args)
    local openval
    local closeval

    if A == 1 then
        openval = false
        closeval = true
    else
        openval = true
        closeval = false
    end

    local url = string.format("http://%s/action?action_name=toggle_gripper", args.host)
    local action_vars = {
        open = openval,
        close = closeval,
    }
    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    -- io.write("URL: ")
    -- print(full_url)

    return string_to_table(full_url)
end

function toggle_gripper_set_get_url(args)
    local action_id = string_strip(table.concat(AA))
    if (#action_id > 0) then
        local url = string.format("http://%s/action/%s", args.host, action_id)
        return string_to_table(url)
    end
end

function gripper_pick_set_post_url(args)
    local cspace = epics.get(string.format("%sUR:CoordinateSpace.VAL", args.P))
    local use_joint_space = cspace == 1 and true or false

    local home1 = epics.get(string.format("%sUR:GripperPick:Home1.VAL", args.P))
    local home2 = epics.get(string.format("%sUR:GripperPick:Home2.VAL", args.P))
    local home3 = epics.get(string.format("%sUR:GripperPick:Home3.VAL", args.P))
    local home4 = epics.get(string.format("%sUR:GripperPick:Home4.VAL", args.P))
    local home5 = epics.get(string.format("%sUR:GripperPick:Home5.VAL", args.P))
    local home6 = epics.get(string.format("%sUR:GripperPick:Home6.VAL", args.P))
    
    local source1 = epics.get(string.format("%sUR:GripperPick:Source1.VAL", args.P))
    local source2 = epics.get(string.format("%sUR:GripperPick:Source2.VAL", args.P))
    local source3 = epics.get(string.format("%sUR:GripperPick:Source3.VAL", args.P))
    local source4 = epics.get(string.format("%sUR:GripperPick:Source4.VAL", args.P))
    local source5 = epics.get(string.format("%sUR:GripperPick:Source5.VAL", args.P))
    local source6 = epics.get(string.format("%sUR:GripperPick:Source6.VAL", args.P))

    local url = string.format("http://%s/action?action_name=gripper_pick", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        source = {source1, source2, source3, source4, source5, source6},
        joint_angle_locations = use_joint_space,
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    return string_to_table(full_url)
end

function move_params_set_post_url(args)
    local p1 = epics.get(string.format("%sUR:MoveParams:TCPOffset_X.VAL", args.P))
    local p2 = epics.get(string.format("%sUR:MoveParams:TCPOffset_Y.VAL", args.P))
    local p3 = epics.get(string.format("%sUR:MoveParams:TCPOffset_Z.VAL", args.P))
    local p4 = epics.get(string.format("%sUR:MoveParams:TCPOffset_Roll.VAL", args.P))
    local p5 = epics.get(string.format("%sUR:MoveParams:TCPOffset_Pitch.VAL", args.P))
    local p6 = epics.get(string.format("%sUR:MoveParams:TCPOffset_Yaw.VAL", args.P))
    local vel = epics.get(string.format("%sUR:MoveParams:Velocity.VAL", args.P))
    local acc = epics.get(string.format("%sUR:MoveParams:Acceleration.VAL", args.P))

    local url = string.format("http://%s/action?action_name=set_movement_params", args.host)
    local action_vars = {
        tcp_pose = {p1, p2, p3, p4, p5, p6},
        velocity = vel,
        acceleration = acc,
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args
    print(full_url)

    return string_to_table(full_url)
end

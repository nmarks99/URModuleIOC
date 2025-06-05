-- ur_module.lua
-- Functions for constructing URLs for UR REST Node from PVs

-- Make sure lunajson is in your lua package path.
-- You can set LUA_PATH with epicsEnvSet(LUA_PATH, "...")
epics = require("epics")
json = require("lunajson")

DEBUG = true

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

    if DEBUG then
        print(json_args)
        print(full_url)
    end

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

    local home1 = epics.get(string.format("%s%sGripperPick:Home1.VAL", args.P, args.R))
    local home2 = epics.get(string.format("%s%sGripperPick:Home2.VAL", args.P, args.R))
    local home3 = epics.get(string.format("%s%sGripperPick:Home3.VAL", args.P, args.R))
    local home4 = epics.get(string.format("%s%sGripperPick:Home4.VAL", args.P, args.R))
    local home5 = epics.get(string.format("%s%sGripperPick:Home5.VAL", args.P, args.R))
    local home6 = epics.get(string.format("%s%sGripperPick:Home6.VAL", args.P, args.R))

    local source1 = epics.get(string.format("%s%sGripperPick:Source1.VAL", args.P, args.R))
    local source2 = epics.get(string.format("%s%sGripperPick:Source2.VAL", args.P, args.R))
    local source3 = epics.get(string.format("%s%sGripperPick:Source3.VAL", args.P, args.R))
    local source4 = epics.get(string.format("%s%sGripperPick:Source4.VAL", args.P, args.R))
    local source5 = epics.get(string.format("%s%sGripperPick:Source5.VAL", args.P, args.R))
    local source6 = epics.get(string.format("%s%sGripperPick:Source6.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=gripper_pick", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        source = {source1, source2, source3, source4, source5, source6},
        joint_angle_locations = (A == 1 and true or false),
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

function gripper_place_set_post_url(args)

    local home1 = epics.get(string.format("%s%sGripperPlace:Home1.VAL", args.P, args.R))
    local home2 = epics.get(string.format("%s%sGripperPlace:Home2.VAL", args.P, args.R))
    local home3 = epics.get(string.format("%s%sGripperPlace:Home3.VAL", args.P, args.R))
    local home4 = epics.get(string.format("%s%sGripperPlace:Home4.VAL", args.P, args.R))
    local home5 = epics.get(string.format("%s%sGripperPlace:Home5.VAL", args.P, args.R))
    local home6 = epics.get(string.format("%s%sGripperPlace:Home6.VAL", args.P, args.R))

    local target1 = epics.get(string.format("%s%sGripperPlace:Target1.VAL", args.P, args.R))
    local target2 = epics.get(string.format("%s%sGripperPlace:Target2.VAL", args.P, args.R))
    local target3 = epics.get(string.format("%s%sGripperPlace:Target3.VAL", args.P, args.R))
    local target4 = epics.get(string.format("%s%sGripperPlace:Target4.VAL", args.P, args.R))
    local target5 = epics.get(string.format("%s%sGripperPlace:Target5.VAL", args.P, args.R))
    local target6 = epics.get(string.format("%s%sGripperPlace:Target6.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=gripper_place", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        target = {target1, target2, target3, target4, target5, target6},
        joint_angle_locations = (A == 1 and true or false),
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

function move_params_set_post_url(args)
    local p1 = epics.get(string.format("%s%sMoveParams:TCPOffset_X.VAL", args.P, args.R))
    local p2 = epics.get(string.format("%s%sMoveParams:TCPOffset_Y.VAL", args.P, args.R))
    local p3 = epics.get(string.format("%s%sMoveParams:TCPOffset_Z.VAL", args.P, args.R))
    local p4 = epics.get(string.format("%s%sMoveParams:TCPOffset_Roll.VAL", args.P, args.R))
    local p5 = epics.get(string.format("%s%sMoveParams:TCPOffset_Pitch.VAL", args.P, args.R))
    local p6 = epics.get(string.format("%s%sMoveParams:TCPOffset_Yaw.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=set_movement_params", args.host)
    local action_vars = {
        tcp_pose = {p1, p2, p3, p4, p5, p6},
        velocity = A,
        acceleration = B,
        gripper_speed = C,
        gripper_force = D,
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

function pipette_dr_set_post_url(args)

    local home1 = epics.get(string.format("%s%sPipetteDR:Home1.VAL", args.P, args.R))
    local home2 = epics.get(string.format("%s%sPipetteDR:Home2.VAL", args.P, args.R))
    local home3 = epics.get(string.format("%s%sPipetteDR:Home3.VAL", args.P, args.R))
    local home4 = epics.get(string.format("%s%sPipetteDR:Home4.VAL", args.P, args.R))
    local home5 = epics.get(string.format("%s%sPipetteDR:Home5.VAL", args.P, args.R))
    local home6 = epics.get(string.format("%s%sPipetteDR:Home6.VAL", args.P, args.R))

    local target1 = epics.get(string.format("%s%sPipetteDR:Target1.VAL", args.P, args.R))
    local target2 = epics.get(string.format("%s%sPipetteDR:Target2.VAL", args.P, args.R))
    local target3 = epics.get(string.format("%s%sPipetteDR:Target3.VAL", args.P, args.R))
    local target4 = epics.get(string.format("%s%sPipetteDR:Target4.VAL", args.P, args.R))
    local target5 = epics.get(string.format("%s%sPipetteDR:Target5.VAL", args.P, args.R))
    local target6 = epics.get(string.format("%s%sPipetteDR:Target6.VAL", args.P, args.R))

    local tiptrash1 = epics.get(string.format("%s%sPipetteDR:TipTrash1.VAL", args.P, args.R))
    local tiptrash2 = epics.get(string.format("%s%sPipetteDR:TipTrash2.VAL", args.P, args.R))
    local tiptrash3 = epics.get(string.format("%s%sPipetteDR:TipTrash3.VAL", args.P, args.R))
    local tiptrash4 = epics.get(string.format("%s%sPipetteDR:TipTrash4.VAL", args.P, args.R))
    local tiptrash5 = epics.get(string.format("%s%sPipetteDR:TipTrash5.VAL", args.P, args.R))
    local tiptrash6 = epics.get(string.format("%s%sPipetteDR:TipTrash6.VAL", args.P, args.R))

    local safewp1 = epics.get(string.format("%s%sPipetteDR:SafeWP1.VAL", args.P, args.R))
    local safewp2 = epics.get(string.format("%s%sPipetteDR:SafeWP2.VAL", args.P, args.R))
    local safewp3 = epics.get(string.format("%s%sPipetteDR:SafeWP3.VAL", args.P, args.R))
    local safewp4 = epics.get(string.format("%s%sPipetteDR:SafeWP4.VAL", args.P, args.R))
    local safewp5 = epics.get(string.format("%s%sPipetteDR:SafeWP5.VAL", args.P, args.R))
    local safewp6 = epics.get(string.format("%s%sPipetteDR:SafeWP6.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=pipette_dispense_and_retrieve", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        target = {target1, target2, target3, target4, target5, target6},
        volume = B,
        tip_trash = {tiptrash1, tiptrash2, tiptrash3, tiptrash4, tiptrash5, tiptrash6},
        safe_waypoint = {safewp1, safewp2, safewp3, safewp4, safewp5, safewp6},
        joint_angle_locations = (A == 1 and true or false)
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

function pipette_pms_set_post_url(args)

    local home1 = epics.get(string.format("%s%sPipettePMS:Home1.VAL", args.P, args.R))
    local home2 = epics.get(string.format("%s%sPipettePMS:Home2.VAL", args.P, args.R))
    local home3 = epics.get(string.format("%s%sPipettePMS:Home3.VAL", args.P, args.R))
    local home4 = epics.get(string.format("%s%sPipettePMS:Home4.VAL", args.P, args.R))
    local home5 = epics.get(string.format("%s%sPipettePMS:Home5.VAL", args.P, args.R))
    local home6 = epics.get(string.format("%s%sPipettePMS:Home6.VAL", args.P, args.R))

    local target1 = epics.get(string.format("%s%sPipettePMS:Target1.VAL", args.P, args.R))
    local target2 = epics.get(string.format("%s%sPipettePMS:Target2.VAL", args.P, args.R))
    local target3 = epics.get(string.format("%s%sPipettePMS:Target3.VAL", args.P, args.R))
    local target4 = epics.get(string.format("%s%sPipettePMS:Target4.VAL", args.P, args.R))
    local target5 = epics.get(string.format("%s%sPipettePMS:Target5.VAL", args.P, args.R))
    local target6 = epics.get(string.format("%s%sPipettePMS:Target6.VAL", args.P, args.R))

    local sample1 = epics.get(string.format("%s%sPipettePMS:Sample1.VAL", args.P, args.R))
    local sample2 = epics.get(string.format("%s%sPipettePMS:Sample2.VAL", args.P, args.R))
    local sample3 = epics.get(string.format("%s%sPipettePMS:Sample3.VAL", args.P, args.R))
    local sample4 = epics.get(string.format("%s%sPipettePMS:Sample4.VAL", args.P, args.R))
    local sample5 = epics.get(string.format("%s%sPipettePMS:Sample5.VAL", args.P, args.R))
    local sample6 = epics.get(string.format("%s%sPipettePMS:Sample6.VAL", args.P, args.R))

    local tip1 = epics.get(string.format("%s%sPipettePMS:Tip1.VAL", args.P, args.R))
    local tip2 = epics.get(string.format("%s%sPipettePMS:Tip2.VAL", args.P, args.R))
    local tip3 = epics.get(string.format("%s%sPipettePMS:Tip3.VAL", args.P, args.R))
    local tip4 = epics.get(string.format("%s%sPipettePMS:Tip4.VAL", args.P, args.R))
    local tip5 = epics.get(string.format("%s%sPipettePMS:Tip5.VAL", args.P, args.R))
    local tip6 = epics.get(string.format("%s%sPipettePMS:Tip6.VAL", args.P, args.R))

    local safewp1 = epics.get(string.format("%s%sPipettePMS:SafeWP1.VAL", args.P, args.R))
    local safewp2 = epics.get(string.format("%s%sPipettePMS:SafeWP2.VAL", args.P, args.R))
    local safewp3 = epics.get(string.format("%s%sPipettePMS:SafeWP3.VAL", args.P, args.R))
    local safewp4 = epics.get(string.format("%s%sPipettePMS:SafeWP4.VAL", args.P, args.R))
    local safewp5 = epics.get(string.format("%s%sPipettePMS:SafeWP5.VAL", args.P, args.R))
    local safewp6 = epics.get(string.format("%s%sPipettePMS:SafeWP6.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=pipette_pick_and_move_sample", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        sample_loc = {sample1, sample2, sample3, sample4, sample5, sample6},
        target = {target1, target2, target3, target4, target5, target6},
        volume = B,
        tip_loc = {tip1, tip2, tip3, tip4, tip5, tip6},
        safe_waypoint = {safewp1, safewp2, safewp3, safewp4, safewp5, safewp6},
        joint_angle_locations = (A == 1 and true or false)
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

function pipette_transfer_set_post_url(args)

    local home1 = epics.get(string.format("%s%sPipetteTransfer:Home1.VAL", args.P, args.R))
    local home2 = epics.get(string.format("%s%sPipetteTransfer:Home2.VAL", args.P, args.R))
    local home3 = epics.get(string.format("%s%sPipetteTransfer:Home3.VAL", args.P, args.R))
    local home4 = epics.get(string.format("%s%sPipetteTransfer:Home4.VAL", args.P, args.R))
    local home5 = epics.get(string.format("%s%sPipetteTransfer:Home5.VAL", args.P, args.R))
    local home6 = epics.get(string.format("%s%sPipetteTransfer:Home6.VAL", args.P, args.R))

    local source1 = epics.get(string.format("%s%sPipetteTransfer:Source1.VAL", args.P, args.R))
    local source2 = epics.get(string.format("%s%sPipetteTransfer:Source2.VAL", args.P, args.R))
    local source3 = epics.get(string.format("%s%sPipetteTransfer:Source3.VAL", args.P, args.R))
    local source4 = epics.get(string.format("%s%sPipetteTransfer:Source4.VAL", args.P, args.R))
    local source5 = epics.get(string.format("%s%sPipetteTransfer:Source5.VAL", args.P, args.R))
    local source6 = epics.get(string.format("%s%sPipetteTransfer:Source6.VAL", args.P, args.R))

    local target1 = epics.get(string.format("%s%sPipetteTransfer:Target1.VAL", args.P, args.R))
    local target2 = epics.get(string.format("%s%sPipetteTransfer:Target2.VAL", args.P, args.R))
    local target3 = epics.get(string.format("%s%sPipetteTransfer:Target3.VAL", args.P, args.R))
    local target4 = epics.get(string.format("%s%sPipetteTransfer:Target4.VAL", args.P, args.R))
    local target5 = epics.get(string.format("%s%sPipetteTransfer:Target5.VAL", args.P, args.R))
    local target6 = epics.get(string.format("%s%sPipetteTransfer:Target6.VAL", args.P, args.R))

    local tip1 = epics.get(string.format("%s%sPipetteTransfer:Tip1.VAL", args.P, args.R))
    local tip2 = epics.get(string.format("%s%sPipetteTransfer:Tip2.VAL", args.P, args.R))
    local tip3 = epics.get(string.format("%s%sPipetteTransfer:Tip3.VAL", args.P, args.R))
    local tip4 = epics.get(string.format("%s%sPipetteTransfer:Tip4.VAL", args.P, args.R))
    local tip5 = epics.get(string.format("%s%sPipetteTransfer:Tip5.VAL", args.P, args.R))
    local tip6 = epics.get(string.format("%s%sPipetteTransfer:Tip6.VAL", args.P, args.R))

    local tiptrash1 = epics.get(string.format("%s%sPipetteTransfer:TipTrash1.VAL", args.P, args.R))
    local tiptrash2 = epics.get(string.format("%s%sPipetteTransfer:TipTrash2.VAL", args.P, args.R))
    local tiptrash3 = epics.get(string.format("%s%sPipetteTransfer:TipTrash3.VAL", args.P, args.R))
    local tiptrash4 = epics.get(string.format("%s%sPipetteTransfer:TipTrash4.VAL", args.P, args.R))
    local tiptrash5 = epics.get(string.format("%s%sPipetteTransfer:TipTrash5.VAL", args.P, args.R))
    local tiptrash6 = epics.get(string.format("%s%sPipetteTransfer:TipTrash6.VAL", args.P, args.R))

    local url = string.format("http://%s/action?action_name=pipette_transfer", args.host)
    local action_vars = {
        home = {home1, home2, home3, home4, home5, home6},
        source = {source1, source2, source3, source4, source5, source6},
        target = {target1, target2, target3, target4, target5, target6},
        tip_loc = {tip1, tip2, tip3, tip4, tip5, tip6},
        tip_trash = {tiptrash1, tiptrash2, tiptrash3, tiptrash4, tiptrash5, tiptrash6},
        volume = B,
        joint_anlge_locations = (A == 1 and true or false)
    }

    local json_args = json.encode(action_vars)
    local encoded_args = urlencode(json_args)
    full_url = url .. "&args=" .. encoded_args

    if DEBUG then
        print(json_args)
        print(full_url)
    end

    return string_to_table(full_url)
end

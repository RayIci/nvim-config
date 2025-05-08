-- Public method API table
local M = {}

-- Private method table
local P = {}

local events = {}

---@alias event "plugins-loaded"

---Register an event
---@param event event The event to register
---@param handler function The function to be called when the event is triggered
function M.register(event, handler)
    if events[event] == nil then
        events[event] = {}
    end

    table.insert(events[event], handler)
end

---Dispatch events
---@param event event The event to dispatch
function P.dispatch_events(event)
    if events[event] == nil then
        return
    end

    for _, handler in ipairs(events[event]) do
        handler()
    end
end

_G.mnvim.events = M
return P
